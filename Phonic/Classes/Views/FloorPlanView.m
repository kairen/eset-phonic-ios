//
//  FloorPlanView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "FloorPlanView.h"

@implementation FloorPlanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backbtn.frame = CGRectMake(self.frame.size.width * 0.1875, self.frame.size.height * 0.83759124, 200, 50);
        self.zoomView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, self.frame.size.height * 0.27007299, 300, 250)];
        self.planView = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(0 , 0, 300, 250)];
        self.planView.userInteractionEnabled = YES;
        self.planView.layer.cornerRadius = 10.0;
        self.planView.needSave = NO;
        
        
        [self.zoomView addSubview:self.planView];
        [self addSubview:self.zoomView];
        
        
    }
    return self;
}



@end
