//
//  EPPickerView.m
//  DataCell
//
//  Created by Yang Nung Jan on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EPPickerView.h"

@implementation EPPickerView
@synthesize pickerView, barButtonItem;
@synthesize target = _target;
@synthesize action = _action;
@synthesize dataSource = _dataSource;

- (void) runAnimation
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGSize pickerSize = [self sizeThatFits:CGSizeZero];
    CGRect startRect = CGRectMake(0.0,
                                  screenRect.origin.y + screenRect.size.height,
                                  pickerSize.width, pickerSize.height);
    self.frame = startRect;
    
    CGRect pickerRect = CGRectMake(0.0,
                                   screenRect.origin.y + screenRect.size.height - pickerSize.height,
                                   pickerSize.width,
                                   pickerSize.height);
    
    // start the slide up animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    // we need to perform some post operations after the animation is complete
    [UIView setAnimationDelegate:self];
    
    self.frame = pickerRect;
    
    [UIView commitAnimations];
}

- (id) init:(id)target action:(SEL)action
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 260)];
    if (self)
    {
        UIToolbar *toobar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        self.barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerDoneAction:)];
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, 320, 216)];
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.delegate = self;
        [toobar setItems:[NSArray arrayWithObject:self.barButtonItem]];
        toobar.barStyle = UIBarStyleBlack;
        [self addSubview:toobar];
        [self addSubview:self.pickerView];
        
        self.target = target;
        self.action = action;
        
        if([[UIDevice currentDevice].systemVersion hasPrefix:@"7"]) {
            self.pickerView.backgroundColor = [UIColor whiteColor];
        }
        
        [self runAnimation];
    }
    return self;
}

+ (id) newPickerView:(id)target action:(SEL)action
{
    return [[self alloc]init:target action:action];
}

#pragma mark -
#pragma mark Picker view methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{    
    return 1;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{    
    //mlabel.text= [arrayNo objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{    
    return [self.dataSource count];    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [self.dataSource objectAtIndex:row];
}

- (void)slideDownDidStop
{    
    if ([self.target respondsToSelector:self.action])
        
        [self.target performSelector:self.action withObject:nil afterDelay:0];
}

- (IBAction)pickerDoneAction:(id)sender
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
	// start the slide down animation
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
	
    // we need to perform some post operations after the animation is complete
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
	
    self.frame = endFrame;
	[UIView commitAnimations];
}

@end
