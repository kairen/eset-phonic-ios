//
//  DeviceId..m
//  hoho
//
//  Created by 凱仁 白 on 12/3/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIDevice (IdentifierAddition)

- (NSString *) getMacAddress;
- (NSString *) getWifi_IP_Address;
- (NSString *) getWifi_SSID;

+(BOOL) checkNetWorkIsWork ;

@end
