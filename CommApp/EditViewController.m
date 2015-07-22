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
@synthesize inputField=_inputField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationBar];
    [self addInputField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedReturn:(id)sender
{
    [self performSegueWithIdentifier:@"return_segue" sender:self];//return to home page
}
//--------------------------------------------------
//Navigation Bar Method
-(void)addNavigationBar
{   NavigationBar *navbar=[[NavigationBar alloc]init];
    [navbar setDelegate:self];
    self.navigationBar=[navbar drawNavigationBar];
    [self.view addSubview:self.navigationBar];
}

-(NSString*)setNavigationBarTitle  //Navigation delegate method
{
    return @"勾  勾";
}
//---------------------------------------------------
//Input Field
-(void)addInputField
{
    self.inputField=[[CustomeTextField alloc]initWithFrame:CGRectMake(0,self.navigationBar.frame.size.height, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/2)];
    
    
    [self.inputField setBackgroundColor:[UIColor blackColor]];
    [self.inputField setPlaceholder:@"有什么心事吗，把你想说的说出来，勾妹，勾仔会帮你哦"];
    [self.view addSubview:self.inputField];
}





@end
