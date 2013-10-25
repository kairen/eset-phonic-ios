//
//  TreeIntroListController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/5/11.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TreeIntroListController.h"
#import "EPPickerView.h"
#import "TreeIntroListView.h"
#import "EPPickerView.h"
#import "TreeIntroController.h"

@interface TreeIntroListController ()

@end

@implementation TreeIntroListController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.treeIntroListView = [[TreeIntroListView alloc]initWithFrame:self.view.frame];
    self.view = self.treeIntroListView;
    
    [self.treeIntroListView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
     [self.treeIntroListView.searchBtn addTarget:self action:@selector(gotoTreeIntroController) forControlEvents:UIControlEventTouchUpInside];
    [self.treeIntroListView.selectTree addTarget:self action:@selector(openTreePickView) forControlEvents:UIControlEventTouchUpInside];
	[self loadingTreeIntroData];
    isTree = NO;
}

#pragma mark - Loading ... Data

-(void) loadingTreeIntroData
{
    self.treeIds = [[NSMutableArray alloc]init];
    self.treeNames = [[NSMutableArray alloc]init];
    
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self outPath:@"AllTreeData"]];
    for(NSString *data in dict)
    {
        for(NSDictionary *dictData in [dict objectForKey:data])
        {
            [self.treeIds addObject:[dictData objectForKey:@"ID"]];
            [self.treeNames addObject:[dictData objectForKey:@"NAME"]];
        }
    }
}

-(void) openTreePickView
{
    if (self.pickView == nil)
    {
        self.pickView = [EPPickerView newPickerView:self action:@selector(treePickDoneAction:)];
        [self.view.window addSubview: self.pickView];
        
        self.pickView.dataSource = [NSMutableArray arrayWithCapacity:self.treeNames.count];
        for (NSString *str in self.treeNames)
            [self.pickView.dataSource addObject:str];
    }
}

- (void) treePickDoneAction:(id)sender
{
    int row = [self.pickView.pickerView selectedRowInComponent:0];
    
    
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService14URL,[self.treeIds objectAtIndex:row]]  completionHandler:^(id obj)
     {
         if(obj)
         {
             treeDict = (NSDictionary *)obj;
        }
         isTree = YES;
     }];

    
    self.treeIntroListView.selectTree.titleLabel.alpha = 0.5 ;
    [UIView animateWithDuration:1 animations:^{
        self.treeIntroListView.selectTree.titleLabel.alpha = 1.0 ;
        [self.treeIntroListView.selectTree setTitle:[NSString stringWithFormat:@"%@",[self.treeNames objectAtIndex:row]] forState:UIControlStateNormal];
    }];
    
    [self.pickView removeFromSuperview];
    self.pickView = nil;
    
}

-(void) gotoTreeIntroController
{
    if(isTree)
    {
        for(NSString *data in treeDict)
        {
            int cou = 0;
            for(NSDictionary *dictData in [treeDict objectForKey:data])
            {
                TreeIntroController *treeController = [[TreeIntroController alloc]initWithDict:dictData andType:@"Tree" areaID:nil];
                cou = 1;
                [self transitionToViewController:treeController withType:@"rippleEffect"];
            }
            if(cou == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"訊息" message:@"目前暫無資料！！" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Translater Animation

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"suckEffect"];
}

@end
