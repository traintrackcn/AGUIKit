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


#pragma mark - common colors
@property (nonatomic, strong) NSString *RGB_THEME;
@property (nonatomic, strong) NSString *RGB_DISABLED;

#pragma mark - title colors
@property (nonatomic, strong) NSString *RGB_TITLE;
@property (nonatomic, strong) NSString *RGB_TITLE_NORMAL;
@property (nonatomic, strong) NSString *RGB_TITLE_LIGHT;
@property (nonatomic, strong) NSString *RGB_TITLE_LIGHTER;

#pragma mark - border colors
@property (nonatomic, strong) NSString *RGB_BORDER_DARKER;
@property (nonatomic, strong) NSString *RGB_BORDER;

#pragma mark - background colors
@property (nonatomic, strong) NSString *RGB_BACKGROUND_SELECTED;
@property (nonatomic, strong) NSString *RGB_BACKGROUND_NORMAL;

#pragma mark - tab bar colors
@property (nonatomic, strong) NSString *RGB_TAB_BAR_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_TAB_BAR_NORMAL;

#pragma mark - cell colors
@property (nonatomic, strong) NSString *RGB_CELL_TITLE_NORMAL;
@property (nonatomic, strong) NSString *RGB_CELL_TITLE_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_CELL_CONTENT_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_CELL_CONTENT_NORMAL;
@property (nonatomic, strong) NSString *RGB_CELL_BACKGROUND_NORMAL;
@property (nonatomic, strong) NSString *RGB_CELL_BACKGROUND_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_CELL_BORDER;

#pragma mark - avc message colors
@property (nonatomic, strong) NSString *RGB_AVC_SUCCESS_MESSAGE_TITLE;
@property (nonatomic, strong) NSString *RGB_AVC_SUCCESS_MESSAGE_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_AVC_FAILURE_MESSAGE_TITLE;
@property (nonatomic, strong) NSString *RGB_AVC_FAILURE_MESSAGE_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_AVC_LOADING_MESSAGE_TITLE;
@property (nonatomic, strong) NSString *RGB_AVC_LOADING_MESSAGE_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_FLOATING_MESSAGE_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_FLOATING_MESSAGE;

#pragma mark - input colors
@property (nonatomic, strong) NSString *RGB_INPUT_NORMAL;
@property (nonatomic, strong) NSString *RGB_INPUT_STAR;
@property (nonatomic, strong) NSString *RGB_INPUT_TITLE;
@property (nonatomic, strong) NSString *RGB_INPUT_CONTENT;
@property (nonatomic, strong) NSString *RGB_INPUT_CURSOR;
@property (nonatomic, strong) NSString *RGB_INPUT_ICON;

#pragma mark - line progress colors
@property (nonatomic, strong) NSString *LINE_PROGRESS_TITLE;
@property (nonatomic, strong) NSString *LINE_PROGRESS_SUBTITLE;

#pragma mark - button colors
@property (nonatomic, strong) NSString *RGB_BUTTON_BACKGROUND_NORMAL;
@property (nonatomic, strong) NSString *RGB_BUTTON_TITLE_NORMAL;
@property (nonatomic, strong) NSString *RGB_BUTTON_BORDER;

#pragma mark - header colors
@property (nonatomic, strong) NSString *RGB_HEADER;
@property (nonatomic, strong) NSString *RGB_HEADER_BORDER;
@property (nonatomic, strong) NSString *RGB_HEADER_BACKGROUND;

#pragma mark - option colors
//option
@property (nonatomic, strong) NSString *RGB_OPTION_BACKGROUND_HIGHLIGHT @"84,175,214"
@property (nonatomic, strong) NSString *RGB_OPTION_BACKGROUND_NORMAL RGB_WHITE
@property (nonatomic, strong) NSString *RGB_OPTION_TITLE_HIGHLIGHT RGB_WHITE
@property (nonatomic, strong) NSString *RGB_OPTION_TITLE_NORMAL RGB_TITLE_NORMAL
@property (nonatomic, strong) NSString *RGB_OPTION_BORDER RGB_BORDER

@end
