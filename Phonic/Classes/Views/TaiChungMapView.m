//
//  TaiChungMapView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TaiChungMapView.h"

@implementation TaiChungMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    
        self.taiLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.18065693, 190 , 31)];
        self.taiLabel.font = [UIFont boldSystemFontOfSize:20];
        self.taiLabel.backgroundColor = [UIColor clearColor];
        self.taiLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.taiLabel.text = @"臺中市行政區";
        self.taiLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.taiLabel];
        
        self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.16875, self.frame.size.height * 0.24270073, 212, 31)];

        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"combobox.png"] forState:UIControlStateNormal];
        [self.searchBtn setTitle:@"選擇空品區區域  " forState:UIControlStateNormal];
        [self.searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.searchBtn];
        
        self.areaView = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.0625, self.frame.size.height * 0.32116788 , 280, self.frame.size.height * 0.35583942 )];
        self.areaView.layer.cornerRadius = 10.0;
        self.areaView.contentMode = UIViewContentModeScaleAspectFit;
        self.areaView.backgroundColor = [UIColor clearColor];
        self.areaView.needSave = NO;
        
        [self addSubview:self.areaView];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.70620438, 100, 27)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0.8 blue:0.8 alpha:1.0];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"空品區名稱";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.layer.cornerRadius = 5.0;
        
        self.listView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.125, self.frame.size.height * 0.77007299, 240, self.frame.size.height * 0.19160584)];
        self.listView.backgroundColor = [UIColor clearColor];
        self.listView.layer.cornerRadius = 5.0;
        self.listView.userInteractionEnabled = YES;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.listView];
    }
    return self;
}



@end
