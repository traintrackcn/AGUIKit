//
//  AGFormBaseViewController.h
//  AboveGEM
//
//  Created by traintrackcn on 16/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGVCConfiguration.h"
#import "AGRefreshControl.h"
#import "AGSeparatorCell.h"
#import "AGRemoter.h"

enum{
    SectionDummy = NSIntegerMin
};

typedef NS_ENUM(NSInteger, SectionDummyCell){
    SectionDummyCellLoginUI = NSIntegerMin
};

@class AGCell;
@class AGTopRefreshControl;
@class AGRemoterResultError;


@interface AGViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AGRefreshControlDelegate, AGCellDelegate,AGRemoterDelegate>{
//    AGRemoter *remoter;
    UITableView *tableV;
    AGTopRefreshControl *topRefreshControl;
    UIView *overlayContentView; //to avoid too many viewDidLayout actions
    CGFloat animationDuration;
//    NSInteger floatedMessageCount;
    
    
    AGCell *dummyCell;
//    BOOL showSeparators;
}

+ (instancetype)instance;


- (void)cancelAllRequests;

- (CGFloat)tableViewContentInsetTop;

#pragma mark - table view stuffs
- (UITableView *)tableView;


#pragma mark - associated cell ops
- (void)setValueForAssociatedCell:(id)value;



#pragma mark - view lifecycle
- (void)willReloadVisibleIndexPaths;
- (void)reloadVisibleIndexPaths;
- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated;
- (void)didReloadVisibleIndexPaths;


- (void)willDoReload;


#pragma mark - layout
//- (void)layoutTableView;
- (void)layoutViews;

#pragma mark -
- (NSString *)validateText:(NSString *)text;

- (BOOL)cacheEveryCell;

#pragma mark - error handlers
- (NSArray *)messagesOfError:(AGRemoterResultError *)error;
- (void)alertRemoteMessagesForError:(AGRemoterResultError *)error;
- (void)setRemoteMessagesForError:(AGRemoterResultError *)error;


@property (nonatomic, weak) AGCell *associatedCell;
@property (nonatomic, strong) AGVCConfiguration *config;
@property (nonatomic, assign) BOOL supportsRefreshControl;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) id userInfo;

@property (nonatomic, strong) AGRemoter *remoter;
//@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) BOOL flagDoReload;
@property (nonatomic, strong) AGViewController *previousViewController;


@end
