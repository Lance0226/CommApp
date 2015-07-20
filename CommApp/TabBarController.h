//
//  TabBarController.h
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController

@property(nonatomic, strong) IBOutlet UIButton *centerButton;
- (void)buttonPressed:(id)sender;
-(void)changeTabBarView;
-(void)pressedPopupWindow;   //Press add logo,the edit tab would be poped up;

@end
