//
//  FourViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface MessageViewController : UIViewController

@property (nonatomic,retain) NSMutableArray  *resultArray;//对话列表数据
@property (nonatomic,retain) UINavigationBar *navBar;

@property (nonatomic,retain) AppDelegate     *appDelegate;

@property (nonatomic,retain) NSString        *HuanXinUserName;//用户名

-(void)addNavitionBar;  //添加导航栏
@end
