//
//  SecondViewController.m
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "NavigationBarMgr.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController

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

@end
