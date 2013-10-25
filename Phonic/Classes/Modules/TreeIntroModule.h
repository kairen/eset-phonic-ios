//
//  TreeIntroModule.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/8.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeIntroModule : NSObject

@property(nonatomic, strong) NSString *treeID;
@property(nonatomic, strong) NSString *treeName;
@property(nonatomic, strong) NSString *treeText1;
@property(nonatomic, strong) NSString *treeText2;
@property(nonatomic, strong) NSString *treeText3;

@property(nonatomic, strong) NSString *treeTitles;

-(id)initWithDict:(NSDictionary*)dict;;
+(id) treeIntroWithDictt:(NSDictionary*)dict;

@end
