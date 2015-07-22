//
//  TabBarController.m
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "TabBarController.h"
#import "EditViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialize
{
    self.m_isPopupViewDisplay=false;
}
-(void)changeTabBarView
{
    self.tabBar.tintColor=[UIColor blackColor];
}

-(void)addBtnOnPopupWindowWithTag:(NSInteger)tag NormalImage:(UIImage *)btnImage HighlightedImage:(UIImage *)hlImage PopupView:(UIView *)popupView andCenter:(CGPoint)center
{
    UIButton* popupBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    popupBtn.autoresizesSubviews=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    CGFloat popupBtnRatio=btnImage.size.width/btnImage.size.height;
    popupBtn.bounds=CGRectMake(0.0f,0.0f,popupView.frame.size.height*popupBtnRatio,popupView.frame.size.height);
    [popupBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [popupBtn setBackgroundImage:hlImage forState:UIControlStateHighlighted];
    [popupBtn addTarget:self action:@selector(buttonOnPopupView:) forControlEvents:UIControlEventTouchUpInside];
    popupBtn.center=CGPointMake(popupView.center.x+center.x, popupView.center.y+center.y);
    popupBtn.layer.zPosition=2;
    [popupBtn setTag:tag];
    
    [self.view addSubview:popupBtn];
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
}


- (void)buttonPressed:(id)sender
{
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


-(void)buttonOnPopupView:(UIButton *)btn
{
    switch (btn.tag) {
        case 111:NSLog(@"Gouyigou"); [self displayInputFiled];break;     //when tag is 111,the click button is Gou yi Gou.
        case 222:NSLog(@"piaoliuping");break;   //when tag is 222,the click button is piao liu ping.
        default:break;
    }
}


-(void)showPopupWindow
{
    self.m_popupView=[[UIView alloc]initWithFrame:CGRectMake(0, self.tabBar.center.y-self.tabBar.bounds.size.height-10.0f,[[UIScreen mainScreen]bounds].size.width, 35.0f)];
    self.m_popupView.backgroundColor=[UIColor colorWithRed:42.0/255 green:0.0/255 blue:48.0/255 alpha:1];
    [self.view addSubview:self.m_popupView];
 
    [self addBtnOnPopupWindowWithTag:111 NormalImage:[UIImage imageNamed:@"gouyigou.png"] HighlightedImage:[UIImage imageNamed:@"gouyigou_selected.png"] PopupView:self.m_popupView andCenter:CGPointMake(-80.0f, 0.0f)];
    
    [self addBtnOnPopupWindowWithTag:222 NormalImage:[UIImage imageNamed:@"piaoliuping.png"] HighlightedImage:[UIImage imageNamed:@"piaoliuping_selected.png"] PopupView:self.m_popupView andCenter:CGPointMake(80.0f,0.0f)];
    
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


-(void)displayInputFiled
{
    [self performSegueWithIdentifier:@"edit_segue" sender:self];
}

- (void)dealloc {
    [_m_tabBarView release];
    [super dealloc];
}



@end
