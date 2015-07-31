//
//  NavigationBar.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//------------------------------------------------------------------------------------------------
#pragma mark - NavigationBarMgr协议
@protocol NavigationBarDelegate

-(NSString *)setNavigationBarTitle;                                       //委托方法，自定义导航栏名字

@end
//------------------------------------------------------------------------------------------------

#pragma mark - NavigationBarMgr变量
@interface NavigationBarMgr : UINavigationBar
{
  id delegate;                                                            //委托变量
}
@property (nonatomic,retain)      UINavigationBar *navigationBar;         //设置导航栏
@property (nonatomic,retain)      AppDelegate     *appDelegate;           //设置appDelegate 用于获取全局变量


//------------------------------------------------------------------------------------------------

//定义方法
+(NavigationBarMgr *)sharedInstance;                                      //设置导航栏管理器为单例模式
-(UINavigationBar*)getNavigationBar;                                      //获取导航栏
-(UINavigationBar*)drawNavigationBar;                                     //画出导航栏
-(void)setDelegate:(id)newdelegate;                                       //设置委托


@end

