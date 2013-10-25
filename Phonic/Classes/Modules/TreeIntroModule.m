//
//  TreeIntroModule.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/8.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TreeIntroModule.h"

@implementation TreeIntroModule

-(id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.treeID = [dict valueForKey:@"ID"] ;
        self.treeName = [[dict valueForKey:@"NAME"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText1 = [[dict valueForKey:@"DATA"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText2 = [[NSString stringWithFormat:@"%d",[[dict objectForKey:@"TXT1"] intValue]]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.treeText3 = [[dict valueForKey:@"DATA2"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        
        self.treeTitles = @"樹種編號：%@\n\n樹種名稱：%@\n\n樹種特性：%@\n\n樹種數量：%@\n\n備註說明：%@\n\n";
     
    }
    return self;
}

+(id) treeIntroWithDictt:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
