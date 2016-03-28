//
//  AGVCGlobalDefine.m
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

#import "AGUIDefine.h"

@implementation AGUIDefine

- (NSArray *)availableLanguages{
    if (_availableLanguages) {
        return _availableLanguages;
    }
    return @[];
}

- (BOOL)sessionRoleIsRetailCustomer{
    if (self.sessionRoleIsRetailCustomerBlock) {
        return self.sessionRoleIsRetailCustomerBlock();
    }
    return YES;
}

- (NSString *)sessionRoleCode{
    if (self.sessionRoleCodeBlock){
        return self.sessionRoleCodeBlock();
    }
    return @"";
}

#pragma mark - fonts

- (NSString *)fontNameDefault{
    if (!_fontNameDefault) return @"HelveticaNeue-Light";
    return _fontNameDefault;
}

- (NSString *)fontNameLight{
    if (!_fontNameLight) return @"HelveticaNeue-Light";
    return _fontNameLight;
}

- (NSString *)fontNameMedium{
    if (!_fontNameMedium) return @"HelveticaNeue-Medium";
    return _fontNameMedium;
}

- (NSString *)fontNameBold{
    if (!_fontNameBold) return @"HelveticaNeue-Medium";
    return _fontNameBold;
}

- (NSString *)fontNameRegular{
    if (!_fontNameRegular) return @"HelveticaNeue";
    return _fontNameRegular;
}

#pragma mark - colors

- (NSString *)RGB_BORDER_DARKER{
    if (!_RGB_BORDER_DARKER) return @"213,213,213";
    return _RGB_BORDER_DARKER;
}

- (NSString *)RGB_BORDER{
    if (!_RGB_BORDER) return @"242,242,242";
    return _RGB_BORDER;
}


- (NSString *)RGB_DISABLED{
    if (!_RGB_DISABLED) return @"217,217,217";
    return _RGB_DISABLED;
}

- (NSString *)RGB_BACKGROUND_NORMAL{
    if (!_RGB_BACKGROUND_NORMAL) return self.RGB_WHITE;
    return _RGB_BACKGROUND_NORMAL;
}

- (NSString *)RGB_TAB_BAR_BACKGROUND{
    if (!_RGB_TAB_BAR_BACKGROUND) return @"246,246,246";
    return _RGB_TAB_BAR_BACKGROUND;
}

- (NSString *)RGB_TAB_BAR_NORMAL{
    if(!_RGB_TAB_BAR_NORMAL) return @"169,169,169";
    return _RGB_TAB_BAR_NORMAL;
}

- (NSString *)RGB_BACKGROUND_SELECTED{
    if (!_RGB_BACKGROUND_SELECTED) return self.RGB_THEME;
    return _RGB_BACKGROUND_SELECTED;
}

- (NSString *)RGB_THEME{
    if (!_RGB_THEME) return @"0,0,0";
    return _RGB_THEME;
}


- (NSString *)RGB_WHITE{
    return @"255,255,255";
}

@end
