//
//  TabBarController.h
//  CommApp
//
//  Created by 韩渌 on 15/7/19.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController
//------------------------------------------------------------------------------------------

#pragma mark - 声明TabBarController变量

@property (retain, nonatomic) IBOutlet UITabBar  *tabBarView;                            //tabBar图层
@property (nonatomic, retain)          UIButton  *tabBarCenterBtn;                       //tabBar中心加号按钮

@property (nonatomic,retain)           UIView    *tabBarCenterBtnPopView;               //tabBar中心加号按钮弹出图层
@property (nonatomic,assign)           bool       isTabBarCenterBtnPopViewDisplay;      //tabBar中心加号按钮弹出图层显示与否的标志位


//-------------------------------------------------------------------------------------------
#pragma mark - 声明TabBarController方法

-(void)initialize;                                                                      //属性初始化
-(void)changeTabBarViewApperance;                                                       //自定义tabBar外观

-(void)tabBarCenterBtnPressed:(id)sender;                                               //tabBar中心加号按钮被点击
-(void)closeTabBarCenterBtnPopView;                                                     //关闭tabBar中心加号按钮
-(void)addTarBarCenterBtnPopViewTag               :(NSInteger)tag                       //加载加号弹出图形
                              NormalImage       :(UIImage*)btnImage                     //普遍
                              HighlightedImage  :(UIImage*)hlImage
                              PopupView         :(UIView * )popupView
                              andCenter         :(CGPoint )center;
-(void)buttonOnPopupView:(UIButton *)sender;


//-------------------------------------
//Input function
-(void)displayInputFiled;



@end
