//
//  UITextField+CustomTextField.m
//  CommApp
//
//  Created by 韩渌 on 15/7/23.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomeTextField


//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [[UIColor orangeColor] setFill];
}


@end
