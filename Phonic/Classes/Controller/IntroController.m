//
//  IntroController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/5.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "IntroController.h"
#import "IntroView.h"
#import "IntroModule.h"
#import "TaiChungMapController.h"

@interface IntroController ()

@end

@implementation IntroController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.introView = [[IntroView alloc]initWithFrame:self.view.frame];
    self.view = self.introView;
    [self.introView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.introView.defineText.delegate = self;
    [self loadingTextMethod];
    
    [self.introView.airIntroBtn addTarget:self action:@selector(gototaichungMapController) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Loading... Text

-(void) loadingTextMethod
{

    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self airDefinePath]];
    
    for(NSString *data in dict)
    {
        for(NSDictionary *dictData in [dict valueForKey:data])
        {
            self.introModule = [IntroModule introWithDict:dictData];
        }
    }
    
    
    [UIView animateWithDuration:1 animations:^{
        self.introView.defineText.text = self.introModule.defineText;
    }];
}

#pragma mark - goto TaiChungMap Controller

-(void) gototaichungMapController
{
    TaiChungMapController *taiController = [[TaiChungMapController alloc]init];

    if(![self checkExistPlistFile:[self taichungAreaPath]])
    {
        [self loadHttpRequestCompletionHandler:kPostWebService2URL completionHandler:^(id obj){
            if(obj)
            {
                NSDictionary *dict = (NSDictionary*)obj;
                [dict writeToFile:[self taichungAreaPath] atomically:YES];
            }
            [self performSelector:@selector(delayTranslater:) withObject:taiController afterDelay:0.7];
        }];
    }
    else
    {
           [self transitionToViewController:taiController withType:@"suckEffect"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

-(void) delayTranslater:(UIViewController *)ViewController
{
    [self transitionToViewController:ViewController withType:@"suckEffect"];
}


#pragma mark - Translater Animation

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"suckEffect"];
}

@end
