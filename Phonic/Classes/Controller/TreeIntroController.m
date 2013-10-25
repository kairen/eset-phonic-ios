//
//  TreeIntroController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TreeIntroController.h"
#import "TreeIntroView.h"
#import "PhotoController.h"
#import "TreeIntroModule.h"
#import "ArborIntroModule.h"

@interface TreeIntroController ()

@end

@implementation TreeIntroController

-(id)initWithDict:(NSDictionary *)dict andType:(NSString *)type areaID:(NSString *)areaid
{
    self = [super init];
    if(self)
    {
        areaID = areaid;
        controlType = type;
        
        if([controlType isEqualToString:@"Tree"])
        {
            self.treeIntroModule = [TreeIntroModule treeIntroWithDictt:dict];
        }
        else
        {
            self.arborIntroModule = [ArborIntroModule arborIntroWithDictt:dict];
        }
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.treeIntroView = [[TreeIntroView alloc]initWithFrame:self.view.frame];
    self.view = self.treeIntroView;
    
    self.treeIntroView.listView.delegate = self;
    
    [self.treeIntroView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.treeIntroView.photoBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self loadingData];
}


#pragma mark - laoding Data

-(void) loadingData
{
    if([controlType isEqualToString:@"Arbor"])
    {
        self.treeIntroView.listView.text = [NSString stringWithFormat:self.arborIntroModule.treeTitles,
                                            self.arborIntroModule.treeID,
                                            self.arborIntroModule.treeName,
                                            self.arborIntroModule.treeText1,
                                            self.arborIntroModule.treeText2,
                                            self.arborIntroModule.treeText3,
                                            self.arborIntroModule.treeText4];

        
    }
    else
    {
        self.treeIntroView.listView.text = [NSString stringWithFormat:self.treeIntroModule.treeTitles,
                                            self.treeIntroModule.treeID,
                                            self.treeIntroModule.treeName,
                                            self.treeIntroModule.treeText1,
                                            self.treeIntroModule.treeText2,
                                            self.treeIntroModule.treeText3];
    }
    
}


#pragma mark - open Photo

-(void) openPhoto
{
    if(![controlType isEqualToString:@"Arbor"])
    {
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService15URL,self.treeIntroModule.treeID]  completionHandler:^(id obj)
         {
             if(obj)
             {
                 NSDictionary *dict = (NSDictionary *)obj;
                 [dict writeToFile:[self outPath:@"TreePhoto"] atomically:YES];
             }
             PhotoController *photoController = [[PhotoController alloc]initWithType:@"Tree"];
             [self transitionToViewController:photoController withType:@"rippleEffect"];
             
             
         }];
    }
    else
    {
        [self loadHttpRequestCompletionHandler:[NSString stringWithFormat:kPostWebService13URL,self.arborIntroModule.treeID,areaID]  completionHandler:^(id obj)
         {
             if(obj)
             {
                 NSDictionary *dict = (NSDictionary *)obj;
                 [dict writeToFile:[self outPath:@"TreePhoto"] atomically:YES];
             }
             PhotoController *photoController = [[PhotoController alloc]initWithType:@"Arbor"];
             [self transitionToViewController:photoController withType:@"rippleEffect"];
             
             
         }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"rippleEffect"];
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
@end
