//
//  PhotoController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class PhotoView;
@class PhotoTreeView;
@interface PhotoController : HttpPostController
{
    NSString *controlType;
    NSMutableArray *titleData;
    
}

@property(nonatomic, strong) PhotoView *photoView;
@property(nonatomic, strong) PhotoTreeView *photoTreeView;

-(id) initWithType:(NSString*)type;
@end
