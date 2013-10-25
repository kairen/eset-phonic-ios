//
//  ViewController.h
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/3/20.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HttpPostController.h"
#import "QRCodeController.h"
@class MainView;


@interface MainController : HttpPostController<QRCodeDelegate>

@end
