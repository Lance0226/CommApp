//
//  NavigationBar.m
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar
@synthesize delegate;

-(UINavigationBar*)drawNavigationBar
{
    //Draw navigationbar view
    CGFloat barWidth=[[UIScreen mainScreen]bounds].size.width;
    CGFloat barHeight=[[UIScreen mainScreen]bounds].size.height/10.0f;
    UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, barWidth, barHeight)];
    [bar setBarTintColor:[UIColor purpleColor]];
    
    //Add title text
    CGFloat txtWidth=[[UIScreen mainScreen]bounds].size.width/3;
    CGFloat txtHeight=[[UIScreen mainScreen]bounds].size.height/15.0f;
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, txtWidth, txtHeight)];
    [title setCenter:CGPointMake(bar.center.x+30.0f, bar.center.y)];
    NSString *text=@"aa";
    text=[delegate setNavigationBarTitle];  //Set title
    [title setText:text];
    [bar addSubview:title];
    return bar;
    
}

-(void)setDelegate:(id)newdelegate
{
    delegate=newdelegate;
}
@end
