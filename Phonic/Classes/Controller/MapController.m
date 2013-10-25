//
//  MapController.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/4/7.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MapController.h"
#import "MapView.h"
#import "MyLocation.h"


#define METERS_PER_MILE 1609.344

@interface MapController ()

@end

@implementation MapController

-(id)initWithType:(NSString *)type
{
    self = [super init];
    if(self)
    {
        controlType = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapView = [[MapView alloc]initWithFrame:self.view.frame];
    self.view = self.mapView;
    
     [self.mapView.backbtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    if([controlType isEqualToString:@"Area"])
    {
        [self.mapView setBackbtnWithNolImage:@"回空品區介紹02.fw.png" andHigImage:@"回空品區介紹01.fw.png"];
    }
    else
    {
           [self.mapView setBackbtnWithNolImage:@"回喬木介紹02.fw.png" andHigImage:@"回喬木介紹01.fw.png"];
    }
    [self loadingMapData];
}


#pragma mark - loading ... data

-(void) loadingMapData
{
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[self outPath:@"Map"]];
    
    for(NSString *data in dict)
    {
        for(NSDictionary *dictData in [dict valueForKey:data])
        {
            CLLocationCoordinate2D zoomLocation;
            zoomLocation.latitude = [[dictData objectForKey:@"N"] doubleValue];
            zoomLocation.longitude= [[dictData objectForKey:@"E"] doubleValue];
        
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
            [self.mapView.mkMapView setRegion:viewRegion animated:YES];
            
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [[dictData objectForKey:@"N"] doubleValue];;
            coordinate.longitude = [[dictData objectForKey:@"E"] doubleValue];;
            MyLocation *annotation = [[MyLocation alloc] initWithName:self.airQuality.airQualityName address:self.airQuality.airQualityText10 coordinate:coordinate] ;
            [self.mapView.mkMapView addAnnotation:annotation];
            
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Translater Animation

-(void) dismissViewController
{
    [self disTransitionControllerWithType:@"rippleEffect"];
}

@end
