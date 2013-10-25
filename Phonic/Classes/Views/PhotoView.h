//
//  PhotoView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface PhotoView : BaseView

@property(nonatomic, strong) KRAsyncImageView * showImage;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) KRAsyncImageView *imageBtn1;
@property(nonatomic, strong) KRAsyncImageView *imageBtn2;
@property(nonatomic, strong) KRAsyncImageView *imageBtn3;
@end

@interface PhotoTreeView : BaseView

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) KRAsyncImageView * showImage;

@property(nonatomic, strong) UILabel *expLabel;

@property(nonatomic, strong) KRAsyncImageView *imageBtn1;
@property(nonatomic, strong) KRAsyncImageView *imageBtn2;
@property(nonatomic, strong) KRAsyncImageView *imageBtn3;
@end