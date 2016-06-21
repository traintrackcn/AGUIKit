//
//  DSStyle.h
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "NSObject+Singleton.h"
#import "AGUIDefine.h"
@import UIKit;

#define COLOR(aValue) [[AGStyleCoordinator singleton] colorForValue:aValue]
#define RGB(aValue) [[AGStyleCoordinator singleton] rgbForValue:aValue]

@interface AGStyleCoordinator : NSObject

- (UIColor *)colorForValue:(NSString *)value;
- (NSString *)rgbForValue:(NSString *)value;


@end
