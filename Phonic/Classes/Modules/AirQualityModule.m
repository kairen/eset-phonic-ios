//
//  AirQualityModule.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AirQualityModule.h"

@implementation AirQualityModule



-(id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.airQualityID = [[dict valueForKey:@"ID"] intValue];
        self.airQualityName = [[dict valueForKey:@"NAME"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText1 = [[dict valueForKey:@"TXT1"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText2 = [[dict valueForKey:@"TXT2"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText3 = [[dict valueForKey:@"TXT3"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText4 = [[dict valueForKey:@"TXT4"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText5 = [[dict valueForKey:@"TXT5"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText6 = [[dict valueForKey:@"TXT6"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText7 = [[dict valueForKey:@"TXT7"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText8 = [[dict valueForKey:@"TXT8"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText9 = [[dict valueForKey:@"TXT9"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText10 = [[dict valueForKey:@"TXT10"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
        self.airQualityText11 = [[dict objectForKey:@"TXT11"]stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];

        self.airQualityData = [[dict objectForKey:@"DATA"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"];
    
        self.airQualityTitles = @"經費來源:%@\n基地類型:%@\n行政區域:%@\n基地面積:%@\n核定年度:%@\n維護單位:%@\n聯絡資訊:%@\n認養單位:%@\n內部設施:%@\n基地位置:%@\n基地坐標:%@\n使用現況:\n%@";
    }
    return self;
}

+(id) airQualityWithDictt:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}



@end


#pragma mark - Encodeing

@implementation NSString (URLEncoding)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% °",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end