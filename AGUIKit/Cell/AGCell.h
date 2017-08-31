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
#import "UIView+HeaderAndCell.h"
#import "GlobalDefine.h"

@class AGVCConfiguration;
@class AGObjectPool;

@interface AGCell : UITableViewCell <AGRemoterDelegate>{
//    CGFloat paddingLR;
//    CGFloat paddingTB;
//    AGRemoter *remoter;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath;

- (void)_setValue:(id)value;
- (void)_setTitle:(id)title;

- (void)didSetValue:(id)value;
- (void)layout;

#pragma mark - dispatchers
- (void)reload;
- (void)setValueForViewController:(id)value;
- (NSArray *)parametersFromViewController;
//- (void)sendActionRequestToViewController:(id)action;


#pragma mark - interactive ops
- (void)assembleGC DEPRECATED_WITH_MSG("Use [self.contentView addGestureRecognizer:self.tapGestureRecognizer] instead");
- (void)activateSelector DEPRECATED_WITH_MSG("Use [self didTapAny:] instead");
- (void)didTapCell DEPRECATED_WITH_MSG("Use [self didTapAny:] instead");



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

//- (CGFloat)borderPaddingL;
//- (CGFloat)paddingTB;
//- (UIColor *)borderColor;
//- (CGFloat)borderWidth;

#pragma mark - 
- (void)endEditingForAssociatedView;
- (void)reloadAssociatedViewController;

@property (nonatomic, assign) CGFloat height;
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
//@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) id obUIKeyboardWillChangeFrameNotification;


@end
