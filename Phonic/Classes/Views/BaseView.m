//
//  BaseView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/4.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self dateCheck];

        
        switch (self.styleTypes) {
            case 0:
            {
                self.image = [UIImage imageNamed:@"春-內頁.fw.png"];
                break;
            }
            case 1:
            {
                self.image = [UIImage imageNamed:@"夏-內頁.fw.png"];
                break;
            }
            case 2:
            {
                self.image = [UIImage imageNamed:@"秋-內頁.fw.png"];
                break;
            }
            case 3:
            {
                self.image = [UIImage imageNamed:@"冬-內頁.fw.png"];
                break;
            }
        }
       
        
        
        
        self.backbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 45, self.frame.size.height - 45, 35, 35)];
        [self.backbtn setBackgroundImage:[UIImage imageNamed:@"回上頁.png"] forState:UIControlStateNormal];
        [self.backbtn setAlpha:1.0];
        [self addSubview:self.backbtn];
    }
    return self;
}

-(void) setBackbtnWithNolImage:(NSString*)nol andHigImage:(NSString*)Hig
{
  [self.backbtn setBackgroundImage:[UIImage imageNamed:nol] forState:UIControlStateNormal];
    [self.backbtn setBackgroundImage:[UIImage imageNamed:Hig] forState:UIControlStateHighlighted];
}


-(void) dateCheck
{
    NSDate *date = [NSDate new];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    if([dateStr intValue] >= 2 && [dateStr intValue] <= 4)
    {
        self.styleTypes = SpringStyle;
    }
    else if([dateStr intValue] >= 5 && [dateStr intValue] <= 7)
    {
        self.styleTypes = SummerStyle;
    }
    else if([dateStr intValue] >= 8 && [dateStr intValue] <= 10)
    {
        self.styleTypes = AutumnStyle;
    }
    else 
    {
        self.styleTypes = WinterStyle;
    }
}

@end
