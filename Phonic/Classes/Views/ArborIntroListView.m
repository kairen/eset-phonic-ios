//
//  TreeIntroView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ArborIntroListView.h"

@implementation ArborIntroListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.18065693, 190 , 31)];
        self.unitLabel.font = [UIFont boldSystemFontOfSize:20];
        self.unitLabel.backgroundColor = [UIColor clearColor];
        self.unitLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.unitLabel.text = @"臺中市行政區";
        self.unitLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.unitLabel];
        
        self.selectUnit = [[UIButton alloc]initWithFrame: CGRectMake(self.frame.size.width * 0.16875, self.frame.size.height * 0.24270073, 212, 31)];
        [self.selectUnit setTitle:@"選擇行政區  " forState:UIControlStateNormal];
        [self.selectUnit setBackgroundImage:[UIImage imageNamed:@"combobox.png"] forState:UIControlStateNormal];
        [self.selectUnit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.selectUnit];
        
        self.areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.3120438, 190 , 31)];
        self.areaLabel.font = [UIFont boldSystemFontOfSize:20];
        self.areaLabel.backgroundColor = [UIColor clearColor];
        self.areaLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.areaLabel.text = @"空品淨化區名稱";
        self.areaLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.areaLabel];
        
        self.selectArea = [[UIButton alloc ]initWithFrame: CGRectMake(self.frame.size.width * 0.16875, self.frame.size.height * 0.37591241, 212, 31)];
        [self.selectArea setTitle:@"選擇空品區域  " forState:UIControlStateNormal];
        [self.selectArea setBackgroundImage:[UIImage imageNamed:@"combobox.png"] forState:UIControlStateNormal];
        [self.selectArea setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self addSubview:self.selectArea];
        
        
        self.treeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.4379562, 190 , 31)];
        self.treeLabel.font = [UIFont boldSystemFontOfSize:20];
        self.treeLabel.backgroundColor = [UIColor clearColor];
        self.treeLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.treeLabel.text = @"樹種";
        self.treeLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.treeLabel];
        
        
        self.selectTree = [[UIButton alloc]initWithFrame: CGRectMake(self.frame.size.width * 0.16875, self.frame.size.height * 0.50912409, 212, 31)];
        [self.selectTree setTitle:@"選擇樹種  " forState:UIControlStateNormal];
        [self.selectTree setBackgroundImage:[UIImage imageNamed:@"combobox.png"] forState:UIControlStateNormal];
        [self.selectTree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.selectTree];
        
        
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.57846715, 190 , 31)];
        self.numLabel.font = [UIFont boldSystemFontOfSize:20];
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.numLabel.text = @"喬木編號";
        self.numLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.numLabel];
        
        self.selectNum = [[UIButton alloc ]initWithFrame: CGRectMake(self.frame.size.width * 0.16875, self.frame.size.height * 0.64963504, 212, 31)];
        [self.selectNum setTitle:@"選擇編號  " forState:UIControlStateNormal];
        [self.selectNum setBackgroundImage:[UIImage imageNamed:@"combobox.png"] forState:UIControlStateNormal];
        [self.selectNum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [self addSubview:self.selectNum];
        
        
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.searchBtn.frame = CGRectMake(self.frame.size.width * 0.3125, self.frame.size.height * 0.79014599, 120, 44);
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"查詢02.fw.png"] forState:UIControlStateNormal];
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"查詢01.fw.png"] forState:UIControlStateHighlighted];
        
        [self addSubview:self.searchBtn];
        
        
    }
    return self;
}



@end
