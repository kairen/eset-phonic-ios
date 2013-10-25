//
//  TreeIntroListController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/5/11.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class TreeIntroListView;
@class EPPickerView;

@interface TreeIntroListController : HttpPostController
{
    BOOL isTree;
    NSDictionary *treeDict;
}

@property(nonatomic, strong) TreeIntroListView *treeIntroListView;

@property(nonatomic, strong) NSMutableArray *treeIds;
@property(nonatomic, strong) NSMutableArray *treeNames;

@property(nonatomic, strong) EPPickerView *pickView;
@end
