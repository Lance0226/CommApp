//
//  EditViewController.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"

@interface EditViewController : UIViewController<NavigationBarDelegate,UITextViewDelegate>

@property (nonatomic,strong)UINavigationBar *navigationBar;
@property (nonatomic,strong) UITextView *titleInputField;
@property (nonatomic,strong) UITextView *contentInputField;

@property CGFloat accumWidth;

-(void)initialize;
-(void)addNavigationBar;
-(void)addTextField;
-(void)addButtonWithTag:(NSInteger )tag andWidthIndex:(NSInteger)index;
@end
