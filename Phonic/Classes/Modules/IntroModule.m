//
//  IntroModule.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "IntroModule.h"

@implementation IntroModule


-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self)
    {
        self.defineText = [[dict valueForKey:@"DATA"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
    }
    return self;
}

+(id) introWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
