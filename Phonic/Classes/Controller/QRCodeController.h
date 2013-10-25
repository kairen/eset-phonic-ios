//
//  QRCodeController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/10/26.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol QRCodeDelegate;

@interface QRCodeController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>


@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property(nonatomic, weak) id <QRCodeDelegate> delegate;
@end

@protocol QRCodeDelegate

@required
-(void) scannerCompleteGetValue:(NSString*)codeValue;

@end