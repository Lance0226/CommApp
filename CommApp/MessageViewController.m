//
//  FourViewController.m
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "MessageViewController.h"
#import "EaseMob.h"
#import "NavigationBarMgr.h"

#import <AVFoundation/AVFoundation.h>

@interface MessageViewController ()<UIAlertViewDelegate,IChatManagerDelegate,UITableViewDelegate,UITableViewDataSource> //登录对话框响应

{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}


@property (retain, nonatomic) IBOutlet UITextField *MessageTextField;
@property (retain, nonatomic)  UITableView *HuanXinChatView; //对话列表,使用的UITableView Controller

@property (retain,nonatomic) NSMutableArray *chatContentList;  //对话内容数组
@property (retain,nonatomic) NSMutableArray *chatFileCategory; //对话发送文件属性
@property (retain,nonatomic) NSMutableArray *chatNameList;    //对话发出者姓名数组
@property (retain,nonatomic) NSMutableArray *chatIsLocalList; //对话发出者是否来自本季，本机为YES,它机为NO

@end

@implementation MessageViewController
@synthesize chatContentList=_chatContentList;




- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavitionBar];
    [self Initialize];
    //[self addRect];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)Initialize //数据初始化
{
    self.HuanXinChatView=[[UITableView alloc] initWithFrame:CGRectMake(0,self.navBar.bounds.size.height*2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*0.75f)];
    [self.view addSubview:self.HuanXinChatView];
    self.HuanXinChatView.separatorStyle=NO;
    self.HuanXinChatView.delegate=self; //添加tableview控制器的委托方法
    self.HuanXinChatView.dataSource=self;//添加tableview数据的委托方法
    
    self.resultArray=[[NSMutableArray alloc]init];
    
    self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.HuanXinUserName=self.appDelegate.HuanXinUserName;
    
    
}

-(void)addNavitionBar
{
    NavigationBarMgr* navBarMgr=[NavigationBarMgr sharedInstance];
    self.navBar=[navBarMgr getNavigationBar];
    [self.view addSubview:self.navBar];
}


-(void)addMsgDataWithName:(NSString *)name Content:(NSString*)content  IsLocal:(BOOL)isLocal FileCategory:(MessageBodyType)fileCategory//将消息组装成Dictionary,插入数组
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:name,@"name",content,@"content",[[NSNumber alloc]initWithBool:isLocal],@"isLocal",[[NSNumber alloc]initWithLong:(long)fileCategory],@"fileCategory",nil];
    [self.resultArray addObject:dict];
}



-(void)didReceiveMessage:(EMMessage *)message
{   //根据消息结构体，确定聊天消息种类
    switch (message.messageType)
    {
        case eMessageTypeChat:      NSLog(@"Chat type is Chat");
            id<IEMMessageBody> messagebody=[message.messageBodies lastObject];//由于只传一个messagebody对象
            switch (messagebody.messageBodyType) {
                case eMessageBodyType_Text:
                    [self addReceiverInfo:message];
                    [self updateHuanXinChatView];
                break;
                case eMessageBodyType_Image:
                    [self addReceiverInfo:message];
                    [self updateHuanXinChatView];
                break;
                default:break;
            }
            break;
        case eMessageTypeChatRoom:  NSLog(@"Chat type is ChatRoom");break;
        case eMessageTypeGroupChat: NSLog(@"Chat type is GroupcChat");break;
    }
}

- (IBAction)HuanXinSend:(id)sender
{
   
    [self addSenderInfo:eMessageBodyType_Text];
    EMChatText *texChat=[[EMChatText alloc] initWithText:self.MessageTextField.text];
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithChatObject:texChat];
    [self updateHuanXinChatView]; //刷新聊天列表
    EMMessage *message=[[EMMessage alloc]initWithReceiver:self.HuanXinUserName bodies:@[body]];
    [message setMessageType:eMessageTypeChat]; //设置为单聊模式
    [message setDeliveryState:eMessageDeliveryState_Delivered];
    [[EaseMob sharedInstance].chatManager sendMessage:message progress:nil error:nil];
}
- (IBAction)HuanXinImgSend:(id)sender
{
    
    [self addSenderInfo:eMessageBodyType_Image];
    EMChatImage *imgChat=[[EMChatImage alloc] initWithUIImage:[UIImage imageNamed:@"head"] displayName:@"displayname"];
    EMImageMessageBody *body=[[EMImageMessageBody alloc] initWithChatObject:imgChat];
    EMMessage *message=[[EMMessage alloc]initWithReceiver:self.HuanXinUserName bodies:@[body]];
    [message setMessageType:eMessageTypeChat];//设置为单聊模式
    [message setDeliveryState:eMessageDeliveryState_Delivered];
    [[EaseMob sharedInstance].chatManager sendMessage:message progress:nil error:nil];
   
}

-(void)updateHuanXinChatView
{
    [self.HuanXinChatView reloadData];//刷新列表
    [self.HuanXinChatView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    

}


//添加发送信息
-(void)addSenderInfo:(MessageBodyType)fileCategory
{

    [self addMsgDataWithName:self.HuanXinUserName Content:self.MessageTextField.text IsLocal:YES FileCategory:fileCategory];

   
}

//添加接受信息
-(void)addReceiverInfo:(EMMessage *)message
{

    id<IEMMessageBody> messagebody=[message.messageBodies lastObject];//由于只传一个messagebody对象
    
    if (((EMTextMessageBody *)messagebody).messageBodyType==eMessageBodyType_Text) {
        [self addMsgDataWithName:message.from Content:((EMTextMessageBody *)messagebody).text IsLocal:NO FileCategory:eMessageBodyType_Text];
    }
    if (((EMTextMessageBody *)messagebody).messageBodyType==eMessageBodyType_Image) {
        [self addMsgDataWithName:message.from Content:((EMImageMessageBody *)messagebody).thumbnailLocalPath IsLocal:NO FileCategory:eMessageBodyType_Image];
    }
    
}

//-----------------------------------------------------
//泡泡文本
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf withPosition:(int)position{
    
    //计算大小
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:@{NSFontAttributeName: font}];
    CGRect rect=[attributedText boundingRectWithSize:CGSizeMake(180.0f, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize size=rect.size;
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    //背影图片
    UIImage *bubble = [UIImage imageNamed:fromSelf?@"SenderAppNodeBkg_HL":@"ReceiverTextNodeBkg"];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/2)]];
    NSLog(@"%f,%f",size.width,size.height);
    
    
    //添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf?15.0f:22.0f, 20.0f, size.width+10, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    bubbleText.text = text;
    
    bubbleImageView.frame = CGRectMake(0.0f, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
    
    if(fromSelf)
        returnView.frame = CGRectMake(320-position-(bubbleText.frame.size.width+30.0f), 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    else
        returnView.frame = CGRectMake(position, 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    
    [returnView addSubview:bubbleImageView];
    [returnView addSubview:bubbleText];
    
    return returnView;
}

//泡泡语音
- (UIView *)yuyinView:(NSInteger)logntime from:(BOOL)fromSelf withIndexRow:(NSInteger)indexRow  withPosition:(int)position{
    
    //根据语音长度
    int yuyinwidth = 66+fromSelf;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = indexRow;
    if(fromSelf)
        button.frame =CGRectMake(320-position-yuyinwidth, 10, yuyinwidth, 54);
    else
        button.frame =CGRectMake(position, 10, yuyinwidth, 54);
    
    //image偏移量
    UIEdgeInsets imageInsert;
    imageInsert.top = -10;
    imageInsert.left = fromSelf?button.frame.size.width/3:-button.frame.size.width/3;
    button.imageEdgeInsets = imageInsert;
    
    [button setImage:[UIImage imageNamed:fromSelf?@"SenderVoiceNodePlaying":@"ReceiverVoiceNodePlaying"] forState:UIControlStateNormal];
    UIImage *backgroundImage = [UIImage imageNamed:fromSelf?@"SenderVoiceNodeDownloading":@"ReceiverVoiceNodeDownloading"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fromSelf?-30:button.frame.size.width, 0, 30, button.frame.size.height)];
    label.text = [NSString stringWithFormat:@"%ld''",(long)logntime];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [button addSubview:label];
    
    return button;
}

#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.resultArray objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [[dict objectForKey:@"content"] sizeWithFont:font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        for (UIView *cellView in cell.subviews){
            [cellView removeFromSuperview];
        }
    }
    
    NSDictionary *dict = [self.resultArray objectAtIndex:indexPath.row];
    
    //创建头像
    UIImageView *photo ;
    if ([[dict objectForKey:@"isLocal"] isEqualToNumber:[[NSNumber alloc]initWithBool:YES]]) {
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(320-60, 10, 50, 50)];
        [cell addSubview:photo];
        photo.image = [UIImage imageNamed:@"photo1"];
        
        if ([[dict objectForKey:@"content"] isEqualToString:@"0"]) {
            [cell addSubview:[self yuyinView:1 from:YES withIndexRow:indexPath.row withPosition:65]];
            
            
        }else{
            [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] from:YES withPosition:65]];
        }
        
    }else{
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [cell addSubview:photo];
        photo.image = [UIImage imageNamed:@"photo"];
        
        if ([[dict objectForKey:@"content"] isEqualToString:@"0"]) {
            [cell addSubview:[self yuyinView:1 from:NO withIndexRow:indexPath.row withPosition:65]];
        }else{
            [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] from:NO withPosition:65]];
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//-----------------------------------------------------------------
- (void)dealloc
{
    [_MessageTextField release];
    [_HuanXinChatView release];
    [super dealloc];
}
@end
