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
#import "GlobalDefine.h"
#import "NSObject+Singleton.h"
#import "AGStyleCoordinator.h"

#define AG_UI_DEFINE [AGUIDefine singleton]

#define STYLE_NAVIGATION_BAR_HEIGHT 44.0
#define STYLE_STATUS_BAR_HEIGHT 20.0
#define STYLE_TAB_BAR_HEIGHT 50.0
#define STYLE_DEVICE_WIDTH [DSDeviceUtil bounds].size.width
#define STYLE_DEVICE_HEIGHT [DSDeviceUtil bounds].size.height
#define STYLE_DEVICE_CONTENT_HEIGHT STYLE_DEVICE_HEIGHT-STYLE_NAVIGATION_BAR_HEIGHT-STYLE_STATUS_BAR_HEIGHT-STYLE_TAB_BAR_HEIGHT
#define STYLE_DEVICE_CONTENT_HEIGHT_WITH_STATUS_BAR_AND_NAVIGATION_BAR STYLE_DEVICE_HEIGHT-STYLE_NAVIGATION_BAR_HEIGHT-STYLE_STATUS_BAR_HEIGHT
#define STYLE_PADDING_LR_DEFAULT 15.0



#define FONT_WITH_SIZE(aSize) [UIFont fontWithName:AG_UI_DEFINE.fontNameDefault size:aSize]
#define FONT_BOLD_WITH_SIZE(aSize) [UIFont fontWithName:AG_UI_DEFINE.fontNameBold size:aSize]
#define FONT_LIGHT_WITH_SIZE(aSize) [UIFont fontWithName:AG_UI_DEFINE.fontNameLight size:aSize]
#define FONT_REGULAR_WITH_SIZE(aSize) [UIFont fontWithName:AG_UI_DEFINE.fontNameRegular size:aSize]
#define FONT_MEDIUM_WITH_SIZE(aSize) [UIFont fontWithName:AG_UI_DEFINE.fontNameMedium size:aSize]


@interface AGUIDefine : NSObject

- (BOOL)sessionRoleIsRetailCustomer;
- (NSString *)sessionRoleCode;



@property (nonatomic, strong) Class loginViewControllerClass;
@property (nonatomic, strong) NSArray *availableLanguages;
@property (nonatomic, strong) UINavigationController *rootViewController;
@property (nonatomic, copy) BOOL (^sessionRoleIsRetailCustomerBlock)(void);
@property (nonatomic, copy) NSString *(^sessionRoleCodeBlock)(void);


#pragma mark - fonts

@property (nonatomic, strong) NSString *fontNameDefault;
@property (nonatomic, strong) NSString *fontNameBold;
@property (nonatomic, strong) NSString *fontNameLight;
@property (nonatomic, strong) NSString *fontNameRegular;
@property (nonatomic, strong) NSString *fontNameMedium;


#pragma mark - colors
@property (nonatomic, strong) NSString *RGB_BORDER_DARKER;
@property (nonatomic, strong) NSString *RGB_BORDER;
@property (nonatomic, strong) NSString *RGB_BACKGROUND_SELECTED;
@property (nonatomic, strong) NSString *RGB_BACKGROUND_NORMAL;
@property (nonatomic, strong) NSString *RGB_THEME;
@property (nonatomic, strong) NSString *RGB_WHITE;
@property (nonatomic, strong) NSString *RGB_TAB_BAR_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_TAB_BAR_NORMAL;
@property (nonatomic, strong) NSString *RGB_DISABLED;

@end
