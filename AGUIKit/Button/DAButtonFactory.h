//
//  DAButtonFactory.h
//  Distributors
//
//  Created by Tao Yunfei on 1/6/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGModel.h"
#import <UIKit/UIKit.h>

@class DAButtonItem;
@interface DAButtonFactory : AGModel

+ (UIButton *)buttonInstanceWithItem:(DAButtonItem *)item;
+ (UIButton *)buttonInstanceWithTitle:(NSString *)title target:(id)target action:(SEL)action  backgroundColor:(UIColor *)backgroundColor;

+ (void)setDefaultFont:(UIFont *)font;
+ (void)setDefaultBackgroundColor:(UIColor *)color;

@end
