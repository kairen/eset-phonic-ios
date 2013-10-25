//
//  TreeIntroModule.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/8.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ArborIntroModule.h"

@implementation ArborIntroModule

-(id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.treeID = [dict valueForKey:@"ID"] ;
        self.treeName = [[dict valueForKey:@"NAME"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText1 = [[dict valueForKey:@"TXT1"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText2 = [[dict valueForKey:@"TXT2"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText3 = [[dict valueForKey:@"TXT3"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText4 = [[dict valueForKey:@"DATA"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeTitles = @"喬木編號：%@\n\n樹種名稱：%@\n\n撫育年度：%@\n\n所在區域：%@\n\n樹含碳量：%@\n\n備註說明：%@\n\n";   
    }
    return self;
}

+(id) arborIntroWithDictt:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
