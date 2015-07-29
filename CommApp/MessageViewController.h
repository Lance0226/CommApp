//
//  FourViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MessageViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (retain, nonatomic) IBOutlet UIButton *stopButton;
@property (retain, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)recordPauseTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)playTapped:(id)sender;


-(void)addNavitionBar;  //添加导航栏
-(void)popUpLoginAndRegisterAlertView;//点击该界面弹出登录框
@end
