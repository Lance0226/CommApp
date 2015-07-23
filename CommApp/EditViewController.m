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
@synthesize titleInputField=_titleInputField;
@synthesize contentInputField=_contentInputField;
@synthesize accumWidth;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationBar];
    [self addTextField];
    [self addButtonWithTag:111 andWidthIndex:1];
    [self addButtonWithTag:222 andWidthIndex:1];
    [self addButtonWithTag:333 andWidthIndex:1];
    [self addButtonWithTag:444 andWidthIndex:3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialize
{
    self.accumWidth=0;
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
-(void)addTextField
{   //Set title field
    self.titleInputField=[[UITextView alloc]initWithFrame:CGRectMake(0,self.navigationBar.frame.size.height, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/10)];
    [self.titleInputField setDelegate:self];
    [self.titleInputField setBackgroundColor:[UIColor blackColor]];
    [self.titleInputField setFont:[UIFont boldSystemFontOfSize:16]];
    [self.titleInputField setTextColor:[UIColor purpleColor]];
    [self.titleInputField setText:@"请输入勾勾标题"];
    
    [self.titleInputField.layer setBorderWidth:0.5f];
    [self.titleInputField.layer setBorderColor:[UIColor purpleColor].CGColor];
    [self.view addSubview:self.titleInputField];
    
    self.contentInputField=[[UITextView alloc]initWithFrame:CGRectMake(0,self.navigationBar.frame.size.height+[[UIScreen mainScreen]bounds].size.height/10, [[UIScreen mainScreen]bounds].size.width,[UIScreen mainScreen].bounds.size.height-self.navigationBar.frame.size.height-[UIScreen mainScreen].bounds.size.height/10)];
    [self.contentInputField setDelegate:self];
    [self.contentInputField setBackgroundColor:[UIColor blackColor]];
    [self.contentInputField setFont:[UIFont boldSystemFontOfSize:16]];
    [self.contentInputField setTextColor:[UIColor purpleColor]];
    [self.contentInputField setText:@"有什么心事吗？把你的心事说出来，勾仔、勾妹，帮你"];
    
    [self.contentInputField.layer setBorderWidth:0.5f];
    [self.contentInputField.layer setBorderColor:[UIColor purpleColor].CGColor];
    [self.view addSubview:self.contentInputField];
}

//------------------------------------
//TextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView setText:@""];
    [textView becomeFirstResponder];
}

//-----------------------------------------------

-(void)addButtonWithTag:(NSInteger )tag andWidthIndex:(NSInteger)index
{
    UIButton* inputBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat   inputBtnRatio=1*index;
    CGFloat   inputBtnHeight=[UIScreen mainScreen].bounds.size.height/10;
    CGFloat   inputBtnWidth=inputBtnHeight*inputBtnRatio;
    [inputBtn setFrame:CGRectMake(self.accumWidth, [UIScreen mainScreen].bounds.size.height-inputBtnHeight, inputBtnWidth,inputBtnHeight)];
    self.accumWidth+=inputBtnWidth+[UIScreen mainScreen].bounds.size.width/50;
    [inputBtn setBackgroundColor:[UIColor purpleColor]];
    [inputBtn setTag:tag];
    [self.view addSubview:inputBtn];
    
}







@end
