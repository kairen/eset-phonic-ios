//
//  AirQualityView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface AirQualityView : BaseView

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UITextView *listView;

@property(nonatomic, strong) UIImageView *btnTool;

@property(nonatomic, strong) UIButton *mapBtn;
@property(nonatomic, strong) UIButton *photoBtn;
@property(nonatomic, strong) UIButton *floorPlanBtn;
@property(nonatomic, strong) UIButton *audioBtn;

@end
