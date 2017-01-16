//
//  AGViewController+ButtonComponents.m
//  Distributors
//
//  Created by Tao Yunfei on 1/6/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGViewController+ButtonComponents.h"
//#import "AGObjectPool.h"
#import "DAButtonFactory.h"
#import "AGUIDefine.h"

#define KEY_BOTTOM_BUTTON_INSTANCE @"KEY_BOTTOM_BUTTON_INSTANCE"

@implementation AGViewController (ButtonComponents)

- (UIButton *)bottomButtonWithTitle:(NSString *)title action:(SEL)action{
    NSString *key = KEY_BOTTOM_BUTTON_INSTANCE;
    UIButton *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [DAButtonFactory buttonInstanceWithTitle:title target:self action:action backgroundColor:nil];
        [self.objPool setObject:item forKey:key];
//        [self layoutBottomButton];
    }
    return item;
}

- (UIButton *)bottomButton{
    UIButton *item = [self.objPool objectForKey:KEY_BOTTOM_BUTTON_INSTANCE];
    return item;
}

- (void)layoutBottomButtonWithTabBar{
    CGFloat h = 44.0;
    CGFloat x = self.paddingLR;
    CGFloat w = STYLE_DEVICE_WIDTH - x*2;
    CGFloat y = STYLE_DEVICE_HEIGHT - STYLE_TAB_BAR_HEIGHT - self.paddingTB - h;
    
    if (!self.bottomButton) return;
    [self.bottomButton setFrame:CGRectMake(x, y, w, h)];
    [self layoutTableViewForBottomButton];
}


- (void)layoutBottomButton{
    CGFloat h = 44.0;
    CGFloat x = self.paddingLR;
    CGFloat w = STYLE_DEVICE_WIDTH - x*2;
    CGFloat y = STYLE_DEVICE_HEIGHT - self.paddingTB - h;
    
    if (!self.bottomButton) return;
    [self.bottomButton setFrame:CGRectMake(x, y, w, h)];
    [self layoutTableViewForBottomButton];
}

- (void)layoutTableViewForBottomButton{
    UITableView *tv = self.tableView;
    UIEdgeInsets edgeInsets = tv.contentInset;
    //    [self.tableView setFrame:CGRectMake(tv.frame.origin.x, tv.frame.origin.y, tv.frame.size.width, tv.frame.size.height-44.0)];
    CGFloat bottom = 44 + self.paddingTB*2;
    [self.tableView setContentInset:UIEdgeInsetsMake(edgeInsets.top, edgeInsets.left, bottom, edgeInsets.right)];
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (CGFloat)paddingTB{
    return 16.0;
}

@end
