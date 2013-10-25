//
//  KRActivityAlertView.m
//  TraCare
//
//  Created by Bai-Kai-Ren on 13/1/17.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRActivityAlertView.h"

@implementation KRActivityAlertView

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    if(self)
    {
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.frame = CGRectMake(115, 70, 50, 50);
        [self addSubview:_activity];
        [_activity startAnimating];
    }
    return self;
}

-(void) finishStopActivity
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [_activity stopAnimating];
    _activity = nil;
}

@end
