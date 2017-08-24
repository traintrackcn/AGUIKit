//
//  UIView+Borders.m
//  AGUIKit
//
//  Created by Tao Yunfei on 24/08/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import "UIView+HeaderAndCell.h"
#import "NSObject+ObjPool.h"
#import "GlobalDefine.h"
#import "AGObjectPool.h"
#import "DSDeviceUtil.h"
#import "AGStyleCoordinator.h"
#import "AGViewController.h"

@implementation UIView (HeaderAndCell)

- (UIView *)backgroundViewStyleBlock{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = [DSDeviceUtil bounds].size.width - self.paddingLR*2;
        CGFloat h = self.height;
        item = [[UIView alloc] init];
        [item setFrame:CGRectMake(x, y, w, h)];
    }
    return item;
}

- (UIView *)borderTopViewStyleBlock{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        CGFloat x = self.paddingLR;
        CGFloat w = [DSDeviceUtil bounds].size.width-x*2;
        item = [[UIView alloc] initWithFrame:CGRectMake(x, -1, w, 1)];
        [item setBackgroundColor:self.borderColor];
    }
    return item;
}



- (UIView *)borderBottomViewStyleBlock{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        CGFloat x = self.paddingLR;
        CGFloat w = [DSDeviceUtil bounds].size.width-x*2;
        item = [[UIView alloc] initWithFrame:CGRectMake(x, [self.class height] - 1, w, 1)];
        [item setBackgroundColor:self.borderColor];
    }
    
    return item;
}

- (UIView *)borderLeftViewStyleBlock{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        CGFloat x= self.paddingLR;
        item = [[UIView alloc] initWithFrame:CGRectMake(x, 0, self.borderWidth, [self.class height])];
        [item setBackgroundColor:self.borderColor];
        //        [AGDebugUtil makeBorderForView:_borderLeftViewStyleBlock];
    }
    
    return item;
}

- (UIView *)borderRightViewStyleBlock{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        CGFloat x = [DSDeviceUtil bounds].size.width-self.paddingLR-self.borderWidth;
        item = [[UIView alloc] initWithFrame:CGRectMake(x, 0, self.borderWidth, [self.class height])];
        [item setBackgroundColor:self.borderColor];
        
    }
    
    return item;
}


//solid

- (UIView *)borderTopViewStyleSolid{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [self borderViewInstance];
        CGRect frame = CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, self.borderWidth);
        [item setFrame:frame];
    }
    return item;
}

- (UIView *)borderBottomViewStyleSolid{
    
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        CGRect frame = CGRectMake(0, self.height - self.borderWidth, [DSDeviceUtil bounds].size.width, self.borderWidth);
        item = [self borderViewInstance];
        [item setFrame:frame];
    }
    
    return item;
}

- (UIView *)borderBottomViewStylePaddingLR{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [self borderViewInstance];
        CGFloat y = self.height - self.borderWidth;
        CGFloat x = self.paddingLR;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat h = self.borderWidth;
        CGRect frame = CGRectMake(x, y, w, h);
        [item setFrame:frame];
    }
    
    return item;
}

- (UIView *)borderBottomViewStylePaddingL{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIView *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [self borderViewInstance];
        CGFloat y = self.height - self.borderWidth;
        CGFloat x = self.borderPaddingL;
        CGFloat w = STYLE_DEVICE_WIDTH - x;
        CGFloat h = self.borderWidth;
        CGRect frame = CGRectMake(x, y, w, h);
        [item setFrame:frame];
    }
    
    return item;
}

- (UIView *)borderViewInstance{
    UIView *borderView = [[UIView alloc] init];
    [borderView setBackgroundColor:self.borderColor];
    return borderView;
}

#pragma mark - components

- (UITapGestureRecognizer *)tapGestureRecognizer{
    NSString *key = CURRENT_FUNCTION_NAME;
    UITapGestureRecognizer *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAny:)];
    }
    //    TLOG(@"_tapGestureRecognizer -> %@", _tapGestureRecognizer);
    return item;
}

#pragma mark - interactive ops

- (void)didTapAny:(id)sender{

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

#pragma mark - dispatchers

- (void)sendActionRequestToViewController:(id)action{
    [self.associatedViewController cellRequestAction:action atIndexPath:self.indexPath];
}

#pragma mark - properties


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

- (CGFloat)paddingTB{
    return 6.0;
}

- (CGFloat)height{
    return 0;
}

- (CGFloat)borderWidth{
    return .5f;
}

- (UIColor *)borderColor{
    return COLOR(AG_UI_DEFINE.RGB_BORDER);
}

- (CGFloat)borderPaddingL{
    return self.paddingLR;
}

@end
