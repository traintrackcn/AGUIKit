//
//  AGFormBaseViewController.h
//  AboveGEM
//
//  Created by traintrackcn on 16/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import Foundation;
@import UIKit;

enum{
    SectionDummy = NSIntegerMin
};

typedef NS_ENUM(NSInteger, SectionDummyCell){
    SectionDummyCellLoginUI = NSIntegerMin
};

#import "AGVCConfiguration.h"
#import "AGObjectPool.h"

@class AGCell;
@class AGRemoterResultError;


@interface AGViewController : UITableViewController{
    
    CGFloat animationDuration;
    AGCell *dummyCell; //for retaining instance
}



+ (instancetype)instance;

#pragma mark - associated cell ops
- (void)setValueForAssociatedIndexPath:(id)value;
- (void)setNeedsReloadAssociatedIndexPath;
//- (void)reloadAssociatedIndexPath;


#pragma mark - transfer to other views

- (UINavigationController *)defaultNavigationController;
- (void)pushViewController:(AGViewController *)viewController;
//- (void)presentViewController:(AGViewController *)viewController;


#pragma mark - view lifecycle
- (void)willReloadVisibleIndexPaths;
- (void)reloadVisibleIndexPaths;
- (void)reloadIndexPath:(NSIndexPath *)indexPath;
- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated;
- (void)didReloadVisibleIndexPaths;
- (void)willDoReload;

#pragma mark - table view stuff

- (UIView *)headerOfSection:(NSInteger)section;
- (id)valueForHeaderOfSection:(NSInteger)section;
- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
- (id)valueAtIndexPath:(NSIndexPath *)indexPath;
- (id)titleAtIndexPath:(NSIndexPath *)indexPath;
- (AGCell *)cellAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

#pragma mark - component

- (void)enableOverlay:(BOOL)enabled;
- (AGCell *)dummyCellInstanceAtIndex:(NSInteger)index;
- (void)addOverlay:(UIView *)view;
- (UIView *)overlayWithTag:(NSInteger)tag;
- (UIView *)overlayContainer;
- (void)addExternalView:(UIView *)view;

#pragma mark -

- (BOOL)cacheEveryCell;

#pragma mark - error handlers
- (BOOL)setRemoteMessagesForError:(id)error;


#pragma mark - dummy cell stuff
- (void)pushViewController:(AGViewController *)viewController fromDummyCellAtIndex:(NSInteger)index;

#pragma mark - cell request
- (void)cellRequestReloadIndexPath:(NSIndexPath *)indexPath;
- (void)cellRequestSetValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
- (id)cellRequestParameterAtIndexPath:(NSIndexPath *)indexPath;
- (void)cellRequestAction:(id)action atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) id ws;
@property (nonatomic, copy) NSIndexPath *associatedIndexPath;
@property (nonatomic, strong) AGVCConfiguration *config;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, assign) BOOL flagDoReload;

@property (nonatomic, weak) AGViewController *previousViewController;
@property (nonatomic, strong) AGObjectPool *objPool;
@property (nonatomic, strong) UIView *dummyHeaderView;




@end
