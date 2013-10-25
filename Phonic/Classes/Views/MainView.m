//
//  MainView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/3/20.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backbtn.hidden = YES;
        
        switch (self.styleTypes) {
            case 0:
            {
                self.image = [UIImage imageNamed:@"春-首頁.fw.png"];
                break;
            }
            case 1:
            {
                self.image = [UIImage imageNamed:@"夏-首頁.fw.png"];
                break;
            }
            case 2:
            {
                self.image = [UIImage imageNamed:@"秋-首頁.fw.png"];
                break;
            }
            case 3:
            {
                self.image = [UIImage imageNamed:@"冬-首頁.fw.png"];
                break;
            }
        }
        
        self.mbiBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width / 2) - 60, self.frame.size.height * 0.67 - 50 , 120, 50)];
        [self.mbiBtn setBackgroundImage:[UIImage imageNamed:@"main01.png"] forState:UIControlStateNormal];
        
        self.mtiBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height * 0.67, 93, 44)];
        [self.mtiBtn setBackgroundImage:[UIImage imageNamed:@"喬木履歷.fw.png"] forState:UIControlStateNormal];
        
        self.treeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.mtiBtn.frame.size.width + self.mtiBtn.frame.origin.x + 10, self.frame.size.height * 0.67,93,44)];
        [self.treeBtn setBackgroundImage:[UIImage imageNamed:@"喬木圖鑑.fw.png"]forState:UIControlStateNormal];
        
        self.qrCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.treeBtn.frame.size.width + self.treeBtn.frame.origin.x + 10, self.frame.size.height * 0.67,93,44)];
        [self.qrCodeBtn setBackgroundImage:[UIImage imageNamed:@"掃瞄QR Code.fw.png"]forState:UIControlStateNormal];
        
        self.mbiBtn.alpha = self.mtiBtn.alpha = self.qrCodeBtn.alpha = self.treeBtn.alpha = 0.0;
        
        [self addSubview:self.mbiBtn];
        [self addSubview:self.mtiBtn];
        [self addSubview:self.treeBtn];
        [self addSubview:self.qrCodeBtn];
        
        [self performSelector:@selector(mainViewAnimation) withObject:nil afterDelay:2];
        
    }
    return self;
}

-(void) mainViewAnimation
{
    [UIView animateWithDuration:1.5 animations:^{
        self.mbiBtn.alpha = self.mtiBtn.alpha = self.qrCodeBtn.alpha = self.treeBtn.alpha = 1.0;
    }];
}


@end
