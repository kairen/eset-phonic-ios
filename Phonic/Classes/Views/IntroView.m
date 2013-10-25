//
//  IntroView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "IntroView.h"

@implementation IntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.0625 + 13, self.frame.size.height * 0.17883212, 320, 40)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.titleLabel.text = @"空品淨化區定義";
        
        self.defineText = [[UITextView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.0625 + 10, self.frame.size.height * 0.26459854, 280, self.frame.size.height * 0.54744526)];
        self.defineText.backgroundColor = [UIColor clearColor];
        self.defineText.textColor = [UIColor blackColor];
        self.defineText.showsHorizontalScrollIndicator = NO;
        self.defineText.font = [UIFont systemFontOfSize:18];
    
        self.airIntroBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width / 2) - (166 / 2), self.frame.size.height * 0.82664234, 166, 44)];
        [self.airIntroBtn setBackgroundImage:[UIImage imageNamed:@"按鈕底圖.fw.png"] forState:UIControlStateNormal];
        [self.airIntroBtn setTitle:@"空品淨化區資料查詢" forState:UIControlStateNormal];
        [self.airIntroBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.airIntroBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.defineText];
        [self addSubview:self.airIntroBtn];
    }
    return self;
}



@end
