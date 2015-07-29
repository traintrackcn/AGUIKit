//
//  DSStyle.h
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AGStyleCoordinator : NSObject

+ (UIFont *)fontForKey:(NSString *)key;
+ (UIColor *)colorForKey:(NSString *)key;
+ (NSArray *)rgbForKey:(NSString *)key;

- (void)applyGlobalStyle;
//- (void)applyGlobalNavigationBarBackground;

@property (nonatomic, strong) UIImage *navigationBarBackgroundImage;




#pragma mark - quick fonts

+ (UIFont *)fontNavigationBarTitle;
+ (UIFont *)fontDashboardComponentTitle;
+ (UIFont *)fontDashboardComponentContent;
+ (UIFont *)fontDashboardComponentCommissionsTitle;
+ (UIFont *)fontDashboardComponentCommissionsContent;
+ (UIFont *)fontNewsCellTitle;
+ (UIFont *)fontNewsCellContent;
+ (UIFont *)fontMenuCellTitleNormal;
+ (UIFont *)fontMenuCellTitleHighlight;
+ (UIFont *)fontMenuCatalogTitle;
+ (UIFont *)fontMenuProfileCellTitle;
+ (UIFont *)fontMenuProfileCellSubtitle;
+ (UIFont *)fontProductCellName;
+ (UIFont *)fontProductCellSku;
+ (UIFont *)fontProductCellPrice;
+ (UIFont *)fontLoginHeaderCellTitle;
+ (UIFont *)fontLoginHeaderCellSubtitle;
+ (UIFont *)fontButton;
+ (UIFont *)fontTabBarTitleNormal;
+ (UIFont *)fontTabBarTitleHighlight;
+ (UIFont *)fontTextCellTitle;
+ (UIFont *)fontOrderCellNumber;
+ (UIFont *)fontTextCellContent;
+ (UIFont *)fontTextCellSubtitle;
+ (UIFont *)fontProductCellQuanity;
+ (UIFont *)fontQuantityPicker;
+ (UIFont *)fontHeaderViewTitle;
+ (UIFont *)fontSelectorHeader;
+ (UIFont *)fontMultiLineCellStatus;
+ (UIFont *)fontOptionCellTitle;
+ (UIFont *)fontHeader3;
+ (UIFont *)fontCircleProgressViewStatus;
+ (UIFont *)fontCommissionHeaderViewTitle;
+ (UIFont *)fontMultiValueCellTitle;
+ (UIFont *)fontMultiValueCellHeader;
+ (UIFont *)fontGenealogyCellTitle;
+ (UIFont *)fontGenealogyCellSubtitle;
+ (UIFont *)fontGenealogyRankCellTitle;
+ (UIFont *)fontChildTaxonCellTitle;
+ (UIFont *)fontTaxonCellTitle;
+ (UIFont *)fontOrganizationCellTitle;
+ (UIFont *)fontOrganizationCellSubtitle;
+ (UIFont *)fontLabelStyleSubtitleTextCell;
+ (UIFont *)fontDashboardNumberBoxTitle;
+ (UIFont *)fontDashboardNumberBoxSubtitle;
+ (UIFont *)fontHeaderViewStyleCompactDarkTitle;
+ (UIFont *)fontOrderStateIndicator;
+ (UIFont *)fontIndicator;
+ (UIFont *)fontChartCoordinatorLabel;
+ (UIFont *)fontChartTitle;


+ (UIFont *)fontWithSize:(NSInteger)size;

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
