//
//  MapController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"
#import "AirQualityModule.h"

@class MapView;

@interface MapController : HttpPostController
{
    NSString *controlType;
}

@property(nonatomic, strong) MapView *mapView;
@property(nonatomic, strong) AirQualityModule *airQuality;

-(id) initWithType:(NSString*)type;

@end
