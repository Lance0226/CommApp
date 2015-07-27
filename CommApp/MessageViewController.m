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
@property (retain, nonatomic) IBOutlet UITableView *HuanXinChatView; //对话列表

@property (retain,nonatomic) NSMutableArray *chatList;
@property (assign) bool flag;

@end

@implementation MessageViewController
@synthesize usernameHuanXinTextField=_usernameHuanXinTextField;
@synthesize passwordHuanXinTextField=_passwordHuanXinTextField;
@synthesize chatList=_chatList;



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
    self.chatList=[[NSMutableArray alloc]init];
    self.flag=YES;
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
                    [self dealwithTextMessage:(EMTextMessageBody *)messagebody];
                    [self.chatList addObject:((EMTextMessageBody *)messagebody).text];
                NSLog(@"output+%@",((EMTextMessageBody *)messagebody).text);
                    [self.HuanXinChatView reloadData];
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
    [self.chatList addObject:self.MessageTextField.text];
    EMChatText *texChat=[[EMChatText alloc] initWithText:self.MessageTextField.text];
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithChatObject:texChat];
    EMMessage *message=[[EMMessage alloc]initWithReceiver:self.usernameHuanXinTextField.text bodies:@[body]];
    [message setMessageType:eMessageTypeChat]; //设置为单聊模式
    [message setDeliveryState:eMessageDeliveryState_Delivered];
    [[EaseMob sharedInstance].chatManager sendMessage:message progress:nil error:nil];
}

//----------------------------------------------
//对话列表
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    NSUInteger row = [indexPath row];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.textLabel.text=[self.chatList objectAtIndex:row];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.chatList count];
}



- (void)dealloc
{
    [_MessageTextField release];
    [_HuanXinChatView release];
    [super dealloc];
}
@end
