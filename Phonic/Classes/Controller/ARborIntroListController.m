//
//  TreeIntroController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ARborIntroListController.h"
#import "ArborIntroListView.h"
#import "TreeIntroController.h"
#import "EPPickerView.h"

@interface ARborIntroListController ()

@end

@implementation ARborIntroListController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.treeIntroView = [[ArborIntroListView alloc]initWithFrame:self.view.frame];
    self.view = self.treeIntroView;
    
    [self.treeIntroView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self .treeIntroView.selectUnit addTarget:self action:@selector(openUnitPickView) forControlEvents:UIControlEventTouchUpInside];
    [self .treeIntroView.selectArea addTarget:self action:@selector(openAreaPickView) forControlEvents:UIControlEventTouchUpInside];
    [self .treeIntroView.selectTree addTarget:self action:@selector(openTreePickView) forControlEvents:UIControlEventTouchUpInside];
    [self .treeIntroView.selectNum addTarget:self action:@selector(openNumberPickView) forControlEvents:UIControlEventTouchUpInside];
    [self.treeIntroView.searchBtn addTarget:self action:@selector(gotoTreeIntroController) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadingTreeIntroData];
    
    isTree = NO;
    isNum = NO;
    isArea = NO;
}

#pragma mark - Loading ... Data

-(void) loadingTreeIntroData
{
    self.idArray = [[NSMutableArray alloc]init];
    self.nameArray = [[NSMutableArray alloc]init];
    
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self taichungAreaPath]];
    
    for(NSString *data in dict)
    {
        for(NSDictionary *dictData in [dict objectForKey:data])
        {
            [self.idArray addObject:[dictData objectForKey:@"ID"]];
            [self.nameArray addObject:[dictData objectForKey:@"NAME"]];
        }
    }
}

#pragma mark - Open Picker View Btn

-(void) openUnitPickView
{
    if (self.pickView == nil)
    {
        self.pickView = [EPPickerView newPickerView:self action:@selector(unitPickDoneAction:)];
        self.pickView.dataSource = [NSMutableArray arrayWithCapacity:self.nameArray.count];
        for (NSString *str in self.nameArray)
            [self.pickView.dataSource addObject:str];

        [self.view.window addSubview: self.pickView];
    }
}

- (void) unitPickDoneAction:(id)sender
{
    int row = [self.pickView.pickerView selectedRowInComponent:0];
    NSLog(@"%@",[self.idArray objectAtIndex:row]);
    
    if(self.areaIds == nil)
    {
         self.areaIds = [[NSMutableArray alloc]init];
        self.areaNames = [[NSMutableArray alloc]init]; 
    }
    else
    {
        [self.areaIds removeAllObjects];
        [self.areaNames removeAllObjects];

    }
    if(self.treeNames == nil)
    {
        self.treeIds = [[NSMutableArray alloc]init];
        self.treeNames = [[NSMutableArray alloc]init];
    }
    else
    {
        [self.treeNames removeAllObjects];
        [self.treeIds removeAllObjects];

    }
    
    if(self.numIds != nil)
    {
        [self.numIds removeAllObjects];
    }
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService3URL,[self.idArray objectAtIndex:row]]  completionHandler:^(id obj)
     {
         if(obj)
         {
             NSDictionary *dict = (NSDictionary *)obj;
             for(NSString *data in dict)
             {
                 for(NSDictionary *dictData in [dict objectForKey:data])
                 {
                     [self.areaIds addObject:[dictData objectForKey:@"ID"]];
                     [self.areaNames addObject:[[dictData objectForKey:@"NAME"] stringByReplacingOccurrencesOfString:@"~~#" withString:@"\n"]];
                 }
             }
         }
         if(self.areaIds.count == 0)
         {
             [self.areaIds removeAllObjects];
             [self.areaNames removeAllObjects];
             [self.treeIds removeAllObjects];
             [self.treeNames removeAllObjects];
         }
         else
         {
             nowAreaID = -1;
             nowTree = -1;
             isTree = NO;
             isArea = YES;
             isNum = NO;
             isSearch = NO;
         }

     }];
    [self.pickView removeFromSuperview];
    self.pickView = nil;
    
    
    self.treeIntroView.selectArea.titleLabel.alpha = self.treeIntroView.selectTree.titleLabel.alpha = self.treeIntroView.selectUnit.titleLabel.alpha = self.treeIntroView.selectNum.titleLabel.alpha = 0.5;
    [UIView animateWithDuration:1 animations:^{
        self.treeIntroView.selectArea.titleLabel.alpha = self.treeIntroView.selectTree.titleLabel.alpha = self.treeIntroView.selectUnit.titleLabel.alpha = self.treeIntroView.selectNum.titleLabel.alpha = 1.0;
        [self.treeIntroView.selectUnit setTitle:[NSString stringWithFormat:@"%@",[self.nameArray objectAtIndex:row]] forState:UIControlStateNormal];
        [self.treeIntroView.selectArea setTitle:@"選擇空品區域" forState:UIControlStateNormal];
        [self.treeIntroView.selectTree setTitle:@"選擇樹種" forState:UIControlStateNormal];
        [self.treeIntroView.selectNum setTitle:@"選擇編號" forState:UIControlStateNormal];
    }];
}

-(void) openAreaPickView
{
    if (self.pickView == nil)
    {
        self.pickView = [EPPickerView newPickerView:self action:@selector(areaPickDoneAction:)];
        self.pickView.dataSource = [NSMutableArray arrayWithCapacity:self.areaNames.count];
        for (NSString *str in self.areaNames)
            [self.pickView.dataSource addObject:str];
        [self.view.window addSubview: self.pickView];
    }
}
- (void) areaPickDoneAction:(id)sender
{
    int row = [self.pickView.pickerView selectedRowInComponent:0];

    if(isArea)
    {
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService9URL,[self.areaIds objectAtIndex:row]]  completionHandler:^(id obj)
         {
             if(obj)
             {
                 NSDictionary *dict = (NSDictionary *)obj;
                 
                 for(NSString *data in dict)
                 {
                     for(NSDictionary *dictData in [dict objectForKey:data])
                     {
                         [self.treeIds addObject:[dictData objectForKey:@"ID"]];
                         [self.treeNames addObject:[dictData objectForKey:@"NAME"]];
                     }
                 }
                 nowAreaID = row;
                 isTree = YES;
             }
         }];
        
        self.treeIntroView.selectArea.titleLabel.alpha =  self.treeIntroView.selectNum.titleLabel.alpha = self.treeIntroView.selectTree.alpha = 0.5;
        [UIView animateWithDuration:1 animations:^{
            self.treeIntroView.selectArea.titleLabel.alpha = self.treeIntroView.selectNum.titleLabel.alpha = self.treeIntroView.selectTree.alpha = 1.0;
            [self.treeIntroView.selectArea setTitle:[NSString stringWithFormat:@"%@",[self.areaNames objectAtIndex:row]] forState:UIControlStateNormal];
            [self.treeIntroView.selectTree setTitle:[NSString stringWithFormat:@"選擇樹種"] forState:UIControlStateNormal];
            [self.treeIntroView.selectNum setTitle:[NSString stringWithFormat:@"選擇編號"] forState:UIControlStateNormal];
        }];

    }
    
    [self.pickView removeFromSuperview];
    self.pickView = nil;
}

#pragma mark - Tree Pick

-(void) openTreePickView
{
    if (self.pickView == nil)
    {
        self.pickView = [EPPickerView newPickerView:self action:@selector(treePickDoneAction:)];
        self.pickView.dataSource = [NSMutableArray arrayWithCapacity:self.treeNames.count];
        for (NSString *str in self.treeNames)
            [self.pickView.dataSource addObject:str];
        [self.view.window addSubview: self.pickView];
        }
}

- (void) treePickDoneAction:(id)sender
{
    int row = [self.pickView.pickerView selectedRowInComponent:0];
    
    if(isTree)
    {
            [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService11URL,[self.areaIds objectAtIndex:nowAreaID],@"ALL",[self.treeIds objectAtIndex:row]]  completionHandler:^(id obj)
             {
                 if(obj)
                 {
                     NSMutableArray *ids = [[NSMutableArray alloc]init];
                     NSDictionary *dict = (NSDictionary *)obj;
                     for(NSString *data in dict)
                     {
                         for(NSDictionary *dictData in [dict objectForKey:data])
                         {
                             [ids addObject:[dictData objectForKey:@"ID"]];
                         }
                         self.numIds = ids;
                     }
                     nowTree = row;
                     isNum = YES;
                 }
             }];
       
        self.treeIntroView.selectTree.titleLabel.alpha =  self.treeIntroView.selectNum.titleLabel.alpha = 0.5 ;
        [UIView animateWithDuration:1 animations:^{
            self.treeIntroView.selectTree.titleLabel.alpha =  self.treeIntroView.selectNum.titleLabel.alpha = 1.0 ;
            [self.treeIntroView.selectTree setTitle:[NSString stringWithFormat:@"%@ ",[self.treeNames objectAtIndex:row]] forState:UIControlStateNormal];
             [self.treeIntroView.selectNum setTitle:[NSString stringWithFormat:@"選擇編號 "] forState:UIControlStateNormal];
        }];
    }
    [self.pickView removeFromSuperview];
    self.pickView = nil;
    
}

#pragma mark - Number Pick

-(void) openNumberPickView
{
    if (self.pickView == nil)
    {
        self.pickView = [EPPickerView newPickerView:self action:@selector(numberPickDoneAction:)];
        self.pickView.dataSource = [NSMutableArray arrayWithCapacity:self.numIds.count];
        for (NSString *str in self.numIds)
            [self.pickView.dataSource addObject:str];
        [self.view.window addSubview: self.pickView];
    }
}

- (void) numberPickDoneAction:(id)sender
{
    int row = [self.pickView.pickerView selectedRowInComponent:0];
    
    if(isNum)
    {
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService12URL,[self.numIds objectAtIndex:row],[self.areaIds objectAtIndex:nowAreaID]] completionHandler:^(id obj){
            if(obj)
            {
                numDict = (NSDictionary *)obj;
                isSearch = YES;
            }
            
        }];
         self.treeIntroView.selectNum.titleLabel.alpha = 0.5 ;
        [UIView animateWithDuration:1 animations:^{
             self.treeIntroView.selectNum.titleLabel.alpha = 1.0 ;
            [self.treeIntroView.selectNum setTitle:[NSString stringWithFormat:@"%@ ",[self.numIds objectAtIndex:row]] forState:UIControlStateNormal];
        }];
    }
    [self.pickView removeFromSuperview];
    self.pickView = nil;
}

-(void) gotoTreeIntroController
{
    if(isSearch)
    {
        for(NSString *data in numDict)
        {
            int cou = 0;
            for(NSDictionary *dictData in [numDict objectForKey:data])
            {
                TreeIntroController *treeIntroController = [[TreeIntroController alloc]initWithDict:dictData andType:@"Arbor" areaID:[self.areaIds objectAtIndex:nowAreaID]];
                cou = 1;
                [self transitionToViewController:treeIntroController withType:@"rippleEffect"];
            }
            if(cou == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"訊息" message:@"目前暫無資料！！" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"訊息" message:@"請正確選擇" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alert show];
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
