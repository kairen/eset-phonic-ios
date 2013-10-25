//
//  IntroController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class IntroView;
@class IntroModule;

@interface IntroController : HttpPostController<UITextViewDelegate>


@property(nonatomic, strong) IntroView *introView;
@property(nonatomic, strong) IntroModule *introModule;
@end
