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

@interface MessageViewController ()<UIAlertViewDelegate,EMChatManagerLoginDelegate,IChatManagerDelegate,UITableViewDelegate,UITableViewDataSource> //登录对话框响应

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
    [self Initialize];
    [self addNavitionBar];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [self popUpLoginAndRegisterAlertView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)Initialize //数据初始化
{
    self.HuanXinChatView=[[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.25f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*0.75f)];
    [self.view addSubview:self.HuanXinChatView];
    self.HuanXinChatView.separatorStyle=NO;
    self.HuanXinChatView.delegate=self; //添加tableview控制器的委托方法
    self.HuanXinChatView.dataSource=self;//添加tableview数据的委托方法
    
    self.chatContentList=[[NSMutableArray alloc]init];
    self.chatNameList=[[NSMutableArray alloc]init];
    self.chatIsLocalList=[[NSMutableArray alloc]init];
    
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
    NavigationBarMgr* navBar=[NavigationBarMgr sharedInstance];
    UINavigationBar *bar=[navBar getNavigationBar];
    [self.view addSubview:bar];
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




- (void)dealloc
{
    [_MessageTextField release];
    [_HuanXinChatView release];
    [super dealloc];
}
@end
