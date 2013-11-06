//
//  TaiChungMapController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TaiChungMapController.h"
#import "TaiChungMapView.h"
#import "TaiChungAreaModule.h"
#import "AirQualityController.h"
#import "EPPickerView.h"

@interface TaiChungMapController ()

@end

@implementation TaiChungMapController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.taiChungMapView = [[TaiChungMapView alloc]initWithFrame:self.view.frame];
    self.view = self.taiChungMapView;
    
    [self.taiChungMapView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.taiChungMapView.searchBtn addTarget:self action:@selector(openUnitPickView) forControlEvents:UIControlEventTouchUpInside];
    
    self.areaIds = [[NSMutableArray alloc]init];
    self.areaNames = [[NSMutableArray alloc]init];
    
    [self loadData];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.pickView removeFromSuperview];
    self.pickView = nil;
}

-(void) loadData
{
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self taichungAreaPath]];
    
    for(NSString *data in dict)
    {
        for(NSDictionary *dictData in [dict objectForKey:data])
        {
            [self.areaIds addObject:[dictData objectForKey:@"ID"]];
            [self.areaNames addObject:[dictData objectForKey:@"NAME"]];
        }
    }
}

#pragma mark - Open Picker View Btn

-(void) openUnitPickView
{
    if (self.pickView == nil)
    {
        self.pickView = [EPPickerView newPickerView:self action:@selector(unitPickDoneAction:)];
        
        self.pickView.dataSource = [NSMutableArray arrayWithCapacity:self.areaNames.count];
        for (NSString *str in self.areaNames)
            [self.pickView.dataSource addObject:str];
        
        [self.view.window addSubview: self.pickView];
    }
}

- (void) unitPickDoneAction:(id)sender
{
    int row = [self.pickView.pickerView selectedRowInComponent:0];
    
    NSLog(@"%@",[self.areaIds objectAtIndex:row]);
    
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService3URL,[self.areaIds objectAtIndex:row]] completionHandler:^(id obj){
        if(obj)
        {
            NSDictionary *dict = (NSDictionary *)obj;
            
            [self createAreaNameBtnWitg:dict];
            
        }
         
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService17URL,[self.areaIds objectAtIndex:row]] completionHandler:^(id obj){
            if(obj)
            {
                NSDictionary *dict = (NSDictionary *)obj;
                for(NSString *data in dict)
                {
                    for(NSDictionary *dictData in [dict valueForKey:data])
                    {
                        self.taiChungMapView.areaView.imageUrl = [dictData valueForKey:@"URL"];
                        NSLog(@"%@",[dictData valueForKey:@"URL"]);
                    }
                    self.taiChungMapView.areaView.alpha = 0.0;
                    [UIView animateWithDuration:0.3 animations:^{
                        self.taiChungMapView.areaView.alpha = 1.0;
                       
                    }];
                }
                
            }
        }];
    }];
    
    self.taiChungMapView.searchBtn.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        self.taiChungMapView.searchBtn.alpha = 1.0;
        [self.taiChungMapView.searchBtn setTitle:[self.areaNames objectAtIndex:row] forState:UIControlStateNormal];
    }];
    
    
    [self.pickView removeFromSuperview];
    self.pickView = nil;
    
}


#pragma mark - Create btn

-(void) createAreaNameBtnWitg:(NSDictionary*)dict
{
        [UIView animateWithDuration:0.5 animations:^{
           for(UIView *aView in self.taiChungMapView.listView.subviews)
           {
               aView.alpha = 0.0;
           }
        }
        completion:^(BOOL ok){
            for(UIView *aView in self.taiChungMapView.listView.subviews)
            {
                [aView removeFromSuperview];
            }
         
         
         for(NSString *data in dict)
         {
             [UIView animateWithDuration:0.5 animations:^{
                 
                 int count = 0,x = 5, y = 5 ;
                 for(NSDictionary *dictData in [dict valueForKey:data])
                 {
                     self.tcAreaModule = [TaiChungAreaModule taichungAreaWithDict:dictData];
                     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 200, (self.taiChungMapView.listView.frame.size.height - 20 ) / 3)];
                     btn.backgroundColor = [UIColor clearColor];
                     [btn setTitle:[NSString stringWithFormat:@"%@",self.tcAreaModule.areaName] forState:UIControlStateNormal];
                     btn.tag = self.tcAreaModule.areaID;
                     btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                     [btn addTarget:self action:@selector(areaLoactionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                     [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                     btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                     btn.titleLabel.adjustsFontSizeToFitWidth = YES;
                     [self.taiChungMapView.listView addSubview:btn];
                     
                     count ++;
                     if(count >= 3)
                     {
                         x += 200;
                         count = 0;
                         y = 5;
                     }
                     else
                     {
                         y += ((self.taiChungMapView.listView.frame.size.height - 20 ) / 3)  + 5;
                     }
                     
                 }
                 self.taiChungMapView.listView.contentSize = CGSizeMake(x, self.taiChungMapView.listView.frame.size.height);
             }];
         }
        }];
}


#pragma mark - area Location btn Action

-(void) areaLoactionBtnAction:(id)sender
{
   
    UIButton *btn = (UIButton*)sender;
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService4URL,btn.tag] completionHandler:^(id obj){
         if(obj)
         {
             NSDictionary *dict = (NSDictionary *)obj;
             
             for(NSString *data in dict)
             {
                 for(NSDictionary *dictData in [dict valueForKey:data])
                 {
                     AirQualityController *airController = [[AirQualityController alloc]initWithDict:dictData];
                     [self transitionToViewController:airController withType:@"rippleEffect"];

                 }
             }
             
        }
        
      }];
}


#pragma mark - Translater Animation

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"suckEffect"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
