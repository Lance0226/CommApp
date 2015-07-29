//
//  FiveViewController.m
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "MyInfoViewController.h"
#import "NavigationBarMgr.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController
@synthesize backgroundView=_backgroundView;
@synthesize settingTableView=_settingTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavitionBar]; //添加导航栏
    [self addBackgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.backgroundView setBackgroundColor:[UIColor blackColor]];
    [self.backgroundView.layer setZPosition:111];
    [self.view addSubview:self.backgroundView];
}




@end
