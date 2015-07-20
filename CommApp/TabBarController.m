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
@synthesize centerButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeTabBarView];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"hood.png"] highlightImage:[UIImage imageNamed:@"hood_selected.png"] target:self action:@selector(buttonPressed:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeTabBarView
{
    self.tabBar.tintColor=[UIColor blackColor];
}

- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0) {
        button.center= CGPointMake(self.tabBar.center.x, self.tabBar.center.y-23.0f);
        
    } else {
        CGPoint center = CGPointMake(self.tabBar.center.x, self.tabBar.center.y-23.0f);
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.zPosition=1; //Make add button on the above layer
    
    [self.view addSubview:button];
    self.centerButton = button;
}

- (void)buttonPressed:(id)sender
{
    NSLog(@"pressed");
    [self pressedPopupWindow];
}


-(void)pressedPopupWindow
{
    UIView *popupView=[[UIView alloc]initWithFrame:CGRectMake(0, self.tabBar.center.y-self.tabBar.bounds.size.height-25.0f,[[UIScreen mainScreen]bounds].size.width, 50.0f)];
    popupView.backgroundColor=[UIColor colorWithRed:42.0/255 green:0.0/255 blue:48.0/255 alpha:0.9];
    [self.view addSubview:popupView];
}





- (void)dealloc {
    [_tabBarView release];
    [super dealloc];
}



@end
