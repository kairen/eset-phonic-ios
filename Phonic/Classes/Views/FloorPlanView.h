//
//  FloorPlanView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface FloorPlanView : BaseView

@property(nonatomic, strong) UIScrollView *zoomView;
@property(nonatomic, strong) KRAsyncImageView *planView;

@end
