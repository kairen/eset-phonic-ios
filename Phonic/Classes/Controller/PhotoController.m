//
//  PhotoController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "PhotoController.h"
#import "PhotoView.h"

@interface PhotoController ()

@end

@implementation PhotoController

-(id)initWithType:(NSString *)type
{
    self = [super init];
    if(self)
    {
        controlType = type;
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.photoTreeView.showImage = nil;
    self.photoView.showImage = nil;
    self.photoView.imageBtn1 = nil;
    self.photoView.imageBtn1 = nil;
    self.photoView.imageBtn1 = nil;
    self.photoTreeView.imageBtn1 = nil;
    self.photoTreeView.imageBtn1 = nil;
    self.photoTreeView.imageBtn1 = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    if([controlType isEqualToString:@"Area"])
    {
        self.photoView = [[PhotoView alloc]initWithFrame:self.view.frame];
        self.view = self.photoView;
        [self.photoView setBackbtnWithNolImage:@"回空品區介紹02.fw.png" andHigImage:@"回空品區介紹01.fw.png"];

        [self.photoView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView.imageBtn1 addTarget:self action:@selector(buttonAction2:)];
        [self.photoView.imageBtn2 addTarget:self action:@selector(buttonAction2:)];
        [self.photoView.imageBtn3 addTarget:self action:@selector(buttonAction2:)];
    }
    else
    {
        self.photoTreeView = [[PhotoTreeView alloc]initWithFrame:self.view.frame];
        self.view = self.photoTreeView;
        [self.photoTreeView setBackbtnWithNolImage:@"回喬木介紹02.fw.png" andHigImage:@"回喬木介紹01.fw.png"];

        [self.photoTreeView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.photoTreeView.imageBtn1 addTarget:self action:@selector(buttonAction:)];
        [self.photoTreeView.imageBtn2 addTarget:self action:@selector(buttonAction:)];
        [self.photoTreeView.imageBtn3 addTarget:self action:@selector(buttonAction:)];
        
        if([controlType isEqualToString:@"Arbor"])
        {
            self.photoTreeView.titleLabel.text = @"喬木照片";
        }
    }
    [self performSelector:@selector(loadingPhotoData) withObject:nil afterDelay:0.5];
}


#pragma mark - loading Data

-(void) loadingPhotoData
{
    if([controlType isEqualToString:@"Area"])
    {
        NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self outPath:@"Photo"]];
        
        titleData = [[NSMutableArray alloc]init];
        
        int i = 0;
        
        for(NSString *data in dict)
        {
            for(NSDictionary *dictData in [dict valueForKey:data])
            {
                [titleData addObject:[dictData valueForKey:@"Data1"]];
                    
                    if(i == 0)
                    {
                        self.photoView.showImage.imageUrl = [dictData valueForKey:@"URL"];
                        self.photoView.imageBtn1.imageUrl = [dictData valueForKey:@"URL"];
                        self.photoView.titleLabel.text = [NSString stringWithFormat:@"照片說明:%@",[titleData objectAtIndex:0]];
                    }
                    else if(i == 1)
                    {
                        self.photoView.imageBtn2.imageUrl = [dictData valueForKey:@"URL"];
                    }
                    else if(i == 2)
                    {
                        self.photoView.imageBtn3.imageUrl = [dictData valueForKey:@"URL"];
                    }
                    i++;
                }
            }
            
        self.photoView.showImage.alpha = self.photoView.imageBtn1.alpha =  self.photoView.imageBtn2.alpha =  self.photoView.imageBtn3.alpha = 0.0;
            
        [UIView animateWithDuration:1 animations:^
        {
            self.photoView.showImage.alpha = self.photoView.imageBtn1.alpha =  self.photoView.imageBtn2.alpha =  self.photoView.imageBtn3.alpha = 1.0;
        }];
    }
    else
    {
        NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self outPath:@"TreePhoto"]];
        
        titleData = [[NSMutableArray alloc]init];
        
        int i = 0;
        
        for(NSString *data in dict)
        {
            for(NSDictionary *dictData in [dict valueForKey:data])
            {
                if([controlType isEqualToString:@"Tree"])
                [titleData addObject:[NSString stringWithFormat:@"%@,%@",[dictData objectForKey:@"Data1"],[dictData objectForKey:@"Data2"]]];
                else
                [titleData addObject:[dictData objectForKey:@"Data1"]];
                
                       
                        if(![controlType isEqualToString:@"Arbor"])
                        {
                            if(i == 0)
                            {
                                self.photoTreeView.showImage.imageUrl = [dictData valueForKey:@"URL"];
                                self.photoTreeView.imageBtn1.imageUrl = [dictData valueForKey:@"URL"];
                                self.photoTreeView.expLabel.text = [NSString stringWithFormat:@"照片說明:%@",[titleData objectAtIndex:0]];
                                NSLog(@"%@,%@",[dictData valueForKey:@"URL"],[titleData objectAtIndex:i]);
                            }
                            else if(i == 1)
                            {
                                self.photoTreeView.imageBtn2.imageUrl = [dictData valueForKey:@"URL"];
                            }
                            else if(i == 2)
                            {
                                self.photoTreeView.imageBtn3.imageUrl = [dictData valueForKey:@"URL"];
                            }
                            i++;
                        }
                        else
                        {
                            self.photoTreeView.showImage.imageUrl = [dictData valueForKey:@"URL"];
                            self.photoTreeView.expLabel.text = [NSString stringWithFormat:@"照片說明:%@",[titleData objectAtIndex:0]];
                }
            }
        }
                
        self.photoTreeView.showImage.alpha = self.photoTreeView.imageBtn1.alpha =  self.photoTreeView.imageBtn2.alpha =  self.photoTreeView.imageBtn3.alpha = 0.0;
        [UIView animateWithDuration:1 animations:^
         {
             self.photoTreeView.showImage.alpha = self.photoTreeView.imageBtn1.alpha =  self.photoTreeView.imageBtn2.alpha =  self.photoTreeView.imageBtn3.alpha = 1.0;
         }];
    }
}

#pragma mark - Button Action

-(void) buttonAction2:(id)btn
{
    KRAsyncImageView *krImage = (KRAsyncImageView*)btn;
    
    if([controlType isEqualToString:@"Area"])
    {
            self.photoView.showImage.alpha = 0.0;
            self.photoView.titleLabel.alpha = 0.0;
            
            [UIView animateWithDuration:1 animations:^{
                self.photoView.showImage.alpha = 1.0;
                self.photoView.titleLabel.alpha = 1.0;
                
                self.photoView.showImage.image = krImage.image;
                self.photoView.titleLabel.text = [NSString stringWithFormat:@"照片說明:%@",[titleData objectAtIndex:krImage.tag ]];
            }];
    }
    NSLog(@"%d",krImage.tag);
}

-(void) buttonAction:(id)btn
{
    KRAsyncImageView *krImage = (KRAsyncImageView*)btn;
    
    if([controlType isEqualToString:@"Area"])
    {
        self.photoTreeView.showImage.alpha = 0.0;
        self.photoTreeView.titleLabel.alpha = 0.0;
        
        [UIView animateWithDuration:1 animations:^{
            self.photoTreeView.showImage.alpha = 1.0;
            self.photoTreeView.titleLabel.alpha = 1.0;
            
            self.photoTreeView.showImage.image = krImage.image;
            self.photoTreeView.titleLabel.text = [NSString stringWithFormat:@"照片說明:%@",[titleData objectAtIndex:krImage.tag ]];
        }];
    }
    else
    {
        self.photoTreeView.showImage.alpha = 0.0;
        self.photoTreeView.titleLabel.alpha = 0.0;
        
        [UIView animateWithDuration:1 animations:^{
            self.photoTreeView.showImage.alpha = 1.0;
            self.photoTreeView.titleLabel.alpha = 1.0;
            
            self.photoTreeView.showImage.image = krImage.image;
            self.photoTreeView.titleLabel.text = [NSString stringWithFormat:@"照片說明:%@",[titleData objectAtIndex:krImage.tag ]];
        }];
    }
    NSLog(@"%d",krImage.tag);
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
