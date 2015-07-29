//
//  FirstViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundViewController : UIViewController

@property (strong,nonatomic) NSMutableArray *bodyList;//内容列表
@property (strong,nonatomic) NSMutableArray *nameList;//姓名列表
@property (strong,nonatomic) NSMutableArray *timeList;//时间列表
@property (strong,nonatomic) NSMutableArray *titleList;//标题列表
@property (strong,nonatomic) NSMutableArray *portraitList;//头像列表

@property (strong,nonatomic) NSInputStream *inputStream;//网络输入流
@property (strong,nonatomic) NSOutputStream *outputStream;//网络输出流
@property (assign,nonatomic)BOOL isHead; //Check if it is package header or not

-(void)addNavitionBar;  //添加导航栏
-(void)dataInitialize; //Intialize all data in the table view

-(void)setSegControl;    //Set Segment contorl for changing segment in the First View
-(void)setMsgTableView;  //Set Message Table View in the First View


/* TableView component*/
-(CALayer *)setImg;
-(CALayer *)setNameAtRowIndex:(NSUInteger)rowIndex;
-(CALayer *)setTimeAtRowIndex:(NSUInteger)rowIndex;
-(CALayer *)setTitleAtRowIndex:(NSUInteger )rowIndex;


- (void)initNetworkCommunication;
-(NSUInteger)bytes2intWithByteArr:(NSMutableArray*)buf; //Convert bytes to int for decoding the length of package
-(NSData *)int2byteWithInt:(NSUInteger)num;    //Convert bytes to int for receiver to decode the length of package
@end

