//
//  TreeIntroView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TreeIntroView.h"

@implementation TreeIntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backbtn.frame = CGRectMake(self.frame.size.width * 0.0875, self.frame.size.height * 0.77554745, 135, 40);
        self.backbtn.alpha = 1.0;
        
        
        self.listView = [[UITextView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.0625 + 10, (self.frame.size.height * 0.24635036) - 10, 280, self.frame.size.height * 0.54744526)];
        self.listView.backgroundColor = [UIColor clearColor];
        self.listView.textColor = [UIColor blackColor];
        self.listView.showsHorizontalScrollIndicator = NO;
        self.listView.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:self.listView];
        
        self.photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.534375, self.frame.size.height * 0.77554745 , 120, 40)] ;
        [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"照片02.fw.png"] forState:UIControlStateNormal];
        [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"照片01.fw.png"] forState:UIControlStateHighlighted];
        
        [self addSubview:self.photoBtn];
        
        [self setBackbtnWithNolImage:@"回喬木介紹02.fw.png" andHigImage:@"回喬木介紹01.fw.png"];
        
    }
    return self;
}


@end
