//
//  FiveViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyInfoViewController : UIViewController

@property (nonatomic,retain) UIView* backgroundView;
@property (nonatomic,retain) UITableView* settingTableView;
-(void)addNavitionBar;//添加导航栏
-(void)addBackgroundView;//添加背景色
@end
