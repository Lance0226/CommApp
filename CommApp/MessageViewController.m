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

@interface MessageViewController ()<EMChatManagerLoginDelegate>
@property (retain, nonatomic) IBOutlet UITextField *HuanXinUsername;//登陆用户，用户名
@property (retain, nonatomic) IBOutlet UITextField *HuanXinpassword;//登陆用户 密码

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavitionBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"LOGIN ERROR-%@",error);
}

//委托方法 回调注册账户信息
-(void)didRegisterNewAccount:(NSString *)username password:(NSString *)password error:(EMError *)error
{
    NSLog(@"REGISTER ERROR-%@",error);
}
/*- (IBAction)HuanXINSend:(id)sender
{
    EMChatText *texChat=[[EMChatText alloc] initWithText:@"abcdefg"];
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithChatObject:texChat];
    
    EMMessage *mesage=[[EMMessage alloc]initWithReceiver:self.HuanXinUsername.text bodies:@[body]];
    [mesage setMessageType:eMessageTypeChat]; //设置为单聊模式
    [mesage setDeliveryState:eMessageDeliveryState_Delivered];
    [[EaseMob sharedInstance].chatManager insertMessagesToDB:mesage];
}
*/


- (void)dealloc {
    [_HuanXinUsername release];
    [_HuanXinpassword release];
    [super dealloc];
}
@end
