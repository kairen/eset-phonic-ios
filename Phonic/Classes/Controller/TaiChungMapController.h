//
//  TaiChungMapController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class TaiChungMapView;
@class TaiChungAreaModule;
@class EPPickerView;


@interface TaiChungMapController : HttpPostController 
{
    
}

@property(nonatomic, strong) NSMutableArray *areaIds;
@property(nonatomic, strong) NSMutableArray *areaNames;

@property(nonatomic, strong) TaiChungMapView *taiChungMapView;

@property(nonatomic, strong) TaiChungAreaModule *tcAreaModule;

@property(nonatomic, strong) EPPickerView *pickView;
@end
