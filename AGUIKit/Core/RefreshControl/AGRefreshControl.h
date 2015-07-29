//
//  AGLoadingView.h
//  AboveGEM
//
//  Created by traintrackcn on 4/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGRefreshIndicator;

@protocol AGRefreshControlDelegate <NSObject>

- (void)topRefreshControlRequestRefreshing;

@end

@interface AGRefreshControl : UIView{
    AGRefreshIndicator *indicator;
    UITableView *tableView;
    
    CGFloat indicatorX;
    CGFloat indicatorW ;
    CGFloat indicatorH ;
    
    CGFloat factor; //pull visibleH*factor could activate refresh action
}

- (void)begin;
- (void)dragging;
- (void)end;
- (void)layout;

#pragma mark - indicator parameters
- (CGFloat)offsetY;
- (CGFloat)visibleH;
- (CGFloat)pullRatio;
- (CGFloat)indicatorY;

@property (nonatomic, strong) id<AGRefreshControlDelegate> delegate;
@property (nonatomic, assign) BOOL triggeredRefreshing;
@property (nonatomic, assign) BOOL isTouching;

@end
