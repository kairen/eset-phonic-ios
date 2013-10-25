//
//  KRActivityAlertView.h
//  TraCare
//
//  Created by Bai-Kai-Ren on 13/1/17.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRActivityAlertView : UIAlertView <UIAlertViewDelegate>
{
  @private
    UIActivityIndicatorView *_activity;
}


-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate;
-(void) finishStopActivity;

@end
