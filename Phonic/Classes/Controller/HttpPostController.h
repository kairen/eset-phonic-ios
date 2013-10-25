//
//  HttpPostController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/3.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KRActivityAlertView.h"
#import "DefineURL.h"
#import "UIDeviceModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"

@interface HttpPostController : UIViewController<ASIHTTPRequestDelegate>
{
    NSArray *postStrings;
@private
    KRActivityAlertView *krActivityView;
   
}


@property(nonatomic, strong)  AVAudioPlayer *myPlayer;

-(void) transitionToViewController:(UIViewController *)viewController withType:(NSString *) type;
- (void) disTransitionControllerWithType:(NSString *) type;

- (void) loadHttpRequestCompletionHandler:(NSString*)requestURL completionHandler:(void(^)(id obj))completionHandler;
- (void) loadHttpRequestCompletionHandlerNotWithAlert:(NSString*)requestURL completionHandler:(void(^)(id obj))completionHandler;

-(void) playAudioWithFile:(NSString*)file AlertSound:(BOOL)isAlert;

-(BOOL) checkExistPlistFile:(NSString*)file;
-(NSString*) outPath:(NSString*)input;
-(NSString*) airDefinePath;
-(NSString*) taichungAreaPath;
@end


