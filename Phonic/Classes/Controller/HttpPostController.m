//
//  HttpPostController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/3.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"
#import <objc/runtime.h>


#define HTTP_TIMEOUT 10

typedef void(^CustomLoadHttpRequestHandler)(void(^)(id obj));
typedef void(^CustomPostHttpRequestHandler)(void(^)(id obj));
static const char * CustomLoadHttpRequestKey = "CustomLoadHttpRequestKey";
static const char * CustomPostHttpRequestKey = "CustomPostHttpRequestKey";


@interface HttpPostController ()

@property (nonatomic) BOOL loading;
@property (nonatomic) BOOL postHttpRequest;
@end

@implementation HttpPostController


- (id) init
{
    self = [super init];
    if (self)
    {
        [ASIHTTPRequest setDefaultTimeOutSeconds:HTTP_TIMEOUT];
        self.loading = NO;
        self.postHttpRequest = NO;
    }
    return self;
}


#pragma mark - set objc method

- (void)callHttpRequestHandler:(id)obj
{
    self.loading = NO;
    self.postHttpRequest = NO;
    
    CustomLoadHttpRequestHandler handler = (CustomLoadHttpRequestHandler)objc_getAssociatedObject(self,(const void*)CustomLoadHttpRequestKey);
    objc_setAssociatedObject(self, CustomLoadHttpRequestKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (handler)
    {
        handler(obj);
    }
}

- (void)callPostHttpRequestHandler:(NSString*)str code:(int)code
{
    self.loading = NO;
    self.postHttpRequest = NO;
    
    CustomPostHttpRequestHandler handler = (CustomPostHttpRequestHandler)objc_getAssociatedObject(self,(const void*)CustomPostHttpRequestKey);
    objc_setAssociatedObject(self, CustomPostHttpRequestKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (handler)
    {
        if (!str)
            handler(nil);
        else
            handler([NSError errorWithDomain:str code:code userInfo:nil]);
    }
}

#pragma mark - display Erroe Message

- (void) displayErrorAlert:(int)code
{
    if (code == 201 ||
        (code >= 400 && code < 500))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"連線錯誤"
                                                       message:@"暫時無法連線，請稍待再試。"
                                                      delegate:nil
                                             cancelButtonTitle:@"確認"
                                             otherButtonTitles:nil];
        [alert show];
    }
    else if (code >=500 && code < 600)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"伺服器錯誤"
                                                       message:@"暫時無法連線，請稍待再試。"
                                                      delegate:nil
                                             cancelButtonTitle:@"確認"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

-(NSString *)JSONString:(NSString *)aString
{
	return [aString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c%c",0x5c,0x6e] withString:@"~~#"];
}

#pragma mark - ASIHttpDelegate Method

-(void) requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%d",request.responseStatusCode);
    
    NSString *responStr = [self JSONString:request.responseString];
    
    NSLog(@"%@",responStr);
    if (request.responseStatusCode >= 400 && request.responseStatusCode < 600)
    {
        [self displayErrorAlert:request.responseStatusCode];
    }
    
    if(request.responseStatusCode == 200)
    {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSDictionary *dict = [parser objectWithString:responStr];
       
        
        [self callHttpRequestHandler:dict];
    }
    else
    {
        [self callHttpRequestHandler: nil];
    }

    [krActivityView finishStopActivity];
    krActivityView = nil;
    
}

-(void) requestFailed:(ASIHTTPRequest *)request
{
    [krActivityView finishStopActivity];
    krActivityView = nil;
//    NSLog(@"Failed Message: %@",request.responseString);
    [self displayErrorAlert:201];
    
    if (self.postHttpRequest)
    {
        [self callPostHttpRequestHandler:@"timeout" code:201];
    }
    else
    {
       
            [self callHttpRequestHandler:nil];
    }
}

#pragma mark - ASIHttp Method

- (void) loadHttpRequestCompletionHandler:(NSString*)requestURL completionHandler:(void(^)(id obj))completionHandler

{
    if (self.loading)
        return;
    
    self.loading = YES;
    self.postHttpRequest = YES;
    
//    NSLog(@"%@\n",requestURL);
    
    NSURL *url = [NSURL URLWithString:requestURL];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    if(krActivityView == nil)
    {
        krActivityView = [[KRActivityAlertView alloc]initWithTitle:@"訊息" message:@"處理中..." delegate:nil
                          ];
        [krActivityView show];
    }
  
    objc_setAssociatedObject(self, CustomLoadHttpRequestKey, completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) loadHttpRequestCompletionHandlerNotWithAlert:(NSString*)requestURL completionHandler:(void(^)(id obj))completionHandler

{
    if (self.loading)
        return;
    
    self.loading = YES;
    self.postHttpRequest = YES;
    
//    NSLog(@"%@\n",requestURL);
    
    NSURL *url = [NSURL URLWithString:requestURL];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

    
    objc_setAssociatedObject(self, CustomLoadHttpRequestKey, completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - Check plist file

-(BOOL) checkExistPlistFile:(NSString*)file
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if([manager fileExistsAtPath:file])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



#pragma mark - plist Path String

-(NSString*) outPath:(NSString*)input
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documetns = [paths objectAtIndex:0];
    NSString* fullpath = [NSString stringWithFormat:@"%@.plist",[documetns stringByAppendingPathComponent:input]];
    return fullpath;
}

-(NSString*) airDefinePath
{

    return [self outPath:@"airDefine"];
}

-(NSString*) taichungAreaPath
{
  return [self outPath:@"taichungArea"];
}

#pragma mark - Transition Ainmation
 
-(void) transitionToViewController:(UIViewController *)viewController withType:(NSString *) type
{
    [CATransaction begin];
    
    CATransition *transition = [CATransition animation];
    transition.type = type;
    transition.duration = 0.8;
    transition.fillMode = kCAFillModeForwards;
    transition.removedOnCompletion = YES;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    
    [self presentViewController:viewController animated:NO completion:nil];
    
    [CATransaction commit];

    
}

- (void) disTransitionControllerWithType:(NSString *) type
{
    [CATransaction begin];
    
    CATransition *transition = [CATransition animation];
    transition.type = type;
    transition.duration = 0.8;
    transition.fillMode = kCAFillModeForwards;
    transition.removedOnCompletion = YES;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [CATransaction commit];
    
}

#pragma mark - Button Audio Event

-(void) playAudioWithFile:(NSString*)file AlertSound:(BOOL)isAlert
{
    NSError *error;
    NSURL *url = [NSURL URLWithString:file];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if(self.myPlayer == nil)
    {
         self.myPlayer = [[AVAudioPlayer alloc]initWithData:data error:&error];
        if (error)  {
            NSLog(@"Error creating audio player: %@", [error userInfo]);
        } else {
            [self.myPlayer setNumberOfLoops:0];
            [self.myPlayer play];
        }
    }
    else
    {
        if(self.myPlayer.isPlaying)
        {
            [self.myPlayer stop];
            self.myPlayer = nil;
        }
    }

}

static void systemSoundCompletion(SystemSoundID sound_id, void* user_data)
{
    AudioServicesRemoveSystemSoundCompletion(sound_id);
}


@end



