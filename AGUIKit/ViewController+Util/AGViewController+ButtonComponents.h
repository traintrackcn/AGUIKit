//
//  AGViewController+ButtonComponents.h
//  Distributors
//
//  Created by Tao Yunfei on 1/6/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGViewController.h"

@interface AGViewController (ButtonComponents)

- (UIButton *)bottomButtonWithTitle:(NSString *)title action:(SEL)action;
- (UIButton *)bottomButton;
- (void)layoutBottomButtonWithTabBar;
- (void)layoutBottomButton;

@end
