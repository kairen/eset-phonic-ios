//
//  Macaddress.m
//  hoho
//
//  Created by 凱仁 白 on 12/3/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIDeviceModel.h"
#import  <dlfcn.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <ifaddrs.h>


@implementation UIDevice (IdentifierAddition)


#pragma mark Public Methods


#pragma mark - Get Phone Mac Address (取得手機Mac地址)

- (NSString *) getMacAddress
{
    CFArrayRef interfaces = CNCopySupportedInterfaces();
    CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(interfaces, 0));
    if(dicRef)
    {
        return CFDictionaryGetValue(dicRef, kCNNetworkInfoKeyBSSID);
    }
    else
    {
        return @"";

    }
}

#pragma mark - Get Phone Wifi IP Address (取得 IP Address)

-(NSString*) getWifi_IP_Address
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0
    ;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
        if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    return nil;
}

#pragma mark - Get Wifi SSID

- (NSString *) getWifi_SSID
{
    CFArrayRef interfaces = CNCopySupportedInterfaces();
    CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(interfaces, 0));
    
    if (dicRef)
    {
       return CFDictionaryGetValue(dicRef, kCNNetworkInfoKeySSID);
    }
    else
    {
       return nil;
    }
}

#pragma mark - Check NetWork is Work (檢查網路是否有在運作)

+(BOOL) checkNetWorkIsWork
{
    SCNetworkReachabilityRef reach = SCNetworkReachabilityCreateWithName(kCFAllocatorSystemDefault, "google.com");
	SCNetworkConnectionFlags flags;
	SCNetworkReachabilityGetFlags(reach, &flags);
	
	if((kSCNetworkReachabilityFlagsReachable & flags) && !(kSCNetworkReachabilityFlagsIsWWAN & flags))
    {
		//NSLog(@" 沒有使用電信上網,但正在使用WIFI");
        return YES;
	}
    else if (kSCNetworkReachabilityFlagsIsWWAN & flags)
    {
		//NSLog(@" 正在使用電信上網");
        return YES;
	}
    else
    {
		//NSLog(@"網路沒有在運作");
        return NO;
	}
	CFRelease(reach);
}

@end
