//
//  EditViewController.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NavigationBar.h"

@interface EditViewController : UIViewController<UITextViewDelegate>

@property (nonatomic,retain)UINavigationBar *navigationBar;  //导航栏
@property (nonatomic,retain) UITextView *titleInputField;    //题目输入框
@property (nonatomic,retain) UITextView *contentInputField;  //内容输入框
@property (nonatomic,retain)UIButton *returnBtn;             //返回按钮

@property (nonatomic,retain) UIView *inputView;             //输入区

-(void)addNavigationBar;
-(void)addTextField;
-(void)addInputZone;
@end
