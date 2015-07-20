//
//  TabBarController.m
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()
@property (retain, nonatomic) IBOutlet UITabBar *tabBarView;

@end

@implementation TabBarController
@synthesize tabBarView=_tabBarView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeTabBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeTabBarView
{
    self.tabBar.tintColor=[UIColor blackColor];
}

- (void)dealloc {
    [_tabBarView release];
    [super dealloc];
}



@end
