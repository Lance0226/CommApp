//
//  NavigationBar.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavigationBarDelegate
-(NSString *)setNavigationBarTitle;   //委托方法，自定义导航栏名字
@end

@interface NavigationBarMgr : UINavigationBar
{
  id delegate;
}
@property (nonatomic,retain)UINavigationBar *navigationBar;//设置导航栏
+(NavigationBarMgr *)sharedInstance;  //设置导航栏管理器为单例模式
-(UINavigationBar*)getNavigationBar;
-(void)setDelegate:(id)newdelegate;

@end

