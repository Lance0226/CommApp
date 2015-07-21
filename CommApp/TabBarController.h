//
//  TabBarController.h
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController

@property (nonatomic, strong) IBOutlet UIButton  *m_centerBtn; //Add button
//The View that contains gouyigou and piaoliuping is displayed or not.
@property (nonatomic)        bool                 m_isPopupViewDisplay;
@property (nonatomic,strong) UIView              *m_popupView;


-(void)initialize;//Properties initialize.
-(void)buttonPressed:(id)sender;
-(void)changeTabBarView;
-(void)closePopupWindow;
-(void)addBtnOnPopupWindowWithTag:(NSInteger)tag NormalImage:(UIImage*)btnImage HighlightedImage:(UIImage*)hlImage PopupView:(UIView * )popupView andCenter:(CGPoint )center;
-(void)buttonOnPopupView:(UIButton *)btn;

//-------------------------------------
//Input function
-(void)displayInputFiled;

@end
