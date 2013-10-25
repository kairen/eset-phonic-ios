//
//  TreeIntroController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"

@class ArborIntroListView;
@class EPPickerView;

@interface ARborIntroListController : HttpPostController
{
    int nowAreaID,nowTree;
    BOOL isTree,isArea,isNum,isSearch;
    
    NSDictionary *numDict;
}

@property(nonatomic, strong) ArborIntroListView *treeIntroView;


@property(nonatomic, strong) EPPickerView *pickView;
@property(nonatomic, strong) NSMutableArray *idArray;
@property(nonatomic, strong) NSMutableArray *nameArray;

@property(nonatomic, strong) NSMutableArray *areaIds;
@property(nonatomic, strong) NSMutableArray *areaNames;

@property(nonatomic, strong) NSMutableArray *treeIds;
@property(nonatomic, strong) NSMutableArray *treeNames;

@property(nonatomic, strong) NSMutableArray *numIds;

@end
