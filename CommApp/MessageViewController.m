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

@interface MessageViewController ()<UIAlertViewDelegate,EMChatManagerLoginDelegate,IChatManagerDelegate,UITableViewDelegate,UITableViewDataSource,AVAudioRecorderDelegate,AVAudioPlayerDelegate> //登录对话框响应

{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (retain,nonatomic) UITextField *usernameHuanXinTextField;

@property (retain,nonatomic) UITextField *passwordHuanXinTextField;
@property (retain, nonatomic) IBOutlet UITextField *MessageTextField;
@property (retain, nonatomic)  UITableView *HuanXinChatView; //对话列表,使用的UITableView Controller

@property (retain,nonatomic) NSMutableArray *chatContentList;  //对话内容数组
@property (retain,nonatomic) NSMutableArray *chatNameList;    //对话发出者姓名数组
@property (retain,nonatomic) NSMutableArray *chatIsLocalList; //对话发出者是否来自本季，本机为YES,它机为NO

@end

@implementation MessageViewController
@synthesize usernameHuanXinTextField=_usernameHuanXinTextField;
@synthesize passwordHuanXinTextField=_passwordHuanXinTextField;
@synthesize chatContentList=_chatContentList;




- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavitionBar];
    [self Initialize];
    //[self addRect];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [self popUpLoginAndRegisterAlertView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)Initialize //数据初始化
{
    self.HuanXinChatView=[[UITableView alloc] initWithFrame:CGRectMake(0,self.navBar.bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*0.75f)];
    [self.view addSubview:self.HuanXinChatView];
    self.HuanXinChatView.separatorStyle=NO;
    self.HuanXinChatView.delegate=self; //添加tableview控制器的委托方法
    self.HuanXinChatView.dataSource=self;//添加tableview数据的委托方法
    
    //self.chatContentList=[[NSMutableArray alloc]init];
    //self.chatNameList=[[NSMutableArray alloc]init];
    //self.chatIsLocalList=[[NSMutableArray alloc]init];
    [self initData];
    
}

-(void)initData
{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin",@"name",@"微信团队欢迎你。很高兴你开启了微信生活，期待能为你和朋友们带来愉快的沟通体检。",@"content", nil];
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",@"hello",@"content", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",@"0",@"content", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin",@"name",@"谢谢反馈，已收录。",@"content", nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",@"0",@"content", nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin",@"name",@"谢谢反馈，已收录。",@"content", nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",@"大数据测试，长数据测试，大数据测试，长数据测试，大数据测试，长数据测试，大数据测试，长数据测试，大数据测试，长数据测试，大数据测试，长数据测试。",@"content", nil];
    
    self.resultArray = [NSMutableArray arrayWithObjects:dict,dict1,dict2,dict3,dict4,dict5,dict6, nil];
}



-(void)addRect //由一个三角形和一个矩形组成一个对话框底层
{
    CAShapeLayer *triangle=[[CAShapeLayer alloc]init];
    CAShapeLayer *rect=[[CAShapeLayer alloc]init];
    UIBezierPath *path=[UIBezierPath new];
    UIBezierPath *roundRectPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 100, 200, 100) cornerRadius:5];
    [path moveToPoint:CGPointMake(220,117)];
    [path addLineToPoint:CGPointMake(227, 125)];
    [path addLineToPoint:CGPointMake(220, 133)];
    [path closePath];
    [triangle setPath:[path CGPath]];
    [rect setPath:[roundRectPath CGPath]];
    [rect setFillColor:[[UIColor purpleColor] CGColor]];
    [triangle setFillColor:[[UIColor purpleColor] CGColor]];
    [triangle setZPosition:999];
    [self.view.layer addSublayer:(CALayer*)triangle];
    [self.view.layer addSublayer:(CALayer*)rect];
}

-(void)popUpLoginAndRegisterAlertView  //输入用户名密码登录
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"登录或注册"
                           
                                                      message:@"请登录"
                           
                                                      delegate:self
                           
                                                      cancelButtonTitle:@"取消"
                           
                                                      otherButtonTitles:@"登录",@"注册",nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    self.usernameHuanXinTextField=[alert textFieldAtIndex:0];
    self.passwordHuanXinTextField=[alert textFieldAtIndex:1];
    [alert setTag:1000];//设置登录框标签为1000
    [alert show];
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  //响应登录框提交事件
{
    if (alertView.tag==1000)
    {
           if (buttonIndex==1)
           {
             //登录
             [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.usernameHuanXinTextField.text
                                                                 password:self.passwordHuanXinTextField.text];
           }
          else if(buttonIndex==2)
          {
             //注册
             [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.usernameHuanXinTextField.text
                                                                 password:self.passwordHuanXinTextField.text];
          }
          else
          {
              NSLog(@"错误");
          }
     }
    else if(alertView.tag==2000)
    {   //重新登录
        if (buttonIndex==1)
        {
            [self popUpLoginAndRegisterAlertView];
        }
    }
    else if(alertView.tag==3000)
    {   //重新注册
        if (buttonIndex==1)
        {
            [self popUpLoginAndRegisterAlertView];
        }
    }
    else if(alertView.tag==4000)
    {   //注册成功，登录
        if (buttonIndex==1)
        {
            [self popUpLoginAndRegisterAlertView];
        }
    }
    else
    {
        NSLog(@"ERROR");
    }
    
    
}


-(void)addNavitionBar
{
    NavigationBarMgr* navBarMgr=[NavigationBarMgr sharedInstance];
    self.navBar=[navBarMgr getNavigationBar];
    [self.view addSubview:self.navBar];
}


//委托方法 回调登陆状态信息
-(void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
    NSLog(@"tttttttt+%@",error.description);
    
    
    if (error!=nil)
    {
        NSLog(@"%ld",(long)error.description);//错误代码
        //根据错误信息编号，弹出对应错误信息
        NSString *errorChnDescription;
        switch (error.errorCode)
        {
                case EMErrorNotFound:                          errorChnDescription=@"用户名不存在";break;
                case EMErrorServerAuthenticationFailure:       errorChnDescription=@"用户名或密码错误";break;
                default:                                       errorChnDescription=@"未知错误";break;
        }
        
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"登陆失败" message:errorChnDescription delegate:self
                                                    cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录",nil];
        [AlertView setTag:2000];
        [AlertView show];
    }
    else
    {
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"登陆成功" message:@"登录成功" delegate:self
                                               cancelButtonTitle:@"好" otherButtonTitles:nil];
        [AlertView show];
    }
   
    
    NSEnumerator *loginKeyEnum=[loginInfo keyEnumerator];
    for (NSObject *obj1 in loginKeyEnum)
    {
        NSLog(@"lllllllllllllllllllll+%@",obj1);
    }
    NSEnumerator *loginValueEnum=[loginInfo objectEnumerator];
    for (NSObject *obj2 in loginValueEnum )
    {
        NSLog(@"fffffffffffffff+%@",obj2);
    }
}

//委托方法 回调注册账户信息
-(void)didRegisterNewAccount:(NSString *)username password:(NSString *)password error:(EMError *)error
{
    if (error!=nil)
    {
        NSLog(@"%ld",(long)error.description);//错误代码
        //根据错误信息编号，弹出对应错误信息
        NSString *errorChnDescription;
        switch (error.errorCode)
        {
                case EMErrorServerDuplicatedAccount: errorChnDescription=@"用户名已存在";break;
                default:                             errorChnDescription=@"未知错误";break;
        }
        
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"注册失败" message:errorChnDescription delegate:self
                                                       cancelButtonTitle:@"好" otherButtonTitles:@"重新注册",nil];
        [AlertView setTag:3000];
        [AlertView show];
        NSLog(@"注册失败");

    }
    else
    {
        UIAlertView *scussessAlertView=[[UIAlertView alloc]initWithTitle:@"注册成功" message:@"恭喜您注册成为勾勾会员" delegate:self
                                                       cancelButtonTitle:@"好" otherButtonTitles:@"登录",nil];
        [scussessAlertView setTag:4000];
        [scussessAlertView show];
        NSLog(@"注册成功");
    }
    
   
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
                default:break;
            }
            break;
        case eMessageTypeChatRoom:  NSLog(@"Chat type is ChatRoom");break;
        case eMessageTypeGroupChat: NSLog(@"Chat type is GroupcChat");break;
    }
}

- (IBAction)HuanXINSend:(id)sender
{
    [self addSenderInfo];
    EMChatText *texChat=[[EMChatText alloc] initWithText:self.MessageTextField.text];
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithChatObject:texChat];
    [self updateHuanXinChatView]; //刷新聊天列表
    EMMessage *message=[[EMMessage alloc]initWithReceiver:self.usernameHuanXinTextField.text bodies:@[body]];
    [message setMessageType:eMessageTypeChat]; //设置为单聊模式
    [message setDeliveryState:eMessageDeliveryState_Delivered];
    [[EaseMob sharedInstance].chatManager sendMessage:message progress:nil error:nil];
}

-(void)updateHuanXinChatView
{
    [self.HuanXinChatView reloadData];//刷新列表
    [self.HuanXinChatView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

}


//添加发送信息
-(void)addSenderInfo
{
    [self.chatNameList addObject:self.usernameHuanXinTextField.text];
    [self.chatContentList addObject:self.MessageTextField.text];
    [self.chatIsLocalList addObject:[[NSNumber alloc]initWithBool:YES]];
}

//添加接受信息
-(void)addReceiverInfo:(EMMessage *)message
{
    id<IEMMessageBody> messagebody=[message.messageBodies lastObject];//由于只传一个messagebody对象
    [self.chatContentList addObject:((EMTextMessageBody *)messagebody).text];
    [self.chatNameList addObject:message.from];
    [self.chatIsLocalList addObject:[[NSNumber alloc] initWithBool:NO]];
}

//----------------------------------------------
/*
#pragma mark - "TabelViewController Method"
//对话列表
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    NSUInteger row = [indexPath row];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        CALayer *nameLayer=[self setNameLayerWithRowIndex:row];
        CALayer *contentLayer=[self setContentLayerWithRowIndex:row];
        [cell.layer addSublayer:nameLayer];
        [cell.layer addSublayer:contentLayer];
    }
    return cell;
    
}
// 设置TableViewController的行数

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chatContentList count];
}
//姓名框
-(CALayer*)setNameLayerWithRowIndex:(NSUInteger )rowIndex
{
    CATextLayer *nameLayer=[[CATextLayer alloc]init];
    [nameLayer setFont:@"HelveticaNeue"];
    [nameLayer setFontSize:15];
    [nameLayer setString:[self.chatNameList objectAtIndex:rowIndex]];
    [nameLayer setAlignmentMode:kCAAlignmentCenter];
    [nameLayer setForegroundColor:[[UIColor grayColor] CGColor]];
    
    BOOL isLocal=[[self.chatIsLocalList objectAtIndex:rowIndex]boolValue];//查看数据是否来自本地
    //本地显示在右，远端显示在左
    if (isLocal==YES)
    {
        [nameLayer setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 50, 30)];
    }
    else
    {
    [nameLayer setFrame:CGRectMake(20, 0, 50, 30)];
    }
    return nameLayer;
}

//对话内容框
-(CALayer*)setContentLayerWithRowIndex:(NSUInteger )rowIndex
{
    CATextLayer *nameLayer=[[CATextLayer alloc]init];
    [nameLayer setFont:@"HelveticaNeue"];
    [nameLayer setFontSize:15];
    [nameLayer setString:[self.chatContentList objectAtIndex:rowIndex]];
    [nameLayer setAlignmentMode:kCAAlignmentCenter];
    [nameLayer setForegroundColor:[[UIColor grayColor] CGColor]];
    
    BOOL isLocal=[[self.chatIsLocalList objectAtIndex:rowIndex]boolValue];//查看数据是否来自本地
    //本地显示在右，远端显示在左
    if (isLocal==YES)
    {
        [nameLayer setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 30, 50, 30)];
    }
    else
    {
        [nameLayer setFrame:CGRectMake(20, 30, 50, 30)];
    }
    return nameLayer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
 */
//-----------------------------------------------------------------
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
    if ([[dict objectForKey:@"name"]isEqualToString:@"rhl"]) {
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
