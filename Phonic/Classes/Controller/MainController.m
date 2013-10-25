//
//  ViewController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/3/20.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MainController.h"
#import "MainView.h"
#import "IntroController.h"
#import "ARborIntroListController.h"
#import "TreeIntroController.h"
#import "AirQualityController.h"
#import "TreeIntroListController.h"

@interface MainController ()
{
    NSString *scanString;
}
@property(nonatomic,strong) MainView *mainView;
@end

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainView = [[MainView alloc]initWithFrame:self.view.frame];
    self.view = self.mainView;
    
    [self.mainView.qrCodeBtn addTarget:self action:@selector(qrCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView.mbiBtn addTarget:self action:@selector(openBroswer:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView.mtiBtn addTarget:self action:@selector(openBroswer:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.treeBtn addTarget:self action:@selector(openBroswer:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Go Broswer

-(void) openBroswer:(id)sender
{
    if(sender == self.mainView.mbiBtn)
    {
        IntroController *introController = [[IntroController alloc]init];
        
        if(![self checkExistPlistFile:[self airDefinePath]])
        
        {
            [self loadHttpRequestCompletionHandler:kPostWebService1URL completionHandler:^(id objc)
             {
                 if(objc)
                 {
                     NSDictionary *dict = (NSDictionary*)objc;
                     
                     [dict writeToFile:[self airDefinePath] atomically:YES];
                     [self performSelector:@selector(delayTranslater:) withObject:introController afterDelay:1.0];
                 }
                 
             }];
        }
        else
        {
            [self transitionToViewController:introController withType:@"suckEffect"];
        }
      
    }
    else if(sender == self.mainView.mtiBtn)
    {
        ARborIntroListController *treeIntroController = [[ARborIntroListController alloc]init];
        
        if(![self checkExistPlistFile:[self taichungAreaPath]])
        {
            [self loadHttpRequestCompletionHandler:kPostWebService2URL completionHandler:^(id obj){
                if(obj)
                {
                    NSDictionary *dict = (NSDictionary*)obj;
                    [dict writeToFile:[self taichungAreaPath] atomically:YES];
                }
                [self performSelector:@selector(delayTranslater:) withObject:treeIntroController afterDelay:1.0];
            }];
        }
        else
        {
            [self transitionToViewController:treeIntroController withType:@"suckEffect"];
        }
    }
    else
    {
        TreeIntroListController *treeIntroController = [[TreeIntroListController alloc]init];
        
        [self loadHttpRequestCompletionHandler:kPostWebService18URL  completionHandler:^(id obj)
         {
             if(obj)
             {
                 NSDictionary *dict = (NSDictionary *)obj;
                 
                 [dict writeToFile:[self outPath:@"AllTreeData"] atomically:YES];
                 [self performSelector:@selector(delayTranslater:) withObject:treeIntroController afterDelay:1.0];
             }
         }];
    }
}


#pragma mark - QRCode Use

-(void) qrCodeButtonAction
{
    QRCodeController *qrCodeController = [[QRCodeController alloc]init];
    qrCodeController.delegate = self;
    [self transitionToViewController:qrCodeController withType:@" "];
}

#pragma mark - QR Code Delegate(Data receive)

-(void) scannerCompleteGetValue:(NSString *)codeValue
{
    scanString = codeValue;
    [self checkQRCodeData];
}

#pragma mark - Check QRCode Classes

-(void) checkQRCodeData
{
    NSArray *array = [scanString componentsSeparatedByString:@"--"];
    if(array.count > 1)
    {
        switch ([[array objectAtIndex:0] intValue]) {
            case 1:
            {
                [self openAirQuality:[array objectAtIndex:1]];
                break;
            }
            case 2:
            {
                [self openTree:[array objectAtIndex:1]];
                break;
            }
            case 3:
            {
                [self openArbor:array];
                break;
            }
        }
    }
}


#pragma mark - Open AirQualityController

-(void) openAirQuality:(NSString*)airID;
{
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService4URL,[airID intValue]] completionHandler:^(id obj){
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

#pragma mark - Open TreeController

-(void) openTree:(NSString*)treeID;
{
    [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService14URL,treeID]  completionHandler:^(id obj)
     {
         if(obj)
         {
             NSDictionary *dict = (NSDictionary *)obj;
             
             for(NSString *data in dict)
             {
                 for(NSDictionary *dictData in [dict valueForKey:data])
                 {
                     TreeIntroController *treeController = [[TreeIntroController alloc]initWithDict:dictData andType:@"Tree" areaID:nil];
                     [self transitionToViewController:treeController withType:@"rippleEffect"];
                 }
             }
         }
         
     }];
}

#pragma mark - ArborController

-(void) openArbor:(NSArray*)Aarray
{
    if(Aarray.count > 2)
    {
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService12URL,[Aarray objectAtIndex:1] ,[Aarray objectAtIndex:2]] completionHandler:^(id obj){
            if(obj)
            {
                NSDictionary *dict = (NSDictionary *)obj;
                
                for(NSString *data in dict)
                {
                    for(NSDictionary *dictData in [dict valueForKey:data])
                    {
                        TreeIntroController *treeIntroController = [[TreeIntroController alloc]initWithDict:dictData andType:@"Arbor" areaID:[Aarray objectAtIndex:2]];
                        [self transitionToViewController:treeIntroController withType:@"rippleEffect"];
                        
                    }
                }
                
            }
            
        }];
    }
}

#pragma mark - Translater

-(void) delayTranslater:(UIViewController *)ViewController
{
    [self transitionToViewController:ViewController withType:@"suckEffect"];
}


@end
