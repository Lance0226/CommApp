//
//  NSObject+CoreDataExec.m
//  CommApp
//
//  Created by 韩渌 on 15/7/20.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "CoreDataExec.h"
#import "AppDelegate.h"
#import "PlayerInfo.h"

@implementation CoreDataExec
@synthesize delegate;

-(void)initData
{
    self.delegate=[[UIApplication sharedApplication]delegate];
}



-(void)insert2CoreData
{
    PlayerInfo *playerinfo=[NSEntityDescription insertNewObjectForEntityForName:@"PlayerInfo" inManagedObjectContext:[delegate managedObjectContext]];
    playerinfo.name=@"aaaa";
    playerinfo.id=[NSNumber numberWithInt:123456];
    playerinfo.email=@"cccc";
    [delegate saveContext];
    
}

-(void)searchData
{
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    request.entity=[NSEntityDescription entityForName:@"PlayerInfo" inManagedObjectContext:[delegate managedObjectContext]];
    NSArray *objs=[[delegate managedObjectContext]executeFetchRequest:request error:nil];
    for (NSManagedObject *obj in objs) {
        NSLog(@"name=%@", [obj valueForKey:@"name"]);
    }
}


@end
