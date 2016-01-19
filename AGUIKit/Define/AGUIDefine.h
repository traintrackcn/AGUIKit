//
//  AGVCGlobalDefine.h
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSDeviceUtil.h"


#define FONT_LIGHT_WITH_SIZE(aSize) [UIFont fontWithName:@"HelveticaNeue-Light" size:aSize]
#define FONT_REGULAR_WITH_SIZE(aSize) [UIFont fontWithName:@"HelveticaNeue" size:aSize]
#define FONT_MEDIUM_WITH_SIZE(aSize) [UIFont fontWithName:@"HelveticaNeue-Medium" size:aSize]

#define STYLE_NAVIGATION_BAR_HEIGHT 44.0
#define STYLE_STATUS_BAR_HEIGHT 20.0
#define STYLE_TAB_BAR_HEIGHT 50.0
#define STYLE_DEVICE_WIDTH [DSDeviceUtil bounds].size.width
#define STYLE_DEVICE_HEIGHT [DSDeviceUtil bounds].size.height
#define STYLE_DEVICE_CONTENT_HEIGHT STYLE_DEVICE_HEIGHT-STYLE_NAVIGATION_BAR_HEIGHT-STYLE_STATUS_BAR_HEIGHT-STYLE_TAB_BAR_HEIGHT
#define STYLE_DEVICE_CONTENT_HEIGHT_WITH_STATUS_BAR_AND_NAVIGATION_BAR STYLE_DEVICE_HEIGHT-STYLE_NAVIGATION_BAR_HEIGHT-STYLE_STATUS_BAR_HEIGHT


@interface AGUIDefine : NSObject

- (BOOL)sessionRoleIsRetailCustomer;
- (NSString *)sessionRoleCode;

@property (nonatomic, strong) Class loginViewControllerClass;
@property (nonatomic, strong) NSArray *availableLanguages;
@property (nonatomic, strong) UINavigationController *rootViewController;
@property (nonatomic, copy) BOOL (^sessionRoleIsRetailCustomerBlock)(void);
@property (nonatomic, copy) NSString *(^sessionRoleCodeBlock)(void);

@end
