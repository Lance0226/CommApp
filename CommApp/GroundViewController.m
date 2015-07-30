//
//  FirstViewController.m
//  CommuncationApp
//
//  Created by 韩渌 on 15/7/6.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "GroundViewController.h"
#import "Test.pb.h"
//#import "NavigationBarMgr.h"
#import "CoreDataExec.h"
#import "NavigationBarMgr.h"

@interface GroundViewController () <UITableViewDataSource,UITableViewDelegate,NSStreamDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (strong, nonatomic) IBOutlet UITableView *MsgTableView;

@end

@implementation GroundViewController

@synthesize segControl=_segControl;
@synthesize MsgTableView=_MsgTableView;

@synthesize bodyList=_bodyList;
@synthesize nameList=_nameList;
@synthesize titleList=_titleList;
@synthesize timeList=_timeList;
@synthesize portraitList=_portraitList;

@synthesize inputStream=_inputStream;
@synthesize outputStream=_outputStream;

@synthesize isHead=_isHead;


/*--------------------------------------------------------------------------------*/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataInitialize];
    
    [self setSegControl];
    
    [self setMsgTableView];
    
    [self initNetworkCommunication];
    
    [self addNavitionBar];
    
    
    //操作Core Data对象
    //CoreDataExec *coreDataExec=[[CoreDataExec alloc]init];
    //[coreDataExec initData];
    //[coreDataExec insert2CoreData];
    //[coreDataExec searchData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/*--------------------------------------------------------------------------------*/

-(void)addNavitionBar
{
    NavigationBarMgr* navBar=[NavigationBarMgr sharedInstance];
    self.bar=[navBar getNavigationBar];
    [self.view addSubview:self.bar];
    self.genderBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, self.bar.frame.size.height/6, self.bar.frame.size.width/7, self.bar.frame.size.height*0.85)];
    [self.genderBtn setImage:[UIImage imageNamed:@"gender"] forState:UIControlStateNormal];
    [self.genderBtn addTarget:self action:@selector(selectSearchGender) forControlEvents:UIControlEventTouchDown];
    
    self.editBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.bar.frame.size.width*0.85, self.bar.frame.size.height/6, self.bar.frame.size.width/8, self.bar.frame.size.height*0.85)];
    [self.editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.view addSubview:self.genderBtn];
    [self.view addSubview:self.editBtn];
}

-(void)selectSearchGender
{
    UIView* genderView=[[UIView alloc]initWithFrame:CGRectMake(0,self.bar.frame.size.height+5, self.genderBtn.frame.size.width*2,self.genderBtn.frame.size.height*2)];
    [genderView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:genderView];
}

/*--------------------------------------------------------------------------------*/
 -(void)dataInitialize
{
    self.bodyList=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    self.nameList=[NSMutableArray arrayWithObjects:@"Lance",@"Tom",@"Jack",@"Adm",@"Rose",@"Terry",@"Dirk",nil];
    self.timeList=[NSMutableArray arrayWithObjects:@"1111",@"2222",@"3333",@"4444",@"5555",@"6666",@"7777",nil];
    self.titleList=[NSMutableArray arrayWithObjects:@"AAAAAAAA",@"BBBBBBB",@"CCCCCC",@"DDDD",@"EEEEE",@"FFFF",@"JJJJ",nil];
    self.portraitList=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"head"],
                                                   [UIImage imageNamed:@"head"],
                                                   [UIImage imageNamed:@"head"],
                                                   [UIImage imageNamed:@"head"],
                                                   [UIImage imageNamed:@"head"],
                                                   [UIImage imageNamed:@"head"],
                                                   [UIImage imageNamed:@"head"],
                                                                           nil];
    
    self.isHead=YES;
}
/*-------------------------------------------------------------------------------*/
/*Initialize First View Page UI*/
-(void)setSegControl
{
    self.segControl.layer.cornerRadius=0;
    self.segControl.layer.borderWidth=1.5;
    self.segControl.layer.borderColor=[UIColor purpleColor].CGColor;
}


-(void)setMsgTableView
{
    self.MsgTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.MsgTableView];
    self.MsgTableView.scrollEnabled=YES;
    [self.MsgTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    self.MsgTableView.delegate=self;
    self.MsgTableView.dataSource=self;
}


/*-------------------------------------------------------------------------------*/
/*table view data*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
     NSUInteger row = [indexPath row];
    if (cell==nil)
    {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    [cell setBackgroundColor:[UIColor blackColor]];
        
    CALayer *imgLayer=[self setImg];
    [cell.layer addSublayer:imgLayer];
    
    CALayer *nameLayer=[self setNameAtRowIndex:row];
    [cell.layer addSublayer:nameLayer];
    
    CALayer *timeLayer=[self setTimeAtRowIndex:row];
    [cell.layer addSublayer:timeLayer];
    
    
    CALayer *titleLayer=[self setTitleAtRowIndex:row];
    [cell.layer addSublayer:titleLayer];
        
    CALayer *flowerLayer=[self setFlowerAtRowIndex:row]; //添加花
    [cell.layer addSublayer:flowerLayer];
        
    CALayer *heartLayer=[self setHeartAtRowIndex:row];    //添加星
    [cell.layer addSublayer:heartLayer];
    
    CALayer *starLayer=[self setStarAtRowIndex:row];
    [cell.layer addSublayer:starLayer];
    
        
    }
    
   
    cell.textLabel.text = [self.bodyList objectAtIndex:row];
    [cell.textLabel setTextColor:[UIColor purpleColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bodyList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;//Height of each segment in table view
}

-(CALayer *)setImg                                          //设置头像
{
    CALayer *imgLayer=[CALayer layer];
    [imgLayer setFrame:CGRectMake(20, 10, 35, 35)];
    [imgLayer setContents:(id)[UIImage imageNamed:@"head"].CGImage];
    [imgLayer setCornerRadius:30];
    return imgLayer;
}

-(CALayer *)setNameAtRowIndex:(NSUInteger )rowIndex       //设置用户名
{
    CATextLayer *nameLayer=[[CATextLayer alloc]init];
    [nameLayer setFont:@"Helvetica-Bold"];
    [nameLayer setFontSize:15];
    [nameLayer setFrame:CGRectMake(75, 15, 50, 30)];
    [nameLayer setString:[self.nameList objectAtIndex:rowIndex]];
    [nameLayer setAlignmentMode:kCAAlignmentLeft];
    [nameLayer setForegroundColor:[[UIColor purpleColor] CGColor]];
    return nameLayer;
}

-(CALayer *)setTimeAtRowIndex:(NSUInteger )rowIndex      //设置时间
{
    CATextLayer *nameLayer=[[CATextLayer alloc]init];
    [nameLayer setFont:@"HelveticaNeue"];
    [nameLayer setFontSize:10];
    [nameLayer setFrame:CGRectMake(75, 32, 30, 20)];
    [nameLayer setString:[self.timeList objectAtIndex:rowIndex]];
    [nameLayer setAlignmentMode:kCAAlignmentLeft];
    [nameLayer setForegroundColor:[[UIColor purpleColor] CGColor]];
    return nameLayer;
}


-(CALayer *)setTitleAtRowIndex:(NSUInteger )rowIndex    //设置题目
{
    CATextLayer *nameLayer=[[CATextLayer alloc]init];
    [nameLayer setFont:@"HelveticaNeue"];
    [nameLayer setFontSize:23];
    [nameLayer setFrame:CGRectMake(5, 45, 150, 50)];
    [nameLayer setString:[self.titleList objectAtIndex:rowIndex]];
    [nameLayer setAlignmentMode:kCAAlignmentCenter];
    [nameLayer setForegroundColor:[[UIColor blackColor] CGColor]];
    return nameLayer;
}

-(CALayer *)setFlowerAtRowIndex:(NSInteger)rowIndex  //设置花
{
    CALayer *awardrImgLayer=[CALayer layer];
    [awardrImgLayer setFrame:CGRectMake(20, 170, 20, 20)];
    [awardrImgLayer setContents:(id)[UIImage imageNamed:@"flower"].CGImage];
    [awardrImgLayer setCornerRadius:30];
    return awardrImgLayer;
}

-(CALayer *)setHeartAtRowIndex:(NSInteger)rowIndex  //设置心
{
    CALayer *awardrImgLayer=[CALayer layer];
    [awardrImgLayer setFrame:CGRectMake(120, 170, 20, 20)];
    [awardrImgLayer setContents:(id)[UIImage imageNamed:@"heart"].CGImage];
    [awardrImgLayer setCornerRadius:30];
    return awardrImgLayer;
}

-(CALayer *)setStarAtRowIndex:(NSInteger)rowIndex  //设置星
{
    CALayer *awardrImgLayer=[CALayer layer];
    [awardrImgLayer setFrame:CGRectMake(220, 170, 20, 20)];
    [awardrImgLayer setContents:(id)[UIImage imageNamed:@"star"].CGImage];
    [awardrImgLayer setCornerRadius:30];
    return awardrImgLayer;
}

/*socket*/
-(void)initNetworkCommunication
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 6060, &readStream, &writeStream);
    self.inputStream = (__bridge NSInputStream *)readStream;
    self.outputStream =(__bridge NSOutputStream *)writeStream;
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream open];
    [self.outputStream open];
}
- (IBAction)joinChat:(id)sender
{
    player_info* info=[[[[[player_info builder]setName:@"aaa"]
                                             setId:123456]
                                             setEmail:@"bbbb"]
                                              build];
    NSData* body=[info data];
    NSUInteger body_length=[body length];
    NSData* header=[self int2byteWithInt:body_length];
    
    NSMutableData* package=[NSMutableData dataWithData:header];
    [package appendData:body];
    [self.outputStream write:[package bytes] maxLength:[package length]];
}



-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{  
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasBytesAvailable:
            if (aStream==self.inputStream) {
                NSUInteger len;
                NSUInteger num=0;
                
                while ([self.inputStream hasBytesAvailable]) {
                    u_int8_t header[4];
                    u_int8_t body[1024];
                    NSUInteger max_len=4;
                    if (self.isHead==YES) {
                    len=[self.inputStream read:header maxLength:max_len];
                    if (len==4) {
                        self.isHead=NO;
                        
                        NSMutableArray *header_arr=[[NSMutableArray alloc]init];
                        for (NSUInteger i=0; i<4; i++) {
                            [header_arr addObject:[[NSNumber alloc]initWithUnsignedChar:header[i]]];
                        }
                        num=[self bytes2intWithByteArr:header_arr];
                        NSLog(@"%lu",(unsigned long)num);
                        
                    }
                    }
                    else
                    {
                        len=[self.inputStream read:body maxLength:num];
                        self.isHead=YES;
                        NSData *data=[NSData dataWithBytes:body length:num];
                        player_info *info=[player_info parseFromData:data];
                        NSLog(@"%@",info.name);
                        NSLog(@"%@",info.email);
                        
                    }
                }
            }
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"End Encountered");
            break;
        default:
            NSLog(@"Unknown event");
    }
}

-(NSUInteger)bytes2intWithByteArr:(NSMutableArray *)buf
{
    NSUInteger num=0;
    for (NSObject *object in buf) {
        Byte curByte=[(NSNumber *)object unsignedCharValue];
        num<<=8;
        num|=(curByte&0xff);
    }
    return num;
}

-(NSData *)int2byteWithInt:(NSUInteger)num
{
    u_int8_t bytes[4];
    bytes[0]=(num >> 24) & 0xFF;
    bytes[1]=(num >> 16) & 0xFF;
    bytes[2]=(num >>  8) & 0xFF;
    bytes[3]=num         & 0xFF;
    
    NSData *numData=[[NSData alloc]initWithBytes:bytes length:4];
    return numData;
}

-(void)dealloc
{
    [super dealloc];
    [_segControl release];
    [_MsgTableView release];
    [_bodyList release];
    [_nameList release];
    [_timeList release];
    [_titleList release];
    
}


@end
