//
//  EPPickerView.h
//  DataCell
//
//  Created by Yang Nung Jan on 2/7/12.
//  Copyright (c) 2012 Erawppa Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPickerView : UIView <UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIBarButtonItem *barButtonItem;
@property (strong, nonatomic) id target;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic) SEL action;

+ (id) newPickerView:(id)target action:(SEL)action;

@end
