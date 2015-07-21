//
//  NSObject+CoreDataExec.h
//  CommApp
//
//  Created by 韩渌 on 15/7/20.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataExec:NSObject

@property(nonatomic,strong) id delegate;
-(void)insert2CoreData;
-(void)initData;
-(void)searchData;


@end
