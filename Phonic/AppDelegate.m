//
//  AppDelegate.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/3/20.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AppDelegate.h"

#import "MainController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.mainController = [[MainController alloc] init];
    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
    
    UIImageView *loadView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if([[UIScreen mainScreen] bounds].size.height == 568.0f && [UIScreen mainScreen].scale == 2.f)
    {
        
        loadView.image = [UIImage imageNamed:@"Default-568h@2x.png"];
    }
    else
    {
        loadView.image = [UIImage imageNamed:@"Default.png"];
    }
    [self.mainController.view addSubview:loadView];
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    [self performSelector:@selector(loadingFinish:) withObject:loadView afterDelay:1];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) loadingFinish:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 0.0;
    }completion:^(BOOL finished) {
        [view removeFromSuperview];
        UIView *aView = (UIView*)sender;
        aView = nil;
        [[UIApplication sharedApplication]setStatusBarHidden:NO];
    }];
    
}

@end
