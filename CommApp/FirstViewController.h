//
//  FirstViewController.h
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController


-(void)dataInitialize; //Intialize all data in the table view

-(void)setSegControl;    //Set Segment contorl for changing segment in the First View
-(void)setMsgTableView;  //Set Message Table View in the First View


/* TableView component*/
-(CALayer *)setImg;
-(CALayer *)setNameAtRowIndex:(NSUInteger)rowIndex;
-(CALayer *)setTimeAtRowIndex:(NSUInteger)rowIndex;
-(CALayer *)settitleAtRowIndex:(NSUInteger )rowIndex;


- (void)initNetworkCommunication;
-(NSUInteger)bytes2intWithByteArr:(NSMutableArray*)buf; //Convert bytes to int for decoding the length of package
-(NSData *)int2byteWithInt:(NSUInteger)num;    //Convert bytes to int for receiver to decode the length of package
@end

