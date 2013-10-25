//
//  QRCodeController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/10/26.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "QRCodeController.h"

@interface QRCodeController ()

@end

@implementation QRCodeController


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupCamera];
}

- (void)setupCamera
{
    self.session = [[AVCaptureSession alloc] init];
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device
                                                                        error:&error];
    if (self.input) {
        [self.session addInput:self.input];
    }
    else {
        NSLog(@"Error: %@", error);
    }
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:self.output];
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // Preview
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    NSString *QRCode = nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            QRCode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            [self deallocAllSession];
            [self.delegate scannerCompleteGetValue:QRCode];
            [self performSelector:@selector(delayDismodal) withObject:nil afterDelay:0.5];
            break;
        }
    }
}

-(void) delayDismodal
{
     [self dismissViewControllerAnimated:YES completion:NO];
}

-(void) deallocAllSession
{
    [self.session stopRunning];
    self.preview = nil;
    self.output = nil;
    self.input = nil;
    self.session = nil;
    self.device = nil;
}

@end
