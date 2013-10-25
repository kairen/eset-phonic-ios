//
//  TaiChungMapView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface TaiChungMapView : BaseView

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *taiLabel;

@property(nonatomic, strong) UIButton *searchBtn;

@property(nonatomic, strong) KRAsyncImageView *areaView;

@property(nonatomic, strong) UIScrollView *listView;
@end
