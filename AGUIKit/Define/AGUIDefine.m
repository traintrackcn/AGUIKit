//
//  AGVCGlobalDefine.m
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

#import "AGUIDefine.h"




#define RGB_WHITE @"255,255,255"
#define RGB_BLACK @"0,0,0"

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

#pragma mark - border colors

- (NSString *)RGB_BORDER_DARKER{
    if (!_RGB_BORDER_DARKER) return @"213,213,213";
    return _RGB_BORDER_DARKER;
}

- (NSString *)RGB_BORDER{
    if (!_RGB_BORDER) return @"242,242,242";
    return _RGB_BORDER;
}

#pragma mark - common colors

- (NSString *)RGB_DISABLED{
    if (!_RGB_DISABLED) return @"217,217,217";
    return _RGB_DISABLED;
}

- (NSString *)RGB_THEME{
    if (!_RGB_THEME) return @"0,0,0";
    return _RGB_THEME;
}

#pragma mark - background colors

- (NSString *)RGB_BACKGROUND_NORMAL{
    if (!_RGB_BACKGROUND_NORMAL) return RGB_WHITE;
    return _RGB_BACKGROUND_NORMAL;
}

- (NSString *)RGB_BACKGROUND_SELECTED{
    if (!_RGB_BACKGROUND_SELECTED) return self.RGB_THEME;
    return _RGB_BACKGROUND_SELECTED;
}


#pragma mark - title colors

- (NSString *)RGB_TITLE{
    if (!_RGB_TITLE) return @"37,37,37";
    return _RGB_TITLE;
}

- (NSString *)RGB_TITLE_NORMAL{
    if (!_RGB_TITLE_NORMAL) return @"91,91,91";
    return _RGB_TITLE_NORMAL;
}

- (NSString *)RGB_TITLE_LIGHT{
    if (!_RGB_TITLE_LIGHT) return @"153,153,153";
    return _RGB_TITLE_LIGHT;
}

- (NSString *)RGB_TITLE_LIGHTER{
    if (!_RGB_TITLE_LIGHTER) return @"169,169,169";
    return _RGB_TITLE_LIGHTER;
}

#pragma mark - tab colors

- (NSString *)RGB_TAB_BAR_BACKGROUND{
    if (!_RGB_TAB_BAR_BACKGROUND) return @"246,246,246";
    return _RGB_TAB_BAR_BACKGROUND;
}

- (NSString *)RGB_TAB_BAR_NORMAL{
    if(!_RGB_TAB_BAR_NORMAL) return @"169,169,169";
    return _RGB_TAB_BAR_NORMAL;
}


#pragma mark - cell colors

- (NSString *)RGB_CELL_TITLE_NORMAL{
    if (!_RGB_CELL_TITLE_NORMAL) return self.RGB_TITLE_NORMAL;
    return _RGB_CELL_TITLE_NORMAL;
}

- (NSString *)RGB_CELL_TITLE_HIGHLIGHT{
    if (!_RGB_CELL_TITLE_HIGHLIGHT) return RGB_WHITE;
    return  _RGB_CELL_TITLE_HIGHLIGHT;
}

- (NSString *)RGB_CELL_CONTENT_NORMAL{
    if (!_RGB_CELL_CONTENT_NORMAL) return self.RGB_TITLE_NORMAL;
    return _RGB_CELL_CONTENT_NORMAL;
}

- (NSString *)RGB_CELL_CONTENT_HIGHLIGHT{
    if (!_RGB_CELL_CONTENT_HIGHLIGHT) return RGB_WHITE;
    return _RGB_CELL_CONTENT_HIGHLIGHT;
}

- (NSString *)RGB_CELL_BACKGROUND_NORMAL{
    if (!_RGB_CELL_BACKGROUND_NORMAL) return RGB_WHITE;
    return _RGB_CELL_BACKGROUND_NORMAL;
}

- (NSString *)RGB_CELL_BACKGROUND_HIGHLIGHT{
    if (!_RGB_CELL_BACKGROUND_HIGHLIGHT) return self.RGB_THEME;
    return _RGB_CELL_BACKGROUND_HIGHLIGHT;
}

- (NSString *)RGB_CELL_BORDER{
    if (!_RGB_CELL_BORDER) return self.RGB_BORDER;
    return _RGB_CELL_BORDER;
}

#pragma mark - input

- (NSString *)RGB_INPUT_NORMAL{
    if (!_RGB_INPUT_NORMAL) return self.RGB_TITLE_NORMAL;
    return _RGB_INPUT_NORMAL;
}

- (NSString *)RGB_INPUT_STAR {
    if (!_RGB_INPUT_STAR) return @"221,48,52";
    return _RGB_INPUT_STAR;
}

- (NSString *)RGB_INPUT_TITLE {
    if (!_RGB_INPUT_TITLE) return self.RGB_TITLE_LIGHTER;
    return _RGB_INPUT_TITLE;
}

- (NSString *)RGB_INPUT_CONTENT{
    if (!_RGB_INPUT_CONTENT) return self.RGB_TITLE_NORMAL;
    return _RGB_INPUT_CONTENT;
}

- (NSString *)RGB_INPUT_CURSOR {
    if (!_RGB_INPUT_CURSOR) return self.RGB_THEME;
    return _RGB_INPUT_CURSOR;
}

- (NSString *)RGB_INPUT_ICON{
    if (!_RGB_INPUT_ICON) return self.RGB_THEME;
    return _RGB_INPUT_ICON;
}

#pragma mark - avc message

- (NSString *)RGB_AVC_SUCCESS_MESSAGE_TITLE{
    if (!_RGB_AVC_SUCCESS_MESSAGE_TITLE) return @"37,108,18";
    return _RGB_AVC_SUCCESS_MESSAGE_TITLE;
}

- (NSString *)RGB_AVC_SUCCESS_MESSAGE_BACKGROUND{
    if (!_RGB_AVC_SUCCESS_MESSAGE_BACKGROUND) return @"204,251,204";
    return _RGB_AVC_SUCCESS_MESSAGE_BACKGROUND;
}

- (NSString *)RGB_AVC_FAILURE_MESSAGE_TITLE{
    if (!_RGB_AVC_FAILURE_MESSAGE_TITLE) return @"117,55,55";
    return _RGB_AVC_FAILURE_MESSAGE_TITLE;
}

- (NSString *)RGB_AVC_FAILURE_MESSAGE_BACKGROUND{
    if (!_RGB_AVC_FAILURE_MESSAGE_BACKGROUND) return @"254,207,208";
    return _RGB_AVC_FAILURE_MESSAGE_BACKGROUND;
}

- (NSString *)RGB_AVC_LOADING_MESSAGE_TITLE{
    if (!_RGB_AVC_LOADING_MESSAGE_TITLE) return self.RGB_TITLE_LIGHTER;
    return _RGB_AVC_LOADING_MESSAGE_TITLE;
}

- (NSString *)RGB_AVC_LOADING_MESSAGE_BACKGROUND{
    if (!_RGB_AVC_LOADING_MESSAGE_BACKGROUND) return RGB_WHITE;
    return _RGB_AVC_LOADING_MESSAGE_BACKGROUND;
}

- (NSString *)RGB_FLOATING_MESSAGE_BACKGROUND{
    if (!_RGB_FLOATING_MESSAGE_BACKGROUND) return RGB_BLACK;
    return _RGB_FLOATING_MESSAGE_BACKGROUND;
}

- (NSString *)RGB_FLOATING_MESSAGE{
    if (!_RGB_FLOATING_MESSAGE) return RGB_WHITE;
    return _RGB_FLOATING_MESSAGE;
}

#pragma mark - button colors

- (NSString *)RGB_BUTTON_BACKGROUND_NORMAL{
    if (!_RGB_BUTTON_BACKGROUND_NORMAL) return @"154,24,48";
    return _RGB_BUTTON_BACKGROUND_NORMAL;
}

- (NSString *)RGB_BUTTON_TITLE_NORMAL {
    if (!_RGB_BUTTON_TITLE_NORMAL) return RGB_WHITE;
    return _RGB_BUTTON_TITLE_NORMAL;
}

- (NSString *)RGB_BUTTON_BORDER {
    if (!_RGB_BUTTON_BORDER) return self.RGB_THEME;
    return _RGB_BUTTON_BORDER;
}

#pragma mark - header colors

- (NSString *)RGB_HEADER{
    if (!_RGB_HEADER) return @"162,162,162";
    return _RGB_HEADER;
}

- (NSString *)RGB_HEADER_BORDER {
    if (!_RGB_HEADER_BORDER) return self.RGB_BORDER;
    return _RGB_HEADER_BORDER;
}

- (NSString *)RGB_HEADER_BACKGROUND {
    if (!_RGB_HEADER_BACKGROUND) return RGB_WHITE;
    return _RGB_HEADER_BACKGROUND;
}

@end
