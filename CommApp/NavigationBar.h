//
//  NavigationBar.h
//  CommApp
//
//  Created by lance on 7/22/15.
//  Copyright (c) 2015 hanlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavigationBarDelegate
-(NSString *)setNavigationBarTitle;
@end

@interface NavigationBar : UINavigationBar
{
    id delegate;
}
-(UINavigationBar*)drawNavigationBar;
-(void)setDelegate:(id)newdelegate;

@end

