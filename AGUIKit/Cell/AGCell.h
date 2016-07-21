//
//  AGFormInput.h
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AGRemoter.h"

@class AGVCConfiguration;
@class AGObjectPool;

@interface AGCell : UITableViewCell <AGRemoterDelegate>{
//    CGFloat paddingLR;
//    CGFloat paddingTB;
//    AGRemoter *remoter;
}


- (void)didTapCell;
- (void)didSetValue:(id)value;
- (void)layout;

#pragma mark - dispatchers
- (void)reload;
- (void)setValueForViewController:(id)value;
- (NSArray *)parametersFromViewController;
- (void)sendActionRequestToViewController:(id)action;


#pragma mark - assemblers
- (void)assembleGC;
- (void)activateSelector;
- (UIView *)borderViewInstance;

#pragma mark - view controller actions
- (void)pushViewController:(UIViewController *)viewController fromNaviC:(UINavigationController *)naviC;
- (void)pushViewController:(UIViewController *)viewController;

#pragma mark - styles
- (void)applySelectedStyle;
- (void)applyUnselectedStyle;

#pragma mark - properties

- (AGVCConfiguration *)config;
- (UITableView *)tableView;
- (BOOL)isCachedValueSameAsTargetValue:(id)targetValue;
- (BOOL)isContentViewLoaded;
- (BOOL)isContentViewBlank;

#pragma mark - styles

+ (CGFloat)height;
+ (CGFloat)heightOfValue:(id)value;
- (CGFloat)paddingLR;
- (CGFloat)paddingTB;
- (UIColor *)borderColor;
- (CGFloat)borderWidth;




@property (nonatomic, assign) CGFloat height;



#pragma mark - 

- (void)endEditingForAssociatedView;
- (void)reloadAssociatedViewController;

#pragma mark - layout ops
- (void)layoutBorderBottomViewStyleSolid;


@property (nonatomic, strong) AGObjectPool *objPool;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isOptional;
@property (nonatomic, assign) BOOL isLastRow;
@property (nonatomic, assign) BOOL isFirstRow;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) NSString *tipMsg;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) id value;
@property (nonatomic, weak) id ws;

@property (nonatomic, weak) id associatedViewController;



@property (nonatomic, strong) AGRemoter *remoter;


@property (nonatomic, strong) UIView *backgroundViewStyleBlock;
@property (nonatomic, strong) UIView *borderTopViewStyleBlock;
@property (nonatomic, strong) UIView *borderBottomViewStyleBlock;
@property (nonatomic, strong) UIView *borderLeftViewStyleBlock;
@property (nonatomic, strong) UIView *borderRightViewStyleBlock;
@property (nonatomic, strong) UIView *borderTopViewStyleSolid;
@property (nonatomic, strong) UIView *borderBottomViewStyleSolid;
//@property (nonatomic, strong) UIView *borderBottomViewStylePaddingLR;
@property (nonatomic, strong) UIView *borderBottomViewStylePaddingL;


@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) id obUIKeyboardWillChangeFrameNotification;


@end
