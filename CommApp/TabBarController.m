//
//  TabBarController.m
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()
@property (retain, nonatomic) IBOutlet UITabBar *m_tabBarView;

@end

@implementation TabBarController

@synthesize m_tabBarView=_m_tabBarView;
@synthesize m_popupView=_m_popupView;

@synthesize m_centerBtn;  //Plus Button
@synthesize m_isPopupViewDisplay;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self changeTabBarView];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"hood.png"] highlightImage:[UIImage imageNamed:@"hood_selected.png"] target:self action:@selector(buttonPressed:)];
}

-(void)initialize
{
    self.m_isPopupViewDisplay=false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeTabBarView
{
    self.tabBar.tintColor=[UIColor blackColor];
}

-(void)addBtnOnPopupWindowWithTag:(NSInteger)tag NormalImage:(UIImage *)btnImage PopupView:(UIView *)popupView andCenter:(CGPoint)center
{
    UIButton* onpopupBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat gouyigouRatio=btnImage.size.width/btnImage.size.height;
    onpopupBtn.frame=CGRectMake(0.0f,0.0f,popupView.frame.size.height*gouyigouRatio,popupView.frame.size.height);
    [onpopupBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [onpopupBtn setBackgroundImage:btnImage forState:UIControlStateHighlighted];
    onpopupBtn.center=CGPointMake(popupView.center.x+center.x, popupView.center.y+center.y);
    onpopupBtn.layer.zPosition=2;
    
    [onpopupBtn setTag:tag];
    [self.view addSubview:onpopupBtn];
    
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
    self.m_centerBtn = button;
}

- (void)buttonPressed:(id)sender
{
    NSLog(@"pressed");
    if (self.m_isPopupViewDisplay==false)
    {
        [self showPopupWindow];
        self.m_isPopupViewDisplay=true;
    }
    else
    {
        [self closePopupWindow];
        self.m_isPopupViewDisplay=false;
    }
    
    
}


-(void)showPopupWindow
{
    self.m_popupView=[[UIView alloc]initWithFrame:CGRectMake(0, self.tabBar.center.y-self.tabBar.bounds.size.height-10.0f,[[UIScreen mainScreen]bounds].size.width, 35.0f)];
    self.m_popupView.backgroundColor=[UIColor colorWithRed:42.0/255 green:0.0/255 blue:48.0/255 alpha:1];
    [self addBtnOnPopupWindowWithTag:111 NormalImage:[UIImage imageNamed:@"gouyigou.png"] PopupView:self.m_popupView andCenter:CGPointMake(-80.0f, 0.0f)]; //Add Gou Yi Gou Button
    [self addBtnOnPopupWindowWithTag:222 NormalImage:[UIImage imageNamed:@"piaoliuping.png"] PopupView:self.m_popupView andCenter:CGPointMake(80.0f,0.0f)];
    
    
    [self.view addSubview:self.m_popupView];
}

-(void)closePopupWindow
{
    [self.m_popupView removeFromSuperview];
    [self.m_popupView release];
    UIButton *gouyigouBtn=(UIButton *)[self.view viewWithTag:111];
    UIButton *piaoliupingBtn=(UIButton *)[self.view viewWithTag:222];
    [gouyigouBtn removeFromSuperview];
    [piaoliupingBtn removeFromSuperview];
}




- (void)dealloc {
    [_m_tabBarView release];
    [super dealloc];
}



@end
