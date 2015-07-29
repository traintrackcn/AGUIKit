//
//  AGPresentableViewController.h
//  AboveGEM
//
//  Created by Tao Yunfei on 5/7/15.
//
//

#import "AGViewController.h"

@interface AGPresentableViewController : AGViewController

+ (AGViewController *)baseViewController;
+ (BOOL)isExisted;
+ (void)presentWithDelegate:(id)delegate;

- (void)present;
- (void)presentAnimated:(BOOL)animated;
- (void)dismiss;
- (void)dismissWithCompletion:(void(^)(void))completion;
- (void)dismissAnimated:(BOOL)animated;

@end
