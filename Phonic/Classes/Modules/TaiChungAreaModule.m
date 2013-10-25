//
//  TaiChungAreaModule.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TaiChungAreaModule.h"

@implementation TaiChungAreaModule

-(id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.areaID = [[dict valueForKey:@"ID"] intValue];
        self.areaName = [[dict valueForKey:@"NAME"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
    }
    return self;
}

+(id) taichungAreaWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
