//
//  FourViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MessageViewController : UIViewController

@property (nonatomic,retain) NSMutableArray *resultArray;//对话列表数据
@property (nonatomic,retain) UINavigationBar *navBar;

-(void)addNavitionBar;  //添加导航栏
-(void)popUpLoginAndRegisterAlertView;//点击该界面弹出登录框
@end
