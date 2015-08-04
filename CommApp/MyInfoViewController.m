//
//  FiveViewController.m
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "MyInfoViewController.h"
#import "NavigationBarMgr.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

#import "EaseMob.h"

@interface MyInfoViewController ()<UIAlertViewDelegate,EMChatManagerLoginDelegate,EMChatManagerDelegate>//添加登录Delegate和提示框Delegate

@property (retain,nonatomic) UITextField *usernameHuanXinTextField;

@property (retain,nonatomic) UITextField *passwordHuanXinTextField;

@end

@implementation MyInfoViewController

@synthesize backgroundView=_backgroundView;
@synthesize settingTableView=_settingTableView;
@synthesize appDelegate=_appDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initialize];
    [self addNavitionBar]; //添加导航栏
    [self addBackgroundView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(myButtonLongPressed:)];
    // you can control how many seconds before the gesture is recognized
    gesture.minimumPressDuration =0;
    [self.touchbutton addGestureRecognizer:gesture];
    
    
    [self popUpLoginAndRegisterAlertView];//弹出登录框
    
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];  //用于登录委托
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialize
{
    self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.screenWidth=self.appDelegate.SCREEN_WIDTH;
    self.screenHeight=self.appDelegate.SCREEN_HEIGHT;
}

-(void)addNavitionBar
{
    NavigationBarMgr* navBar=[NavigationBarMgr sharedInstance];
    UINavigationBar *bar=[navBar getNavigationBar];
    [bar.layer setZPosition:222];  //将导航栏至于最前
    [self.view addSubview:bar];
}

-(void)addBackgroundView
{
    self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.screenWidth, self.screenHeight)];
    [self.backgroundView setBackgroundColor:[UIColor blackColor]];
    [self.backgroundView.layer setZPosition:111];
    [self.view addSubview:self.backgroundView];
}

- (void)addShapeLayer
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [[self pathAtInterval:2.0] CGPath];
    self.shapeLayer.fillColor = [[UIColor redColor] CGColor];
    self.shapeLayer.lineWidth = 1.0;
    self.shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    [self.viewForWave.layer addSublayer:self.shapeLayer];
}

- (void)startDisplayLink
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopDisplayLink
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    if (!self.firstTimestamp)
        self.firstTimestamp = displayLink.timestamp;
    
    self.loopCount++;
    
    NSTimeInterval elapsed = (displayLink.timestamp - self.firstTimestamp);
    
    self.shapeLayer.path = [[self pathAtInterval:elapsed] CGPath];
    
    //    if (elapsed >= kSeconds)
    //    {
    //       // [self stopDisplayLink];
    //        self.shapeLayer.path = [[self pathAtInterval:0] CGPath];
    //
    //        self.statusLabel.text = [NSString stringWithFormat:@"loopCount = %.1f frames/sec", self.loopCount / kSeconds];
    //    }
}

- (UIBezierPath *)pathAtInterval:(NSTimeInterval) interval
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, self.viewForWave.bounds.size.height / 2.0)];
    
    CGFloat fractionOfSecond = interval - floor(interval);
    
    CGFloat yOffset = self.viewForWave.bounds.size.height * sin(fractionOfSecond * M_PI * Pitch*8);
    
    [path addCurveToPoint:CGPointMake(self.viewForWave.bounds.size.width, self.viewForWave.bounds.size.height / 2.0)
            controlPoint1:CGPointMake(self.viewForWave.bounds.size.width / 2.0, self.viewForWave.bounds.size.height / 2.0 - yOffset)
            controlPoint2:CGPointMake(self.viewForWave.bounds.size.width / 2.0, self.viewForWave.bounds.size.height / 2.0 + yOffset)];
    
    return path;
}

- (void) myButtonLongPressed:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Touch down");
        
        [self.touchbutton setBackgroundImage:[UIImage imageNamed:@"listing_done_btn~iphone.png"] forState:UIControlStateNormal];
        [self startRecording];
        
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"Long press Ended");
        [self stopRecording];
        [self.touchbutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
}

-(IBAction) startRecording
{
    self.viewForWave.hidden = NO;
    [self addShapeLayer];
    [self startDisplayLink];
    // kSeconds = 150.0;
    NSLog(@"startRecording");
    audioRecorder = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    if(recordEncoding == ENC_PCM)
    {
        [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    }
    else
    {
        NSNumber *formatObject;
        
        switch (recordEncoding) {
            case (ENC_AAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatMPEG4AAC];
                break;
            case (ENC_ALAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleLossless];
                break;
            case (ENC_IMA4):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
                break;
            case (ENC_ILBC):
                formatObject = [NSNumber numberWithInt: kAudioFormatiLBC];
                break;
            case (ENC_ULAW):
                formatObject = [NSNumber numberWithInt: kAudioFormatULaw];
                break;
            default:
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
        }
        
        [recordSettings setObject:formatObject forKey: AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];
    }
    
    //    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"recordTest.caf"];
    
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    
    
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
    audioRecorder.meteringEnabled = YES;
    if ([audioRecorder prepareToRecord] == YES){
        audioRecorder.meteringEnabled = YES;
        [audioRecorder record];
        timerForPitch =[NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }else {
        int errorCode = CFSwapInt32HostToBig ([error code]);
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
        
    }
    
}

- (void)levelTimerCallback:(NSTimer *)timer {
    [audioRecorder updateMeters];
    NSLog(@"Average input: %f Peak input: %f", [audioRecorder averagePowerForChannel:0], [audioRecorder peakPowerForChannel:0]);
    
    float linear = pow (10, [audioRecorder peakPowerForChannel:0] / 20);
    NSLog(@"linear===%f",linear);
    float linear1 = pow (10, [audioRecorder averagePowerForChannel:0] / 20);
    NSLog(@"linear1===%f",linear1);
    if (linear1>0.03) {
        
        Pitch = linear1+.20;//pow (10, [audioRecorder averagePowerForChannel:0] / 20);//[audioRecorder peakPowerForChannel:0];
    }
    else {
        
        Pitch = 0.0;
    }
    //Pitch =linear1;
    NSLog(@"Pitch==%f",Pitch);
    _customRangeBar.value = Pitch;//linear1+.30;
    [_progressView setProgress:Pitch];
    float minutes = floor(audioRecorder.currentTime/60);
    float seconds = audioRecorder.currentTime - (minutes * 60);
    
    NSString *time = [NSString stringWithFormat:@"%0.0f.%0.0f",minutes, seconds];
    [self.statusLabel setText:[NSString stringWithFormat:@"%@ sec", time]];
    NSLog(@"recording");
    
}
-(IBAction) stopRecording
{
    NSLog(@"stopRecording");
    // kSeconds = 0.0;
    self.viewForWave.hidden = YES;
    [audioRecorder stop];
    NSLog(@"stopped");
    [self stopDisplayLink];
    self.shapeLayer.path = [[self pathAtInterval:0] CGPath];
    [timerForPitch invalidate];
    timerForPitch = nil;
    _customRangeBar.value = 0.0;
}

-(IBAction) playRecording
{
    NSLog(@"playRecording");
    // Init audio with playback capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"recordTest.caf"];
    
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    
    // NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];
    NSLog(@"playing");
}

-(IBAction) stopPlaying
{
    NSLog(@"stopPlaying");
    [audioPlayer stop];
    NSLog(@"stopped");
    
}


//--------------------------------------------------------------------------------------------
#pragma mark --- Login Module
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
        self.appDelegate.HuanXinUserName=self.usernameHuanXinTextField.text;
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"登陆成功" message:@"登录成功" delegate:self
                                               cancelButtonTitle:@"好" otherButtonTitles:nil];
        //登录成功，将用户名、密码提交给appdelegate作全局变量
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
//委托方法 回调登陆状态信息

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


//--------------------------------------------------------------------------------------------
-(void)dealloc
{
    [super dealloc];
}





@end
