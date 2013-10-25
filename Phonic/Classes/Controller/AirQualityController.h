//
//  AirQualityController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class AirQualityModule;
@class AirQualityView;

@interface AirQualityController : HttpPostController <UITextViewDelegate>

@property(nonatomic, strong) AirQualityView *airQualityView;
@property(nonatomic, strong) AirQualityModule *airQualityModule;

-(id)initWithDict:(NSDictionary*)dict;
@end
