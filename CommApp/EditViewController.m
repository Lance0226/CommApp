//
//  EditViewController.m
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self drawNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedReturn:(id)sender
{
    [self performSegueWithIdentifier:@"return_segue" sender:self];//return to home page
}

-(void)drawNavigationBar
{
    //Draw navigationbar view
    CGFloat barWidth=[[UIScreen mainScreen]bounds].size.width;
    CGFloat barHeight=[[UIScreen mainScreen]bounds].size.height/10.0f;
    UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, barWidth, barHeight)];
    [bar setBarTintColor:[UIColor purpleColor]];
    [self.view addSubview:bar];
    
    //Add title text
    CGFloat txtWidth=[[UIScreen mainScreen]bounds].size.width/3;
    CGFloat txtHeight=[[UIScreen mainScreen]bounds].size.height/15.0f;
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, txtWidth, txtHeight)];
    [title setCenter:CGPointMake(bar.center.x+30.0f, bar.center.y)];
    [title setText:@"勾  勾"];
    [self.view addSubview:title];
    
}


@end
