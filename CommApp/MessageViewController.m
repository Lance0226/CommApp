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

@interface MessageViewController ()<UIAlertViewDelegate,EMChatManagerLoginDelegate,IChatManagerDelegate> //登录对话框响应
@property (retain, nonatomic) IBOutlet UITextField *HuanXinUsername;//登陆用户，用户名
@property (retain, nonatomic) IBOutlet UITextField *HuanXinpassword;//登陆用户 密码


@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavitionBar];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [self popUpLoginAndRegisterAlertView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)popUpLoginAndRegisterAlertView  //输入用户名密码登录
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"登录或注册"
                           
                                                      message:@"请登录"
                           
                                                      delegate:self
                           
                                                      cancelButtonTitle:@"取消"
                           
                                                      otherButtonTitles:@"登录",@"注册",nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField *usernameTextField=[alert textFieldAtIndex:0];
    UITextField *passwordTextField=[alert textFieldAtIndex:1];
    [alert show];
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  //响应登录框提交事件
{
    NSLog(@"%ld",(long)buttonIndex);
}


-(void)addNavitionBar
{
    NavigationBarMgr* navBar=[NavigationBarMgr sharedInstance];
    UINavigationBar *bar=[navBar getNavigationBar];
    [self.view addSubview:bar];
}

- (IBAction)HuanXinRegister:(id)sender
{
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.HuanXinUsername.text password:self.HuanXinpassword.text];
}

- (IBAction)HuanXinLogin:(id)sender
{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.HuanXinUsername.text
                      password:self.HuanXinpassword.text];
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
        
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"登陆失败" message:errorChnDescription delegate:nil
                                                       cancelButtonTitle:@"好" otherButtonTitles:nil];
        [AlertView show];
    }
    else
    {
      
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
        
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"注册失败" message:errorChnDescription delegate:nil
                                                       cancelButtonTitle:@"好" otherButtonTitles:nil];
        [AlertView show];
        NSLog(@"注册失败");

    }
    else
    {
        UIAlertView *scussessAlertView=[[UIAlertView alloc]initWithTitle:@"注册成功" message:@"恭喜您注册成为勾勾会员" delegate:nil
                                                           cancelButtonTitle:@"好" otherButtonTitles:nil];
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
                    [self dealwithTextMessage:(EMTextMessageBody *)messagebody];
                NSLog(@"output+%@",((EMTextMessageBody *)messagebody).text);
                break;
                default:break;
            }
            break;
        case eMessageTypeChatRoom:  NSLog(@"Chat type is ChatRoom");break;
        case eMessageTypeGroupChat: NSLog(@"Chat type is GroupcChat");break;
    }
}

-(NSString *)dealwithTextMessage :(EMTextMessageBody *)message
{
    return message.text;
}

- (IBAction)HuanXINSend:(id)sender
{
    EMChatText *texChat=[[EMChatText alloc] initWithText:@"abcdefg"];
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithChatObject:texChat];
    EMMessage *message=[[EMMessage alloc]initWithReceiver:self.HuanXinUsername.text bodies:@[body]];
    [message setMessageType:eMessageTypeChat]; //设置为单聊模式
    [message setDeliveryState:eMessageDeliveryState_Delivered];
    [[EaseMob sharedInstance].chatManager sendMessage:message progress:nil error:nil];
}



- (void)dealloc {
    [_HuanXinUsername release];
    [_HuanXinpassword release];
    [super dealloc];
}
@end
