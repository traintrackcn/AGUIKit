//
//  AGCellStyleDefine.m
//  AGUIKit
//
//  Created by Tao Yunfei on 12/2/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGCellStyleDefine.h"
#import "AGStyleCoordinator.h"

@implementation AGCellStyleDefine

- (UIColor *)backgroundColorHighlight{
    if (_backgroundColorHighlight) return _backgroundColorHighlight;
    return [AGStyleCoordinator colorForKey:@"cell-background-selected"];
}

- (UIColor *)backgroundColorNormal{
    if (_backgroundColorNormal) return _backgroundColorNormal;
    return [AGStyleCoordinator colorForKey:@"cell-background-unselected"];
}

@end
