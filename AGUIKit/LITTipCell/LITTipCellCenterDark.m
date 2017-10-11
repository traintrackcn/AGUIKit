//
//  LITTipCellCenterDark.m
//  AboveGEM
//
//  Created by Tao Yunfei on 21/09/2017.
//
//

#import "LITTipCellCenterDark.h"
#import "AGUIDefine.h"

@implementation LITTipCellCenterDark

- (NSTextAlignment)valueAlignment{
    return NSTextAlignmentCenter;
}

- (UIFont *)valueFont{
    return FONT_WITH_SIZE(15);
}

- (UIColor *)valueColor{
    return COLOR(RGB_TITLE);
}

- (CGFloat)paddingTB{
    return 18.0;
}

@end
