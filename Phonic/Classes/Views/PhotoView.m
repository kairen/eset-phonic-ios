//
//  PhotoView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backbtn.frame = CGRectMake(self.frame.size.width * 0.1875, self.frame.size.height * 0.83759124, 200, 50);
        self.showImage = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.03125, self.frame.size.height * 0.20072993, 300, self.frame.size.height * 0.3649635 )];
        self.showImage.layer.cornerRadius = 10.0;
        self.showImage.needSave = NO;
        self.showImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.showImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.03125, self.frame.size.height * 0.58211679, 160, 30)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.text = @"照片說明:";
        
        [self addSubview:self.titleLabel];
        
        self.imageBtn1 = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(5, self.frame.size.height * 0.58211679 + 30, 100, 70)];
        self.imageBtn1.layer.cornerRadius = 10.0;
        self.imageBtn1.needSave = NO;
        self.imageBtn1.tag = 0;
        
        self.imageBtn2 = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.imageBtn1.frame.size.width + self.imageBtn1.frame.origin.x + 5, self.frame.size.height * 0.58211679 + 30, 100, 70)];
        self.imageBtn2.layer.cornerRadius = 10.0;
        self.imageBtn2.tag = 1;
        self.imageBtn2.needSave = NO;
        
        self.imageBtn3 = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.imageBtn2.frame.size.width + self.imageBtn2.frame.origin.x + 5, self.frame.size.height * 0.58211679 + 30, 100, 70)];
        self.imageBtn3.layer.cornerRadius = 10.0;
        self.imageBtn3.needSave = NO;
        self.imageBtn3.tag = 2;

        
        [self addSubview:self.imageBtn1];
        [self addSubview:self.imageBtn2];
        [self addSubview:self.imageBtn3];
        
    }
    return self;
}
@end

@implementation PhotoTreeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backbtn.frame = CGRectMake(self.frame.size.width * 0.1875, self.frame.size.height * 0.83759124, 200, 40);
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.18065693 - 20 , 320, 30)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor colorWithRed:0.0 green:0.8 blue:0.8 alpha:1.0 ];
        self.titleLabel.text = @"樹種圖鑒";
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.titleLabel];
        
        self.showImage = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.03125, self.frame.size.height * 0.20072993, 300, self.frame.size.height * 0.3649635 )];
        self.showImage.layer.cornerRadius = 10.0;
        self.showImage.needSave = NO;
        self.showImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.showImage];
        
        self.expLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.03125, self.frame.size.height * 0.58211679,  320, 30)];
        self.expLabel.font = [UIFont boldSystemFontOfSize:20];
        self.expLabel.backgroundColor = [UIColor clearColor];
        self.expLabel.textColor = [UIColor blackColor];
        self.expLabel.text = @"照片說明:";
        self.expLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.expLabel];
        
        self.imageBtn1 = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(5, self.frame.size.height * 0.58211679 + 30, 100, 70)];
        self.imageBtn1.layer.cornerRadius = 10.0;
        self.imageBtn1.needSave = NO;
        self.imageBtn1.tag = 0;
        
        self.imageBtn2 = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.imageBtn1.frame.size.width + self.imageBtn1.frame.origin.x + 5, self.frame.size.height * 0.58211679 + 30, 100, 70)];
        self.imageBtn2.layer.cornerRadius = 10.0;
        self.imageBtn2.tag = 1;
        self.imageBtn2.needSave = NO;
        
        self.imageBtn3 = [[KRAsyncImageView alloc]initWithFrame:CGRectMake(self.imageBtn2.frame.size.width + self.imageBtn2.frame.origin.x + 5, self.frame.size.height * 0.58211679 + 30, 100, 70)];
        self.imageBtn3.layer.cornerRadius = 10.0;
        self.imageBtn3.needSave = NO;
        self.imageBtn3.tag = 2;
        
        [self addSubview:self.imageBtn1];
        [self addSubview:self.imageBtn2];
        [self addSubview:self.imageBtn3];
    }
    return self;
}



@end
