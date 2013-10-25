//
//  TreeIntroController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class TreeIntroView;
@class TreeIntroModule;
@class ArborIntroModule;

@interface TreeIntroController : HttpPostController<UITextViewDelegate>
{
    @private
    NSString *controlType;
    NSString *areaID;
}
@property(nonatomic, strong) TreeIntroView *treeIntroView;

@property(nonatomic, strong) TreeIntroModule *treeIntroModule;
@property(nonatomic, strong) ArborIntroModule *arborIntroModule;

-(id)initWithDict:(NSDictionary*)dict andType:(NSString*)type areaID:(NSString*)areaid;

@end
