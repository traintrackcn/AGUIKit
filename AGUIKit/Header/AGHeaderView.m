//
//  AGHeader.m
//  AboveGEM
//
//  Created by traintrackcn on 21/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGHeaderView.h"
#import "DSDeviceUtil.h"
#import "AGStyleCoordinator.h"
#import "AGViewController.h"

@implementation AGHeaderView



#pragma mark - components

- (UIView *)borderBottomView{
    if (!_borderBottomView) {
        CGFloat x = self.paddingLR;
        CGFloat h = .5f;
        CGFloat y = [self.class height] - h;
        CGFloat w = [DSDeviceUtil bounds].size.width;
        _borderBottomView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_borderBottomView setBackgroundColor:[AGStyleCoordinator colorHeaderViewBorder]];
    }
    return _borderBottomView;
}

- (UITableView *)tableView{
    if ([self.delegate isKindOfClass:[AGViewController class]]) {
        return [(AGViewController *)self.delegate tableView];
    }
    return nil;
}

#pragma mark - styles

- (CGFloat)paddingLR{
    return 8.0;
}

+ (CGFloat)height{
    return 44.0;
}

@end
