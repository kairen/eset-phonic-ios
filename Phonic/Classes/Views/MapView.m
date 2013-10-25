//
//  MapView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.mkMapView = [[MKMapView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.03125, self.frame.size.height * 0.2080292, 300, self.frame.size.height * 0.59124088)];
        
        self.mkMapView.layer.cornerRadius = 10.0;
        
        [self addSubview:self.mkMapView];
        
        
        self.backbtn.frame = CGRectMake(self.frame.size.width * 0.1875, self.frame.size.height * 0.83759124, 200, 50);
        
    }
    return self;
}



@end
