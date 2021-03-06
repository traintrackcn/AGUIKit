//
//  AGViewController+NavigationBarButtonUtils.m
//  Distributors
//
//  Created by Tao Yunfei on 12/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "UITableViewController+NavigationBar.h"
//#import "GlobalDefine.h"
#import "AGTextCoordinator.h"
#import "AGUITextKeyDefine.h"
#import "DSImage.h"
//#import "NSObject+ObjPool.h"
//#import "AGObjectPool.h"



@implementation UITableViewController (NavigationBar)

#pragma mark -

- (void)hideNextVCBackButtonTitle{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]init];
    [barBtnItem setTitle:@""];
    self.navigationItem.backBarButtonItem = barBtnItem;
}

- (void)hideNavigationBarBackground{
    UINavigationBar *naviBar = self.navigationController.navigationBar;
    [naviBar setBackgroundImage:[UIImage new]
                  forBarMetrics:UIBarMetricsDefault];
//    [self hideNavigationBarBorder];
}

- (void)hideNavigationBarBorder{
    UINavigationBar *naviBar = self.navigationController.navigationBar;
    [naviBar setShadowImage:[UIImage new]];
}

- (void)hideNavigationBarBackgroundAndBorder{
    [self hideNavigationBarBackground];
    [self hideNavigationBarBorder];
}

- (void)setNavigationBarBorderColor:(UIColor *)borderColor{
    UIImage *img = [DSImage rectangleWithSize:CGSizeMake(1, 1) fillColor:borderColor];
    UINavigationBar *naviBar = self.navigationController.navigationBar;
    [naviBar setShadowImage:img];
}

- (void)setNextVCBackButtonWithImageNamed:(NSString *)imageName maskColor:(UIColor *)maskColor{
    
    UIImage *img = [UIImage imageNamed:imageName];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:img];
    [self.navigationController.navigationBar setBackIndicatorImage:img];
    [self.navigationController.navigationBar setTintColor:maskColor];
    
    [self hideNextVCBackButtonTitle];
}

#pragma mark - interactive ops

- (void)didTapClose:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapSend:(id)sender{
    
}

- (void)didTapSave:(id)sender{
    
}

- (void)didTapCreate:(id)sender{
    
}

- (void)didTapOK:(id)sender{
    
}

- (void)didTapUpload:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapSearch:(id)sender{
    
}

- (void)didTapSkip:(id)sender{
    
}

- (void)didTapDone:(id)sender{
    
}

- (void)didTapInvite:(id)sender{

}

#pragma mark - components


- (UIBarButtonItem *)searchBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IconSearch"] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(didTapSearch:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)uploadBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_UPLOAD) style:UIBarButtonItemStylePlain target:self action:@selector(didTapUpload:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)inviteBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IconInvite"] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(didTapInvite:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)closeBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IconClose"] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(didTapClose:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}


- (UIBarButtonItem *)sendBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_SEND) style:UIBarButtonItemStylePlain target:self action:@selector(didTapSend:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)cancelBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_CANCEL) style:UIBarButtonItemStylePlain target:self action:@selector(didTapCancel:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)saveBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_SAVE) style:UIBarButtonItemStylePlain target:self action:@selector(didTapSave:) ];
        [self.objPool setObject:item forKey:key];
    }
    return item;
    
}


- (UIBarButtonItem *)createBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IconCreate"] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(didTapCreate:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}


- (UIBarButtonItem *)okBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_OK) style:UIBarButtonItemStylePlain target:self action:@selector(didTapOK:) ];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)doneBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_DONE) style:UIBarButtonItemStylePlain target:self action:@selector(didTapDone:) ];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (UIBarButtonItem *)skipBarButtonItem{
    NSString *key = CURRENT_FUNCTION_NAME;
    UIBarButtonItem *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:TEXT(KEY_BTN_SKIP) style:UIBarButtonItemStylePlain target:self action:@selector(didTapSkip:)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

@end
