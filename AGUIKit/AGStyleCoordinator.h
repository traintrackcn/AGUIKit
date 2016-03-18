//
//  DSStyle.h
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define COLOR_FOR_KEY(aKey) [AGStyleCoordinator colorForKey:aKey]
#define COLOR(aRGB) [AGStyleCoordinator colorFromRGBValue:aRGB]


@interface AGStyleCoordinator : NSObject

+ (UIColor *)colorForKey:(NSString *)key;
+ (NSArray *)rgbForKey:(NSString *)key;
+ (UIColor *)colorFromRGBValue:(NSString *)value;

#pragma mark - for quick pick


+ (UIColor *)colorPriceTitle;

+ (UIColor *)colorBackgroundNormal;


+ (UIColor *)colorHeaderViewBackground;



+ (UIColor *)colorCellTitleSelected;
+ (UIColor *)colorCellTitleUnselected;

+ (UIColor *)colorHeaderViewBorder;

+ (UIColor *)colorButtonBackgroundNormal;

+ (UIColor *)colorTextfieldTitle;
+ (UIColor *)colorTextfieldContent;

+ (UIColor *)colorCartCellTitle;
+ (UIColor *)colorCartCellPrice;

+ (UIColor *)colorTaxonCellTitle;

+ (UIColor *)colorCellBorder;
+ (UIColor *)colorCellBackgroundUnselected;

+ (UIColor *)colorSearchFieldBackground;

+ (UIColor *)colorInputCursor;

+ (UIColor *)colorGenealogyNodeCellTitle;
+ (UIColor *)colorGenealogyNodeCellSubtitle;

+ (UIColor *)colorOptionCellBackgroundSelected;
+ (UIColor *)colorOptionCellBackgroundNormal;

+ (UIColor *)colorOptionCellTitleSelected;
+ (UIColor *)colorOptionCellTitleNormal;

+ (UIColor *)colorOptionCellBorder;

+ (UIColor *)colorOrganizationCellRoleCodeBorder;

+ (UIColor *)colorRegistrationButtonBackgroundRoleR;
+ (UIColor *)colorRegistrationButtonBackgroundRoleDefault;

//+ (UIColor *)colorRegistrationRoleRCellText;
+ (UIColor *)colorRegistrationRoleDCellText;

+ (UIColor *)colorProfileCellTitle;
+ (UIColor *)colorProfileCellSubtitle;
+ (UIColor *)colorProfileCellBorder;



#pragma mark - menu
+ (UIColor *)colorMenuBackgroundNormal;
+ (UIColor *)colorMenuTitleSelected;
+ (UIColor *)colorMenuTitleUnselected;

#pragma mark - tab bar cell
+ (UIColor *)colorTabBarCellTitleNormal;
+ (UIColor *)colorTabBarCellTitleHighlight;
+ (UIColor *)colorTabBarCellTitleBorder;
+ (UIColor *)colorTabBarCellBackgroundNormal;

+ (UIColor *)colorButtonTitleNormal;

#pragma mark - dashboard

+ (UIColor *)colorDashboardSettingsBackground;
+ (UIColor *)colorDashboardResourcesBackground;
//+ (UIColor *)colorDashboardShortcutTitle;
+ (UIColor *)colorDashboardCommissionsBackground;
+ (UIColor *)colorDashboardProfileBackground;
+ (UIColor *)colorDashboardStarStatusBackground;
+ (UIColor *)colorDashboardWalletBackground;
+ (UIColor *)colorDashboardRecentOrdersBackground;
+ (UIColor *)colorDashboardNewsBackground;
+ (UIColor *)colorDashboardAutoshipBackground;

+ (UIColor *)colorLineProgressViewTitle;
+ (UIColor *)colorLineProgressViewSubtitle;

+ (UIColor *)colorBorderStyleDefault;

+ (UIColor *)colorDashboardNumberOfActiveDistributorsBackground;

#pragma mark - commission-reports

+ (UIColor *)colorCommissionCellBorder;
+ (UIColor *)colorCommissionHeaderBorder;
+ (UIColor *)colorBackgroundCommissionHeaderCell;
+ (UIColor *)colorBackgroundCommission;
+ (UIColor *)colorBackgroundCommissionHeader;
+ (UIColor *)colorBackgroundCommissionContentCell;

#pragma mark - 

+ (UIColor *)colorChartCoordinatorLabel;
+ (UIColor *)colorNormalText;
+ (UIColor *)colorLightText;
+ (UIColor *)colorLighter;
+ (UIColor *)colorDarkText;
+ (UIColor *)colorTheme;
+ (UIColor *)colorDisabled;

@end
