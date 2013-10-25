//
//  KRAsyncImageView.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/5/20.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define defaultImageIdKey		@"imageId"

typedef enum {
	KRAsyncImageSizeThumbnail	= 1,
	KRAsyncImageSizeRegular		= 2,
	KRAsyncImageSizeLarge		= 3
} enumKRAsyncImageSize;


@interface KRAsyncImageView : UIImageView <NSURLConnectionDelegate>
{
    NSThread *thread;
}

@property (nonatomic, strong) id target;
@property(nonatomic ) SEL action;

@property (nonatomic, strong) NSString	*imageId;
@property (nonatomic, strong) NSString	*imageUrl;
@property (nonatomic, strong) NSString	*imageIdKey;

@property (nonatomic)  BOOL needSave;

@property (nonatomic, assign) int		imageSize;

-(void) addTarget:target action:(SEL)action;

@end
