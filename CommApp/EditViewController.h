//
//  EditViewController.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EditViewController : UIViewController<UITextViewDelegate>
//-----------------------------------------------------------------------------------------------------------
#pragma mark - EditViewController的变量声明
@property (nonatomic,retain)    UINavigationBar   *navigationBar;                               //导航栏
@property (nonatomic,retain)    UITextView        *titleInputField;                             //题目输入框
@property (nonatomic,retain)    UITextView        *contentInputField;                           //内容输入框
@property (nonatomic,retain)    UIButton          *returnBtn;                                   //返回按钮
@property (nonatomic,retain)    UIView *          inputView;                                    //输入区

@property (nonatomic,retain)    AppDelegate       *appDelegate;                                 //设置AppDelegate委托变量
@property (nonatomic,assign)    CGFloat           screenWidth;                                  //设置屏幕宽
@property (nonatomic,assign)    CGFloat           screenHeight;                                 //设置屏幕长；
//------------------------------------------------------------------------------------------------------------
#pragma mark - EditViewController的方法声明
-(void)initialize;                                                                       //页面变量初始化
-(void)addNavigationBar;                                                                 //加载导航栏
-(void)addTextField;                                                                     //加载勾勾输入区域
-(void)addInputZone;                                                                     //加载键盘输入区域
@end
