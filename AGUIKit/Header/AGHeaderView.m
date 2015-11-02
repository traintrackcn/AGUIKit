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
#import "GlobalDefine.h"
#import "AGUIDefine.h"
#import "NSObject+Singleton.h"

@implementation AGHeaderView


- (void)setAssociatedViewController:(id)associatedViewController{
    _associatedViewController = associatedViewController;
//    TLOG(@"associatedViewController -> %@", associatedViewController);
}

#pragma mark - view controller actions

- (void)pushViewController:(UIViewController *)viewController fromNaviC:(UINavigationController *)naviC{
    AGViewController *vc = self.associatedViewController;
    //    TLOG(@"vc -> %@", vc);
    [vc.view endEditing:YES];
    [naviC pushViewController:viewController animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController{
    UINavigationController *naviC = (UINavigationController *)[[self associatedViewController] parentViewController ];
    //    TLOG(@"naviC -> %@", naviC);
    if (naviC){
        [self pushViewController:viewController fromNaviC:naviC];
    }else{
        [self pushViewController:viewController fromNaviC:[AGUIDefine singleton].rootViewController];
    }
    
}

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
    if ([self.associatedViewController isKindOfClass:[AGViewController class]]) {
        return [(AGViewController *)self.associatedViewController tableView];
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

- (CGFloat)height{
    if (_height) return _height;
    return [self.class height];
}

@end
