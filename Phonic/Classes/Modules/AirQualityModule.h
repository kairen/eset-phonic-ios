//
//  AirQualityModule.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirQualityModule : NSObject

@property(nonatomic) int airQualityID;
@property(nonatomic, strong) NSString *airQualityName;

@property(nonatomic, strong) NSString *airQualityText1;
@property(nonatomic, strong) NSString *airQualityText2;
@property(nonatomic, strong) NSString *airQualityText3;
@property(nonatomic, strong) NSString *airQualityText4;
@property(nonatomic, strong) NSString *airQualityText5;
@property(nonatomic, strong) NSString *airQualityText6;
@property(nonatomic, strong) NSString *airQualityText7;
@property(nonatomic, strong) NSString *airQualityText8;
@property(nonatomic, strong) NSString *airQualityText9;
@property(nonatomic, strong) NSString *airQualityText10;
@property(nonatomic, strong) NSString *airQualityText11;

@property(nonatomic, strong) NSString *airQualityData;

@property(nonatomic, strong) NSString *airQualityTitles;

-(id)initWithDict:(NSDictionary*)dict;;
+(id) airQualityWithDictt:(NSDictionary*)dict;

@end


#pragma mark - Encodeing...;

@interface NSString (URLEncoding)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
