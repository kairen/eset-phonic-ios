//
//  FloorPlanController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class FloorPlanView;

@interface FloorPlanController : HttpPostController<UIScrollViewDelegate>
{
    NSString *controlType;
}


@property(nonatomic, strong) FloorPlanView *floorPlanView;


-(id) initWithType:(NSString*)type;
@end
