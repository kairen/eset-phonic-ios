//
//  IntroModule.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroModule : NSObject

@property(nonatomic, strong) NSString *defineText;

-(id)initWithDict:(NSDictionary*)dict;
+(id) introWithDict:(NSDictionary*)dict;
@end
