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

@protocol AGCellDelegate <NSObject>

@required
- (void)cellRequestReloadIndexPath:(NSIndexPath *)indexPath;
- (void)cellRequestSetValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
- (void)cellRequestAction:(id)action atIndexPath:(NSIndexPath *)indexPath;
- (id)cellRequestParameterAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface AGCell : UITableViewCell <AGRemoterDelegate>{
//    CGFloat paddingLR;
//    CGFloat paddingTB;
//    AGRemoter *remoter;
}


- (void)didTapCell;


#pragma mark - dispatchers
- (void)dispatchRequestReloadIndexPath;
//- (void)dispatchRequestSetCurrentIndexPath;
- (void)dispatchRequestSetValue:(id)value;
//- (id)dispatchRequestValue;
- (id)dispatchRequestParameters;
- (NSArray *)parameters;
- (void)dispatchRequestAction:(id)action;


#pragma mark - assemblers
- (void)assemble;
- (void)assembleGC;
- (void)assembleBottomBorder;
- (void)activateSelector;
- (UIView *)assembleBorderView;
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

#pragma mark - styles

+ (CGFloat)height;
@property (nonatomic, assign) CGFloat height;

- (CGFloat)paddingLR;
- (CGFloat)paddingTB;
- (UIColor *)borderColor;
- (CGFloat)borderWidth;

#pragma mark - 

- (void)endEditingForAssociatedView;

#pragma mark - layout ops
- (void)layoutBorderBottomViewStyleSolid;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isOptional;
@property (nonatomic, assign) BOOL isLastRow;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) NSString *tipMsg;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) id value;

@property (nonatomic, weak) id associatedViewController;



@property (nonatomic, strong) AGRemoter *remoter;


@property (nonatomic, strong) UIView *backgroundViewStyleBlock;
@property (nonatomic, strong) UIView *borderTopViewStyleBlock;
@property (nonatomic, strong) UIView *borderBottomViewStyleBlock;
@property (nonatomic, strong) UIView *borderLeftViewStyleBlock;
@property (nonatomic, strong) UIView *borderRightViewStyleBlock;
@property (nonatomic, strong) UIView *borderTopViewStyleSolid;
@property (nonatomic, strong) UIView *borderBottomViewStyleSolid;
@property (nonatomic, strong) UIView *borderBottomViewStylePaddingLR;





@end
