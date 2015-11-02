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

#pragma mark - view controller actions
- (void)pushViewController:(UIViewController *)viewController fromNaviC:(UINavigationController *)naviC;
- (void)pushViewController:(UIViewController *)viewController;

#pragma mark - components
- (UITableView *)tableView;
@property (nonatomic, strong) UIView *borderBottomView;

#pragma mark - styles
+ (CGFloat)height;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat paddingLR;

#pragma mark - properties
@property (nonatomic, weak) id associatedViewController;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) id value;

@end
