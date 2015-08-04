//
//  FiveViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "F3BarGauge.h"
#import "AppDelegate.h"

@interface MyInfoViewController : UIViewController

{
    
    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *audioRecorder;
    int recordEncoding;
    enum
    {
        ENC_AAC = 1,
        ENC_ALAC = 2,
        ENC_IMA4 = 3,
        ENC_ILBC = 4,
        ENC_ULAW = 5,
        ENC_PCM = 6,
    } encodingTypes;
    
    float Pitch;
    NSTimer *timerForPitch;
}

@property (nonatomic,retain) AppDelegate     *appDelegate;                            //设置appDelegate 用于获取全局变量
@property (nonatomic,assign) CGFloat         screenWidth;                             //屏幕宽
@property (nonatomic,assign) CGFloat         screenHeight;                            //屏幕长


@property (nonatomic,retain) UIView          *backgroundView;
@property (nonatomic,retain) UITableView     *settingTableView;

-(void)initialize;                                                                   //初始化属性
-(void)addNavitionBar;                                                               //添加导航栏
-(void)addBackgroundView;                                                            //添加背景色

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIProgressView *progressView;
@property (retain, nonatomic) IBOutlet UIButton *touchbutton;
@property (retain, nonatomic) IBOutlet UIView *viewForWave;
@property (retain, nonatomic) IBOutlet UIView *viewForWave2;
@property (nonatomic) CFTimeInterval firstTimestamp;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar;
@property (nonatomic) NSUInteger loopCount;
-(IBAction) startRecording;
-(IBAction) stopRecording;
-(IBAction) playRecording;
-(IBAction) stopPlaying;

//LogIn
-(void)popUpLoginAndRegisterAlertView;//点击该界面弹出登录框
@end
