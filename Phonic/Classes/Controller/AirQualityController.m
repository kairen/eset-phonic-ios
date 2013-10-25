//
//  AirQualityController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/6.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AirQualityController.h"
#import "AirQualityView.h"
#import "AirQualityModule.h"
#import "MapController.h"
#import "PhotoController.h"
#import "FloorPlanController.h"

@implementation AirQualityController

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.airQualityModule = [AirQualityModule airQualityWithDictt:dict];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.airQualityView = [[AirQualityView alloc]initWithFrame:self.view.frame];
    self.view = self.airQualityView;
    
    [self.airQualityView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.airQualityView.audioBtn addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.airQualityView.mapBtn addTarget:self action:@selector(opeMap) forControlEvents:UIControlEventTouchUpInside];
    [self.airQualityView.photoBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.airQualityView.floorPlanBtn addTarget:self action:@selector(openfloorPlan) forControlEvents:UIControlEventTouchUpInside];
    
    self.airQualityView.listView.delegate = self;
    [self loadAirQualityData];
}

#pragma mark - Loading Data ...

-(void) loadAirQualityData
{
    [UIView animateWithDuration:1 animations:^{
      
        self.airQualityView.titleLabel.text = [NSString stringWithFormat:@"[%d]%@",self.airQualityModule.airQualityID,self.airQualityModule.airQualityName];
        
        self.airQualityView.listView.text = [NSString stringWithFormat:self.airQualityModule.airQualityTitles,
                                             self.airQualityModule.airQualityText1,
                                             self.airQualityModule.airQualityText2,
                                             self.airQualityModule.airQualityText3,
                                             self.airQualityModule.airQualityText4,
                                             self.airQualityModule.airQualityText5,
                                             self.airQualityModule.airQualityText6,
                                             self.airQualityModule.airQualityText7,
                                             self.airQualityModule.airQualityText8,
                                             self.airQualityModule.airQualityText9,
                                             self.airQualityModule.airQualityText10,
                                             self.airQualityModule.airQualityText11,
                                             self.airQualityModule.airQualityData];
        
    }];
}


#pragma mark - button Action

-(void) playAudio
{
    if(self.myPlayer == nil)
    {
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService5URL,self.airQualityModule.airQualityID] completionHandler:^(id obj)
         {
             if(obj)
             {
                 NSDictionary *dict = (NSDictionary*)obj;
                 
                 for(NSString *data in dict)
                 {
                     for(NSDictionary *dictData in [dict valueForKey:data])
                     {
                         if([dictData valueForKey:@"URL"])
                         {
                             [self playAudioWithFile:[dictData valueForKey:@"URL"] AlertSound:NO] ;
                             NSLog(@"%@",[dictData valueForKey:@"URL"]);
                             [self.airQualityView.audioBtn setBackgroundImage:[UIImage imageNamed:@"停止播放02.fw.png"] forState:UIControlStateNormal];
                             [self.airQualityView.audioBtn setBackgroundImage:[UIImage imageNamed:@"停止播放01.fw.png"] forState:UIControlStateHighlighted];
                         }
                     }
                 }
             }
         }];
    }
    else
    {
        [self playAudioWithFile:@"" AlertSound:NO] ;
        [self.airQualityView.audioBtn setBackgroundImage:[UIImage imageNamed:@"語音導覽02.fw.png"] forState:UIControlStateNormal];
        [self.airQualityView.audioBtn setBackgroundImage:[UIImage imageNamed:@"語音導覽01.fw.png"] forState:UIControlStateHighlighted];
    }
}

-(void) opeMap
{
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService6URL,self.airQualityModule.airQualityID] completionHandler:^(id obj)
     {
         if(obj)
         {
             NSDictionary *dict = (NSDictionary*)obj;
             
             [dict writeToFile:[self outPath:@"Map"] atomically:YES];
         }
         MapController *mapController = [[MapController alloc]initWithType:@"Area"];
         mapController.airQuality = self.airQualityModule;
         [self transitionToViewController:mapController withType:@"rippleEffect"];
     }];
}

-(void) openPhoto
{
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService7URL,self.airQualityModule.airQualityID] completionHandler:^(id obj)
     {
         if(obj)
         {
             NSDictionary *dict = (NSDictionary*)obj;
             
             [dict writeToFile:[self outPath:@"Photo"] atomically:YES];
             
             
             PhotoController *photoController = [[PhotoController alloc]initWithType:@"Area"];
             
             [self performSelector:@selector(delaytransitionViewController:) withObject:photoController afterDelay:0.7];

         }
     }];
}

-(void) openfloorPlan
{
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService8URL,self.airQualityModule.airQualityID] completionHandler:^(id obj)
     {
         if(obj)
         {
             NSDictionary *dict = (NSDictionary*)obj;
             
             [dict writeToFile:[self outPath:@"floorPlan"] atomically:YES];
             
            
             FloorPlanController *floorPlanController = [[FloorPlanController alloc]initWithType:@"Area"];
             
             [self performSelector:@selector(delaytransitionViewController:) withObject:floorPlanController afterDelay:0.7];
         }
     }];
}

#pragma mark - Translater Animation

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"rippleEffect"];
}


-(void) delaytransitionViewController:(UIViewController*)controller
{
    [self transitionToViewController:controller withType:@"rippleEffect"];
}

#pragma mark - UITextView Delegate

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
