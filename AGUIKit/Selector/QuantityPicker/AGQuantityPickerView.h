//
//  AGQuantityPickerView.h
//  AboveGEM
//
//  Created by traintrackcn on 18/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol AGQuantityPickerViewDelegate <NSObject>

@optional
- (BOOL)quantityPickerViewWillChangeValue:(NSInteger)value;
- (void)quantityPickerViewDidChangeValue:(NSInteger)value;

@end

@interface AGQuantityPickerView : UIView

+ (instancetype)instanceWithValue:(NSInteger)value;
+ (instancetype)instanceWithValue:(NSInteger)value maxValue:(NSInteger)maxValue;
+ (instancetype)instanceWithValue:(NSInteger)value minValue:(NSInteger)minValue;

- (NSInteger)value;
- (void)_setValue:(NSInteger)value;
- (void)setValue:(NSInteger)value;

- (UIColor *)borderColor;

@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, assign) NSInteger maxValue;

@property (nonatomic, weak) id delegate;

@end
