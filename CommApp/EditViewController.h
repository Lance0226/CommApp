//
//  EditViewController.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"
#import "CustomTextField.h"

@interface EditViewController : UIViewController<NavigationBarDelegate>

@property (nonatomic,strong)UINavigationBar *navigationBar;
@property (nonatomic,strong) CustomeTextField *inputField;

-(void)addNavigationBar;
-(void)addInputField;
@end
