//
//  FloorPlanController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "FloorPlanController.h"
#import "FloorPlanView.h"


@interface FloorPlanController ()

@end

@implementation FloorPlanController

-(id)initWithType:(NSString *)type
{
    self = [super init];
    if(self)
    {
        controlType = type;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.floorPlanView = [[FloorPlanView alloc]initWithFrame:self.view.frame];
    self.view = self.floorPlanView;
    
     [self.floorPlanView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    if([controlType isEqualToString:@"Area"])
    {
        [self.floorPlanView setBackbtnWithNolImage:@"回空品區介紹02.fw.png" andHigImage:@"回空品區介紹01.fw.png"];
    }
    else
    {
        [self.floorPlanView setBackbtnWithNolImage:@"回喬木介紹02.fw.png" andHigImage:@"回喬木介紹01.fw.png"];
    }
    
    self.floorPlanView.zoomView.delegate = self;
    self.floorPlanView.zoomView.maximumZoomScale = 3.0;
    self.floorPlanView.zoomView.minimumZoomScale = 1.0;
    [self performSelector:@selector(loadingFloorPlanData) withObject:nil afterDelay:0.5];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.floorPlanView.planView = nil;
}


#pragma mark - loading Data

-(void) loadingFloorPlanData
{
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self outPath:@"floorPlan"]];
    
    self.floorPlanView.planView.alpha = 0.0;
    self.floorPlanView.planView.imageUrl = nil;
        for(NSString *data in dict)
        {
            for(NSDictionary *dictData in [dict valueForKey:data])
            {
                
                [self.floorPlanView.planView setImageUrl:[dictData valueForKey:@"URL"]];
                [UIView animateWithDuration:1 animations:^{
                    
                     self.floorPlanView.planView.alpha = 1.0;
                     }];
                NSLog(@"%@",[dictData valueForKey:@"URL"]);
            }
        }
   
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.floorPlanView.planView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Translater Animation

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"rippleEffect"];
}

@end
