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

#define COLOR_FOR_KEY(aKey) [[AGStyleCoordinator singleton] colorForKey:aKey]
#define COLOR(aRGB) [[AGStyleCoordinator singleton] colorFromRGBValue:aRGB]
#define RGB(aKey) [[AGStyleCoordinator singleton] rgbForKey:aKey]

@interface AGStyleCoordinator : NSObject

- (UIColor *)colorFromRGBValue:(NSString *)value;
- (NSString *)rgbForKey:(NSString *)key;
;- (UIColor *)colorForKey:(NSString *)key;

@end
