//
//  AGHeader.h
//  AboveGEM
//
//  Created by traintrackcn on 21/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGHeaderView : UIView{

}

#pragma mark - interactive ops

- (void)didTap:(id)sender;

#pragma mark - dispatchers

- (void)sendActionRequestToViewController:(id)action;

#pragma mark - view controller actions
- (void)pushViewController:(UIViewController *)viewController fromNaviC:(UINavigationController *)naviC;
- (void)pushViewController:(UIViewController *)viewController;

#pragma mark - components
@property (nonatomic, strong) UIView *borderBottomView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

#pragma mark - styles
+ (CGFloat)height;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat paddingLR;

#pragma mark - properties
- (UITableView *)tableView;
@property (nonatomic, weak) id associatedViewController;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) id value;

@end
