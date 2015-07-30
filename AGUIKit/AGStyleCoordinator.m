//
//  DSStyle.m
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "AGStyleCoordinator.h"
#import "NSObject+Singleton.h"
#import "GlobalDefine.h"
#import "DSImage.h"
#import "DSDeviceUtil.h"
#import "DSValueUtil.h"
#import "NSObject+Singleton.h"
#import "AGUIDefine.h"

//#pragma mark - class NSString (PrivateAdditions)

//@interface NSString (PrivateAdditions)
//- (NSUInteger)hexValue;
//@end
//
//@implementation NSString (PrivateAdditions)
//
//- (NSUInteger)hexValue {
//	NSUInteger result = 0;
//	sscanf([self UTF8String], "%x", &result);
//	return result;
//}
//@end


#pragma mark - class DSStyle



@interface AGStyleCoordinator(){
    NSDictionary *style;
    NSMutableDictionary *cache;
}

@end

@implementation AGStyleCoordinator


+ (UIFont *)fontForKey:(NSString *)key{
    return [[AGStyleCoordinator singleton] fontForKey:key];
}


+ (UIColor *)colorForKey:(NSString *)key{
    return [[AGStyleCoordinator singleton] colorForKey:key];
}

+ (NSArray *)rgbForKey:(NSString *)key{
    return [[AGStyleCoordinator singleton] rgbForKey:key];
}

- (id)init{
    self = [super init];
    if (self) {
        cache = [NSMutableDictionary dictionary];
        [self loadPlist];
        [self applyGlobalStyle];
        
        
        NSArray *fontFamilies = [UIFont familyNames];
        for (int i = 0; i < [fontFamilies count]; i++){
            NSString *fontFamily = [fontFamilies objectAtIndex:i];
            NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
            if ([fontFamily rangeOfString:@"Open"].location != NSNotFound) {
                TLOG (@"%@: %@", fontFamily, fontNames);
            }
        }
        
    }
    return self;
}


- (UIImage *)navigationBarBackgroundImage{
//    if (_navigationBarBackgroundImage) {
    NSArray *naviBarBgRGB = [self rgbForKey:@"navigation-bar-background"];
    TLOG(@"naviBarBgRGB -> %@", naviBarBgRGB);
    UIColor *c = [DSImage navigationBarTintColorFromRed:[[naviBarBgRGB objectAtIndex:0] floatValue]
                                                  green:[[naviBarBgRGB objectAtIndex:1] floatValue]
                                                   blue:[[naviBarBgRGB objectAtIndex:2] floatValue]];
    
        _navigationBarBackgroundImage = [DSImage rectangleWithSize:CGSizeMake(1.0, 1.0) fillColor:c];
//    }
    return _navigationBarBackgroundImage;
}



- (void)applyGlobalNavigationBarStyle{
//    NSArray *naviBarBgRGB = [self rgbForKey:@"navigation-bar-background"];
//    TLOG(@"naviBarBgRGB -> %@", naviBarBgRGB);
//    UIColor *c = [DSImage navigationBarTintColorFromRed:[[naviBarBgRGB objectAtIndex:0] floatValue]
//                                                  green:[[naviBarBgRGB objectAtIndex:1] floatValue]
//                                                   blue:[[naviBarBgRGB objectAtIndex:2] floatValue]
//                  ];
    
    
//    [[UINavigationBar appearance] setBarTintColor:c];
    [[UINavigationBar appearance] setBackgroundImage:self.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    if ([DSDeviceUtil iOS8AndAbove]) {
        [[UINavigationBar appearance] setTranslucent:YES];
    }
    
    [[UINavigationBar appearance] setTintColor:[self colorForKey:@"navigation-bar-button-title"]];
//    UIFont *f = [self fontForKey:@"navigation-bar-title"];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [self colorForKey:@"navigation-bar-title"],NSForegroundColorAttributeName,
                                               [AGStyleCoordinator fontWithSize:20], NSFontAttributeName,
                                               nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}

- (void)applyGlobalStyle{
    
//    TLOG(@"role -> %@", [AGSession singleton].roleCode);
    
    [self applyGlobalNavigationBarStyle];
   
    
    //UIBarButtonItem
    [[UIBarButtonItem appearance] setTitleTextAttributes:
                                    @{
                                      NSFontAttributeName:[self fontForKey:@"bar-button-item-title"]
                                      } forState:UIControlStateNormal];
    
    [[UITextField appearance] setTintColor:[self colorForKey:@"input-cursor"]];
    [[UITextView appearance] setTintColor:[self colorForKey:@"input-cursor"]];
    [[UITextField appearance] setFont:[self fontForKey:@"textfield"]];
    [[UITextView appearance] setFont:[self fontForKey:@"textfield"]];
    
}

- (void)loadPlist{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Style" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    style = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
//    if (!style) TLOG(@"Error reading plist: %@, format: %lu", errorDesc, format);
//    TLOG(@"style -> %@", style);
}




#pragma mark - 

- (NSDictionary *)collectionForKey:(NSString *)key{
    return [style objectForKey:key];
}

- (UIFont *)fontForKey:(NSString *)key{
    
    
    
    NSString *globalKey = [NSString stringWithFormat:@"font-%@",key];
    if ([self isCachedForGlobalKey:globalKey]) return (UIFont *)[self cacheForGlobalKey:globalKey];
    NSDictionary *collection = [self collectionForKey:@"fonts"];
    NSString *value = [self valueFromCollection:collection forKey:key];
    
    if ([self isNotFontValue:value]) {
        return [self fontForKey:value];
    }
    
    return [self fontFromValue:value forGlobalKey:globalKey];
}

- (UIColor *)colorForKey:(NSString *)key{
    NSString *globalKey = [NSString stringWithFormat:@"color-%@",key];
    if ([self isCachedForGlobalKey:globalKey]) return (UIColor *)[self cacheForGlobalKey:globalKey];
    NSDictionary *collection = [self collectionForKey:@"colors"];
    NSString *value = [self valueFromCollection:collection forKey:key];
//    NSString *dKey = [NSString stringWithFormat:@"d-%@",key];
    
    if ([self isNotColorValue:value]) { // is a shortcut
        if ([AGUIDefine singleton].sessionRoleIsRetailCustomer) {
            return [self colorForKey:value];
        }else{
            NSString *colorKeyForD = [NSString stringWithFormat:@"d-%@",value];
            if ([DSValueUtil isAvailable:[self valueFromCollection:collection forKey:colorKeyForD]]) {
                return [self colorForKey:colorKeyForD];
            }else{
                return [self colorForKey:value];
            }
        }
        
    }
    

    
    return [self colorFromValue:value forGlobalKey:globalKey];
}

- (id)valueFromCollection:(NSDictionary *)collection forKey:(NSString *)key{
    return [collection objectForKey:key];
}

#pragma mark - utils

- (BOOL)isColorValue:(NSString *)value{
    if ([value rangeOfString:@","].location != NSNotFound) return YES;
    if ([value rangeOfString:@"#"].location != NSNotFound) return YES;
    return NO;
}

- (BOOL)isNotColorValue:(NSString *)value{
    return ![self isColorValue:value];
}

- (BOOL)isFontValue:(NSString *)value{
    if ([value rangeOfString:@","].location != NSNotFound) return YES;
    return NO;
}

- (BOOL)isNotFontValue:(NSString *)value{
    return ![self isFontValue:value];
}


#pragma mark - utils

- (BOOL)isCachedForGlobalKey:(NSString *)globalKey{
    if ([self cacheForGlobalKey:globalKey]) return YES;
    return NO;
}

- (id)cacheForGlobalKey:(NSString *)globalKey{
    return [cache objectForKey:globalKey];
}

- (void)saveToCache:(id)value forGlobalKey:(NSString *)globalKey{
    [cache setObject:value forKey:globalKey];
}

- (UIColor *)colorFromValue:(NSString *)value forGlobalKey:(NSString *)globalKey{
    
//    TLOG(@"globalKey -> %@ value -> %@", globalKey, value);
    
    UIColor *c;
    if ([value rangeOfString:@","].location != NSNotFound) {
         c =  [self colorFromRGBValue:value];
    }else if([value rangeOfString:@"#"].location != NSNotFound){
        c = [self colorFromHexValue:value];
    }
    
    [self saveToCache:c forGlobalKey:globalKey];
    return c;
}



- (NSArray *)rgbForKey:(NSString *)key{
    NSDictionary *collection = [self collectionForKey:@"colors"];
    NSString *value = [self valueFromCollection:collection forKey:key];
    
    if ([self isNotColorValue:value]) { // is a shortcut
        if ([AGUIDefine singleton].sessionRoleIsRetailCustomer) {
            return [self rgbForKey:value];
        }else{
            NSString *colorKeyForD = [NSString stringWithFormat:@"d-%@",value];
            if ([DSValueUtil isAvailable:[self valueFromCollection:collection forKey:colorKeyForD]]) {
                return [self rgbForKey:colorKeyForD];
            }else{
                return [self rgbForKey:value];
            }
        }
        
    }
    
    return [value componentsSeparatedByString:@","];
}

- (UIColor *)colorFromRGBValue:(NSString *)value{
    NSArray *arr = [value componentsSeparatedByString:@","];
    float r = [[arr objectAtIndex:0] doubleValue];
    float g = [[arr objectAtIndex:1] doubleValue];
    float b = [[arr objectAtIndex:2] doubleValue];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

//- (UIColor *)colorFromHexValue:(NSString *)value{
//    return [self colorWithHexString:value];
//}


- (UIFont *)fontFromValue:(NSString *)value forGlobalKey:(NSString *)globalKey{
    NSArray *arr = [value componentsSeparatedByString:@","];
    NSString *name = [arr objectAtIndex:0];
    float size = [[arr objectAtIndex:1] doubleValue];
//    TLOG(@"name -> %@ size -> %f", name, size);
    UIFont *f = [UIFont fontWithName:name size:size];
    if ([DSValueUtil isNotAvailable:f]) {
        f = [UIFont systemFontOfSize:9];
    }
    [self saveToCache:f forGlobalKey:globalKey];
    return f;
}

- (UIImage *)imageFromValue:(NSDictionary *)value forGlobalKey:(NSString *)globalKey{
    NSString *imageName = [value objectForKey:@"name"];
    UIEdgeInsets edgeInsets = UIEdgeInsetsFromString([value objectForKey:@"edge-insets"]);
    return [[UIImage imageNamed:imageName] resizableImageWithCapInsets:edgeInsets];
}




- (UIColor *)colorFromHexValue:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//
//- (UIColor*)colorWithHexString:(NSString *)hex{
//	// Remove `#`
//	if ([[hex substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"#"]) {
//		hex = [hex substringFromIndex:1];
//	}
//	// Invalid if not 3, 6, or 8 characters
//	NSUInteger length = [hex length];
//	if (length != 3 && length != 6 && length != 8) {
//		return nil;
//	}
//	
//	// Make the string 8 characters long for easier parsing
//	if (length == 3) {
//		NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
//		NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
//		NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
//		hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
//			   r, r, g, g, b, b];
//	} else if (length == 6) {
//		hex = [hex stringByAppendingString:@"ff"];
//	}
//	
//	CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)]  hexValue] / 255.0f;
//	CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] hexValue] / 255.0f;
//	CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] hexValue] / 255.0f;
//	CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] hexValue] / 255.0f;
//    
//	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//}

#pragma mark - quick fonts

+ (UIFont *)fontNavigationBarTitle{
    return [self fontForKey:@"navigation-bar-title"];
}

+ (UIFont *)fontDashboardComponentTitle{
    return [self fontForKey:@"dashboard-component-title"];
}

+ (UIFont *)fontDashboardComponentContent{
    return [self fontForKey:@"dashboard-component-content"];
}

+ (UIFont *)fontDashboardComponentCommissionsTitle{
    return [self fontForKey:@"dashboard-component-commissions-title"];
}

+ (UIFont *)fontDashboardComponentCommissionsContent{
    return [self fontForKey:@"dashboard-component-commissions-content"];
}

+ (UIFont *)fontNewsCellTitle{
    return [self fontForKey:@"news-cell-title"];
}

+ (UIFont *)fontNewsCellContent{
    return [self fontForKey:@"news-cell-content"];
}

+ (UIFont *)fontMenuCellTitleNormal{
    return [self fontForKey:@"menu-cell-title-normal"];
}

+ (UIFont *)fontMenuCellTitleHighlight{
    return [self fontForKey:@"menu-cell-title-highlight"];
}

+ (UIFont *)fontMenuCatalogTitle{
    return [self fontForKey:@"menu-catalog-title"];
}

+ (UIFont *)fontMenuProfileCellTitle{
    return [self fontForKey:@"menu-profile-cell-title"];
}

+ (UIFont *)fontMenuProfileCellSubtitle{
    return [self fontForKey:@"menu-profile-cell-subtitle"];
}

+ (UIFont *)fontProductCellName{
    return [self fontForKey:@"product-cell-name"];
}

+ (UIFont *)fontProductCellSku{
    return [self fontForKey:@"product-cell-sku"];
}

+ (UIFont *)fontProductCellPrice{
    return [self fontForKey:@"product-cell-price"];
}

+ (UIFont *)fontLoginHeaderCellTitle{
    return [self fontForKey:@"login-header-cell-title"];
}

+ (UIFont *)fontLoginHeaderCellSubtitle{
    return [self fontForKey:@"login-header-cell-subtitle"];
}

+ (UIFont *)fontButton{
    return [self fontForKey:@"button"];
}

+ (UIFont *)fontTabBarTitleNormal{
    return [self fontForKey:@"tab-bar-title-normal"];
}

+ (UIFont *)fontTabBarTitleHighlight{
    return [self fontForKey:@"tab-bar-title-highlight"];
}

+ (UIFont *)fontTextCellTitle{
    return [self fontForKey:@"text-cell-title"];
}

+ (UIFont *)fontOrderCellNumber{
    return [self fontForKey:@"order-cell-number"];
}

+ (UIFont *)fontTextCellContent{
    return [self fontForKey:@"text-cell-content"];
}

+ (UIFont *)fontTextCellSubtitle{
    return [self fontForKey:@"text-cell-subtitle"];
}

+ (UIFont *)fontIndicator{
    return [self fontForKey:@"indicator"];
}

+ (UIFont *)fontChartCoordinatorLabel{
    return [self fontForKey:@"chart-coordinator-label"];
}

+ (UIFont *)fontChartTitle{
    return [self fontForKey:@"chart-title"];
}

+ (UIFont *)fontProductCellQuanity{
    return [self fontForKey:@"product-cell-quantity"];
}

+ (UIFont *)fontQuantityPicker{
    return [self fontForKey:@"quantity-picker"];
}

+ (UIFont *)fontHeaderViewTitle{
    return [self fontForKey:@"header-view-title"];
}
+ (UIFont *)fontSelectorHeader{
    return [self fontForKey:@"selector-header"];
}

+ (UIFont *)fontMultiLineCellStatus{
    return [self fontForKey:@"multi-line-cell-status"];
}

+ (UIFont *)fontOptionCellTitle{
    return [self fontForKey:@"option-cell-title"];
}

+ (UIFont *)fontHeader3{
    return [self fontForKey:@"header3"];
}

+ (UIFont *)fontDashboardNumberBoxTitle{
    return [self fontForKey:@"dashboard-number-box-title"];
}

+ (UIFont *)fontDashboardNumberBoxSubtitle{
    return [self fontForKey:@"dashboard-number-box-subtitle"];
}

+ (UIFont *)fontHeaderViewStyleCompactDarkTitle{
    return [self fontForKey:@"header-view-style-compact-dark-title"];
}

+ (UIFont *)fontOrderStateIndicator{
    return [self fontForKey:@"order-state-indicator"];
}

+ (UIFont *)fontCircleProgressViewStatus{
    return [self fontForKey:@"circle-progress-view-status"];
}

+ (UIFont *)fontCommissionHeaderViewTitle{
    return [self fontForKey:@"commission-header-view-title"];
}

+ (UIFont *)fontMultiValueCellTitle{
    return [self fontForKey:@"multi-value-cell-title"];
}

+ (UIFont *)fontMultiValueCellHeader{
    return [self fontForKey:@"multi-value-cell-header"];
}

+ (UIFont *)fontGenealogyCellTitle{
    return [self fontForKey:@"genealogy-cell-title"];
}

+ (UIFont *)fontGenealogyCellSubtitle{
    return [self fontForKey:@"genealogy-cell-subtitle"];
}

+ (UIFont *)fontGenealogyRankCellTitle{
    return [self fontForKey:@"genealogy-rank-cell-title"];
}

+ (UIFont *)fontChildTaxonCellTitle{
    return [self fontForKey:@"child-taxon-cell-title"];
}

+ (UIFont *)fontTaxonCellTitle{
    return [self fontForKey:@"taxon-cell-title"];
}

+ (UIFont *)fontOrganizationCellTitle{
    return [self fontForKey:@"organization-cell-title"];
}

+ (UIFont *)fontOrganizationCellSubtitle{
    return [self fontForKey:@"organization-cell-subtitle"];
}

+ (UIFont *)fontLabelStyleSubtitleTextCell{
    return [self fontForKey:@"label-style-subtitle-text-cell"];
}

#pragma mark - 

+ (UIFont *)fontWithSize:(NSInteger)size{
    UIFont *f = [UIFont fontWithName:@"OpenSans" size:size];
    return f;
}


#pragma mark - quick colors


+ (UIColor *)colorPriceTitle{
    return [self colorForKey:@"price-title"];
}

+ (UIColor *)colorBackgroundNormal{
    return [self colorForKey:@"background-normal"];
}

+ (UIColor *)colorBackgroundCommission{
    return RGBA(249, 248, 224, 1);
}

+ (UIColor *)colorBackgroundCommissionHeader{
    return RGBA(198, 146, 53, 1);
}

+ (UIColor *)colorBackgroundCommissionHeaderCell{
    return RGBA(241, 229, 186, 1);
}

+ (UIColor *)colorBackgroundCommissionContentCell{
    return RGBA(241, 234, 198, 1);
}

+ (UIColor *)colorHeaderViewBackground{
    return [self colorForKey:@"header-view-background"];
}


+ (UIColor *)colorCommissionCellBorder{
    return RGBA(234, 224, 184, 1);
}

+ (UIColor *)colorCommissionHeaderBorder{
    return RGBA(172, 124, 25, 1);
}

+ (UIColor *)colorCellTitleUnselected{
    return [self colorForKey:@"cell-title-unselected"];
}

+ (UIColor *)colorCellTitleSelected{
    return [self colorForKey:@"cell-title-selected"];
}

+ (UIColor *)colorHeaderViewBorder{
    return [self colorForKey:@"header-view-border"];
}

+ (UIColor *)colorButtonBackgroundNormal{
    return [self colorForKey:@"button-background-normal"];
}

+ (UIColor *)colorTextfieldTitle{
    return [self colorForKey:@"textfield-title"];
}

+ (UIColor *)colorTextfieldContent{
    return [self colorForKey:@"textfield-content"];
}

+ (UIColor *)colorCartCellTitle{
    return [self colorForKey:@"cart-cell-title"];
}

+ (UIColor *)colorCartCellPrice{
    return [self colorForKey:@"cart-cell-price"];
}

+ (UIColor *)colorTaxonCellTitle{
    return [self colorForKey:@"taxon-cell-title"];
}

+ (UIColor *)colorCellBorder{
    return [self colorForKey:@"cell-border"];
}

+ (UIColor *)colorCellBackgroundUnselected{
    return [self colorForKey:@"cell-background-unselected"];
}

+ (UIColor *)colorSearchFieldBackground{
    return [self colorForKey:@"search-field-background"];
}

+ (UIColor *)colorInputCursor{
    return [self colorForKey:@"input-cursor"];
}

+ (UIColor *)colorGenealogyNodeCellTitle{
    return [self colorForKey:@"genealogy-node-cell-title"];
}

+ (UIColor *)colorGenealogyNodeCellSubtitle{
    return [self colorForKey:@"genealogy-node-cell-subtitle"];
}

+ (UIColor *)colorOptionCellBackgroundSelected{
    return [self colorForKey:@"option-cell-background-selected"];
}

+ (UIColor *)colorOptionCellBackgroundNormal{
    return [self colorForKey:@"option-cell-background-normal"];
}

+ (UIColor *)colorOptionCellTitleSelected{
    return [self colorForKey:@"option-cell-title-selected"];
}

+ (UIColor *)colorOptionCellTitleNormal{
    return [self colorForKey:@"option-cell-title-normal"];
}

+ (UIColor *)colorOptionCellBorder{
    return [self colorForKey:@"option-cell-border"];
}

+ (UIColor *)colorOrganizationCellRoleCodeBorder{
    return [self colorForKey:@"organization-cell-role-code-border"];
}

+ (UIColor *)colorRegistrationButtonBackgroundRoleR{
    return [self colorForKey:@"registration-button-background-role-r"];
}

+ (UIColor *)colorRegistrationButtonBackgroundRoleD{
    return [self colorForKey:@"registration-button-background-role-d"];
}

+ (UIColor *)colorRegistrationButtonBackgroundRoleDefault{
    return [self colorForKey:@"registration-button-background-role-default"];
}


+ (UIColor *)colorRegistrationRoleDCellText{
    return [self colorForKey:@"registration-role-d-cell-text"];
}

+ (UIColor *)colorRegistrationRoleCellText{
    return [self colorForKey:@"registration-role-cell-text"];
}

+ (UIColor *)colorProfileCellTitle{
    return [self colorForKey:@"profile-cell-title"];
}

+ (UIColor *)colorProfileCellSubtitle{
    return [self colorForKey:@"profile-cell-subtitle"];
}

+ (UIColor *)colorProfileCellBorder{
    return [self colorForKey:@"profile-cell-border"];
}



#pragma mark - menu
+ (UIColor *)colorMenuBackgroundNormal{
    return [self colorForKey:@"menu-background"];
}

+ (UIColor *)colorMenuTitleSelected{
    return [self colorForKey:@"menu-title-selected"];
}

+ (UIColor *)colorMenuTitleUnselected{
    return [self colorForKey:@"menu-title-unselected"];
}


#pragma mark - tab bar cell

+ (UIColor *)colorTabBarCellTitleNormal{
    return [self colorForKey:@"tab-bar-cell-title-normal"];
}

+ (UIColor *)colorTabBarCellTitleHighlight{
    return [self colorForKey:@"tab-bar-cell-title-highlight"];
}

+ (UIColor *)colorTabBarCellTitleBorder{
    return [self colorForKey:@"tab-bar-cell-title-border"];
}

+ (UIColor *)colorTabBarCellBackgroundNormal{
    return [self colorForKey:@"tab-bar-cell-background-normal"];
}

+ (UIColor *)colorButtonTitleNormal{
    return [self colorForKey:@"button-title-normal"];
}

#pragma mark - 

+ (UIColor *)colorDashboardSettingsBackground{
    return [self colorForKey:@"dashboard-settings-background"];
}

+ (UIColor *)colorDashboardResourcesBackground{
    return [self colorForKey:@"dashboard-resources-background"];
}

+ (UIColor *)colorDashboardProfileBackground{
    return [self colorForKey:@"dashboard-profile-background"];
}

+ (UIColor *)colorDashboardCommissionsBackground{
    return [self colorForKey:@"dashboard-commissions-background"];
}

+ (UIColor *)colorDashboardStarStatusBackground{
    return [self colorForKey:@"dashboard-star-status-background"];
}

+ (UIColor *)colorDashboardWalletBackground{
    return [self colorForKey:@"dashboard-wallet-background"];
}

+ (UIColor *)colorDashboardRecentOrdersBackground{
    return [self colorForKey:@"dashboard-recent-orders-background"];
}

+ (UIColor *)colorDashboardNewsBackground{
    return [self colorForKey:@"dashboard-news-background"];
}

+ (UIColor *)colorDashboardAutoshipBackground{
    return [self colorForKey:@"dashboard-autoship-background"];
}

+ (UIColor *)colorLineProgressViewTitle{
    return [self colorForKey:@"line-progress-view-title"];
}

+ (UIColor *)colorLineProgressViewSubtitle{
    return [self colorForKey:@"line-progress-view-subtitle"];
}

+ (UIColor *)colorBorderStyleDefault{
    return [self colorForKey:@"border-style-default"];
}

+ (UIColor *)colorDashboardNumberOfActiveDistributorsBackground{
    return [self colorForKey:@"dashboard-number-of-active-distributors-background"];
}

#pragma mark - 

+ (UIColor *)colorChartCoordinatorLabel{
    return [self colorForKey:@"chart-coordinator-label"];
}

+ (UIColor *)colorNormalText{
    return RGBA(40, 40, 40, 1);
}

+ (UIColor *)colorLightText{
    return [self colorForKey:@"light-text"];
}

+ (UIColor *)colorLighter{
    return RGBA(170, 170, 170, 1);
}

+ (UIColor *)colorDarkText{
    return [self colorForKey:@"dark-text"];
}

+ (UIColor *)colorTheme{
    return [self colorForKey:@"theme"];
}

+ (UIColor *)colorDisabled{
    return RGBA(221, 221, 221, 1);
}


#pragma mark - decorators

+ (void)decorateCircleMaskForView:(UIView *)view radius:(CGFloat)radius{
    //    CGSize imgSize = view.frame.size;
    //    TLOG(@"imgSize %f %f", imgSize.width, imgSize.height);
    //    CALayer *mask = [CALayer layer];
    //    mask.contents = (id)[[UIImage imageNamed:maskName] CGImage];
    //    mask.frame = CGRectMake(0, 0, imgSize.width, imgSize.height);
    
    //    int radius = 95.0/2.0;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    //    circle.position = CGPointMake(CGRectGetMidX(view.frame)-radius,
    //                                  CGRectGetMidY(view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor blackColor].CGColor;
    //    circle.strokeColor = [UIColor blackColor].CGColor;
    //    circle.lineWidth = 0;
    
    // Add to parent layer
    //    [self.view.layer addSublayer:circle];
    
    
    CALayer *vLayer = [view layer];
    [vLayer addSublayer:circle];
    vLayer.mask = circle;
    vLayer.masksToBounds = YES;
}


@end



