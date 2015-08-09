//
//  EditViewController.m
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import "EditViewController.h"
#import "NavigationBarMgr.h"
#import "TabBarController.h"


@interface EditViewController ()<UITextViewDelegate>

@end

@implementation EditViewController

@synthesize appDelegate;
@synthesize screenHeight=_screenHeight;
@synthesize screenWidth=_screenWidth;
@synthesize titleInputField=_titleInputField;
@synthesize contentInputField=_contentInputField;
@synthesize returnBtn=_returnBtn;
@synthesize inputView=_inputView;

- (void)viewDidLoad
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self initialize];});
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [super viewDidLoad];
        [self addNavigationBar];
        [self addTextField];
        [self addInputZone];
    });
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//--------------------------------------------------
#pragma mark - 勾一勾编辑页面导航栏方法实现

-(void)initialize
{
    self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.screenWidth=self.appDelegate.SCREEN_WIDTH;
    self.screenHeight=self.appDelegate.SCREEN_HEIGHT;
}

-(void)addNavigationBar
{   
    NavigationBarMgr* navBar=[NavigationBarMgr sharedInstance];
    UINavigationBar *bar=[navBar getNavigationBar];
    [self.view addSubview:bar];
    
    UIButton *returnBtn=[[UIButton alloc] initWithFrame:CGRectMake(bar.frame.size.width*0.85, bar.frame.size.height/6, bar.frame.size.width/6, bar.frame.size.height*0.85)];
    [returnBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnTapped:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:returnBtn];


}

//导航栏返回按钮响应事件
-(void)returnBtnTapped:(id)sender
{
    NSLog(@"bb");
    [self performSegueWithIdentifier:@"return_segue" sender:self];
}

/*
-(NSString*)setNavigationBarTitle  //Navigation delegate method
{
    return @"勾  勾";
}
*/
//---------------------------------------------------
#pragma mark - 勾一勾编辑页面绘制输入框
-(void)addTextField
{   //Set title field
    //获取导航栏单例
    NavigationBarMgr* navBar=[NavigationBarMgr sharedInstance];
    UINavigationBar *bar=[navBar getNavigationBar];
    self.titleInputField=[[UITextView alloc]initWithFrame:CGRectMake(0,bar.frame.size.height, self.screenWidth, self.screenHeight/10)];
    [self.titleInputField setDelegate:self];
    [self.titleInputField setBackgroundColor:[UIColor blackColor]];
    [self.titleInputField setFont:[UIFont boldSystemFontOfSize:16]];
    [self.titleInputField setTextColor:[UIColor purpleColor]];
    [self.titleInputField setText:@"请输入勾勾标题"];
    [self.titleInputField setDelegate:self];
    
    [self.titleInputField.layer setBorderWidth:0.5f];
    [self.titleInputField.layer setBorderColor:[UIColor purpleColor].CGColor];
    [self.view addSubview:self.titleInputField];
    
    self.contentInputField=[[UITextView alloc]initWithFrame:CGRectMake(0,bar.frame.size.height+self.screenHeight/10, self.screenWidth,self.screenHeight*0.9f-bar.frame.size.height)];
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
    
    CGFloat keyboardHeight = 216.0f;
    if (self.view.frame.size.height - keyboardHeight-100<= self.inputView.frame.origin.y + self.inputView.frame.size.height) {
        CGFloat y = self.inputView.frame.origin.y - (self.view.frame.size.height - keyboardHeight - self.inputView.frame.size.height - 5);
        [UIView beginAnimations:@"srcollView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        self.inputView.frame = CGRectMake(self.inputView.frame.origin.x, self.inputView.frame.origin.y-y-40, self.inputView.frame.size.width, self.inputView.frame.size.height);
        [UIView commitAnimations];
    }
}

//-----------------------------------------------

-(void)addInputZone
{
    self.inputView=[[UIView alloc]initWithFrame:CGRectMake(0, self.screenHeight*14/15, self.screenWidth, self.screenHeight/15)];
    [self.inputView setBackgroundColor:[UIColor purpleColor]];
    [self.inputView.layer setZPosition:999];
    [self.view addSubview:self.inputView];
}


- (void)dealloc
{
    [super dealloc];
    [_titleInputField release];
    [_contentInputField release];
}





@end
