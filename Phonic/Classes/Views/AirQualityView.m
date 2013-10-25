//
//  AirQualityView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AirQualityView.h"

@implementation AirQualityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.0625 + 13, self.frame.size.height * 0.18513139, 280, 30)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        
 
        self.listView = [[UITextView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.0625 + 10, self.frame.size.height * 0.24635036, 280, self.frame.size.height * 0.54744526)];
        self.listView.backgroundColor = [UIColor clearColor];
        self.listView.textColor = [UIColor blackColor];
        self.listView.showsHorizontalScrollIndicator = NO;
        self.listView.font = [UIFont systemFontOfSize:18];
        
        
        self.btnTool = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.03125,self.frame.size.height * 0.79744526, 300, 50)];
        self.btnTool.image = [UIImage imageNamed:@"按鈕底圖.fw.png"];
        self.btnTool.userInteractionEnabled = YES;
        
        self.mapBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 68.75, 40)] ;
        [self.mapBtn setBackgroundImage:[UIImage imageNamed:@"地圖02.fw.png"] forState:UIControlStateNormal];
        [self.mapBtn setBackgroundImage:[UIImage imageNamed:@"地圖01.fw.png"] forState:UIControlStateHighlighted];

        self.photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.mapBtn.frame.size.width + self.mapBtn.frame.origin.x + 5, 5 , 68.75, 40)] ;
        [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"照片02.fw.png"] forState:UIControlStateNormal];
        [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"照片01.fw.png"] forState:UIControlStateHighlighted];
        
        self.floorPlanBtn = [[UIButton alloc]initWithFrame:CGRectMake( self.photoBtn.frame.size.width + self.photoBtn.frame.origin.x + 5,5, 68.75, 40)] ;
        [self.floorPlanBtn setBackgroundImage:[UIImage imageNamed:@"平面圖02.fw.png"] forState:UIControlStateNormal];
        [self.floorPlanBtn setBackgroundImage:[UIImage imageNamed:@"平面圖01.fw.png"] forState:UIControlStateHighlighted];
        
        self.audioBtn = [[UIButton alloc]initWithFrame:CGRectMake( self.floorPlanBtn.frame.size.width + self.floorPlanBtn.frame.origin.x + 5,5, 68.75, 40)] ;
        [self.audioBtn setBackgroundImage:[UIImage imageNamed:@"語音導覽02.fw.png"] forState:UIControlStateNormal];
        [self.audioBtn setBackgroundImage:[UIImage imageNamed:@"語音導覽01.fw.png"] forState:UIControlStateHighlighted];
        
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.listView];
        [self addSubview:self.btnTool];
        [self.btnTool addSubview:self.mapBtn];
        [self.btnTool addSubview:self.photoBtn];
        [self.btnTool addSubview:self.floorPlanBtn];
        [self.btnTool addSubview:self.audioBtn];
        
    }
    return self;
}


@end
