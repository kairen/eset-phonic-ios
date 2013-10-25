//
//  TreeIntroView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface ArborIntroListView : BaseView

@property(nonatomic, strong) UILabel *unitLabel;
@property(nonatomic, strong) UILabel *areaLabel;
@property(nonatomic, strong) UILabel *treeLabel;
@property(nonatomic, strong) UILabel *numLabel;

@property(nonatomic, strong) UIButton *selectUnit;
@property(nonatomic, strong) UIButton *selectArea;
@property(nonatomic, strong) UIButton *selectTree;
@property(nonatomic, strong) UIButton *selectNum;

@property(nonatomic, strong)UIButton  *searchBtn;

@end
