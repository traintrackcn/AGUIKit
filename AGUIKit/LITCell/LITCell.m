//
//  LITCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 24/08/2017.
//
//

#import "LITCell.h"
#import "AGUIDefine.h"

@implementation LITCell



#pragma mark - setters



#pragma mark - properties

- (LITCellCharacter *)character{
    return self.parametersFromViewController.firstObject;
}

#pragma mark - styles

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

@end
