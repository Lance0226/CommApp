//
//  NavigationBar.m
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import "NavigationBarMgr.h"

@implementation NavigationBarMgr
@synthesize delegate;
@synthesize appDelegate=_appDelegate;

//-----------------------------------------------------------------------------------------------------
#pragma mark - NavigationBarMar的方法实现

//设置导航栏管理器为单例模式

+(NavigationBarMgr*)sharedInstance
{
    static NavigationBarMgr* _sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance=[[NavigationBarMgr alloc]init];
    });
    _sharedInstance.navigationBar=[_sharedInstance drawNavigationBar];
    return _sharedInstance;
}


//获取导航栏
-(UINavigationBar*)getNavigationBar
{
    return self.navigationBar;
}

//画出导航栏
-(UINavigationBar*)drawNavigationBar
{
    self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    CGFloat screenWidth=self.appDelegate.SCREEN_WIDTH;                                                          //屏幕宽
    CGFloat screenHeight=self.appDelegate.SCREEN_HEIGHT;                                                        //屏幕高
    
    //Draw navigationbar view
    CGFloat barWidth=screenWidth;                                                                              //导航栏宽度
    CGFloat barHeight=screenHeight/10.0f;                                                                      //导航栏高度
    UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, barWidth, barHeight)];        //导航栏初始化
    [bar setBarTintColor:[UIColor purpleColor]];
    
    //Add title text
    CGFloat txtWidth=screenWidth/3;                                                                            //导航栏标题宽度
    CGFloat txtHeight=screenHeight/15.0f;                                                                      //导航栏标题高度
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, txtWidth, txtHeight)];                       //导航栏标题出事话
    [title setCenter:CGPointMake(bar.center.x+30.0f, bar.center.y)];
    NSString *text=@"未命名";                                                                                   //导航栏文字
    text=[delegate setNavigationBarTitle];                                                                     //通过委托方法设置导航栏名字
    [title setText:text];
    [bar addSubview:title];
    return bar;
    
}



-(void)setDelegate:(id)newdelegate
{
    delegate=newdelegate;
}

-(void)dealloc
{
    [delegate release];
    [super dealloc];
    
}
@end
