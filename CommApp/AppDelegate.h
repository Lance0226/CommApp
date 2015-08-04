//
//  AppDelegate.h
//  CommApp
//
//  Created by 韩渌 on 15/7/13.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//----------------------------------------------------------------------------------------------
#pragma mark -AppDelegate定义变量
@property (strong, nonatomic) UIWindow *window;                                                           //主窗口
//定义全局变量
@property (readwrite,assign,nonatomic) CGFloat SCREEN_WIDTH;                                              //屏幕宽度
@property (readwrite,assign,nonatomic) CGFloat SCREEN_HEIGHT;                                             //屏幕高度

@property (readwrite,retain,nonatomic) NSString *HuanXinUserName;                                        //登录用户名


//CoreData部分

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;                    //CoreData数据上下文
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;                        //CoreData数据模型
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;        //CoreData持久化数据处理助手


//-----------------------------------------------------------------------------------------------
#pragma mark -AppDelegate定义方法
- (void)saveContext;                                                                                    //存储上下文
- (NSURL *)applicationDocumentsDirectory;                                                               //CoreData存储文件路径


@end

