//
//  TreeIntroListView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/5/11.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TreeIntroListView.h"

@implementation TreeIntroListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.treeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.153125, self.frame.size.height * 0.40145985, 190 , 31)];
        self.treeLabel.font = [UIFont boldSystemFontOfSize:20];
        self.treeLabel.backgroundColor = [UIColor clearColor];
        self.treeLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0];
        self.treeLabel.text = @"樹種";
        self.treeLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.treeLabel];
        
        
        self.selectTree = [[UIButton alloc]initWithFrame: CGRectMake(self.frame.size.width * 0.16875, self.frame.size.height * 0.47262774, 212, 31)];
        [self.selectTree setBackgroundImage:[UIImage imageNamed:@"combobox.png"] forState:UIControlStateNormal];
        [self.selectTree setTitle:@"選擇樹種  " forState:UIControlStateNormal];
        [self.selectTree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.selectTree];
        
        
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.searchBtn.frame = CGRectMake(self.frame.size.width * 0.3125, self.frame.size.height * 0.64233577, 120, 44);
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"查詢02.fw.png"] forState:UIControlStateNormal];
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"查詢01.fw.png"] forState:UIControlStateHighlighted];
        
        [self addSubview:self.searchBtn];
    }
    return self;
}


@end
