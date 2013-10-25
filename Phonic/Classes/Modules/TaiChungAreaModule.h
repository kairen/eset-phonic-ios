//
//  TaiChungAreaModule.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaiChungAreaModule : NSObject

@property(nonatomic) int areaID;
@property(nonatomic, strong) NSString *areaName;

-(id)initWithDict:(NSDictionary*)dict;;
+(id) taichungAreaWithDict:(NSDictionary*)dict;

@end
