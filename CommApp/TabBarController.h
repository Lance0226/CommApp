//
//  TabBarController.h
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController

<<<<<<< HEAD
@property (nonatomic, strong) IBOutlet UIButton  *m_centerBtn; //Add button
=======
@property (nonatomic, strong) IBOutlet UIButton  *m_centerBtn;
>>>>>>> origin/master
//The View that contains gouyigou and piaoliuping is displayed or not.
@property (nonatomic)        bool                 m_isPopupViewDisplay;
@property (nonatomic,strong) UIView              *m_popupView;


<<<<<<< HEAD
=======

>>>>>>> origin/master
-(void)initialize;//Properties initialize.
-(void)buttonPressed:(id)sender;
-(void)changeTabBarView;
-(void)closePopupWindow;
-(void)addBtnOnPopupWindowWithTag:(NSInteger)tag NormalImage:(UIImage*)btnImage HighlightedImage:(UIImage*)hlImage PopupView:(UIView * )popupView andCenter:(CGPoint )center;
<<<<<<< HEAD
-(void)buttonOnPopupView:(UIButton *)btn;

//-------------------------------------
//Input function
-(void)displayInputFiled;
=======
-(void)buttonOnPopupView:(UIButton *)sender;
>>>>>>> origin/master

@end
