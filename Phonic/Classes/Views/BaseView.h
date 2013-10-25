//
//  BaseView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/4.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KRAsyncImageView.h"
typedef enum
{
    SpringStyle = 0,
    SummerStyle,
    AutumnStyle,
    WinterStyle,
}StyleTypes;

@interface BaseView : UIImageView



@property(nonatomic, strong) UIButton *backbtn;
@property(nonatomic) StyleTypes styleTypes;


-(void) setBackbtnWithNolImage:(NSString*)nol andHigImage:(NSString*)Hig;

@end
