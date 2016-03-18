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


+ (UIColor *)colorForKey:(NSString *)key{
    return [[AGStyleCoordinator singleton] colorForKey:key];
}

+ (NSArray *)rgbForKey:(NSString *)key{
    return [[AGStyleCoordinator singleton] rgbForKey:key];
}

+ (UIColor *)colorFromRGBValue:(NSString *)value{
    return [[AGStyleCoordinator singleton] colorFromRGBValue:value];
}


- (id)init{
    self = [super init];
    if (self) {
        cache = [NSMutableDictionary dictionary];
        [self loadPlist];
//        [self applyGlobalStyle];
        
        
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
//    TLOG(@"naviBarBgRGB -> %@", naviBarBgRGB);
    UIColor *c = [DSImage navigationBarTintColorFromRed:[[naviBarBgRGB objectAtIndex:0] floatValue]
                                                  green:[[naviBarBgRGB objectAtIndex:1] floatValue]
                                                   blue:[[naviBarBgRGB objectAtIndex:2] floatValue]];
    
        _navigationBarBackgroundImage = [DSImage rectangleWithSize:CGSizeMake(1.0, 1.0) fillColor:c];
//    }
    return _navigationBarBackgroundImage;
}



- (void)applyGlobalNavigationBarStyle{
    
    [[UINavigationBar appearance] setBackgroundImage:self.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    if ([DSDeviceUtil iOS8AndAbove]) {
        [[UINavigationBar appearance] setTranslucent:YES];
    }
    
    [[UINavigationBar appearance] setTintColor:[self colorForKey:@"navigation-bar-button-title"]];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [self colorForKey:@"navigation-bar-title"],NSForegroundColorAttributeName,
                                               [UIFont systemFontOfSize:20], NSFontAttributeName,
                                               nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}

- (void)applyGlobalStyle{
    //UIBarButtonItem
    [[UIBarButtonItem appearance] setTitleTextAttributes:
                                    @{
                                      NSFontAttributeName:[UIFont systemFontOfSize:18]
                                      } forState:UIControlStateNormal];
    
    [[UITextField appearance] setTintColor:[self colorForKey:@"input-cursor"]];
    [[UITextView appearance] setTintColor:[self colorForKey:@"input-cursor"]];
    [[UITextField appearance] setFont:[UIFont systemFontOfSize:16]];
    [[UITextView appearance] setFont:[UIFont systemFontOfSize:16]];
    
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

@end



