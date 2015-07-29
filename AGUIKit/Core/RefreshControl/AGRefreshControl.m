//
//  AGLoadingView.m
//  AboveGEM
//
//  Created by traintrackcn on 4/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGRefreshControl.h"
#import "AGRefreshIndicator.h"
#import "AGViewController.h"
#import "AGTopRefreshControl.h"
#import "DSDeviceUtil.h"

@interface AGRefreshControl(){
    
}

@end

@implementation AGRefreshControl

- (id)init{
    self = [super init];
    if (self) {
        indicatorW = [[UIScreen mainScreen] bounds].size.width - 40;
        indicatorX = ([DSDeviceUtil bounds].size.width - indicatorW)/2;
        indicatorH = 24;
        factor = 2;
        [self setHidden:YES];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self assembleIndicator];
    }
    return self;
}

#pragma mark - assemblers

- (void)assembleIndicator{
    indicator = [[AGRefreshIndicator alloc] init];
    [self addSubview:indicator];
}

#pragma mark - indicator parameters

- (CGFloat)offsetY{
    return 0;
}

- (CGFloat)indicatorY{
    return 0;
}

- (CGFloat)visibleH{
    return ABS(self.offsetY);
}

- (CGFloat)pullRatio{
    return (self.visibleH/indicatorH)/factor;
}

#pragma mark -

- (void)begin{
    [self setHidden:NO];
    [self setIsTouching:YES];
}

- (void)dragging{
//    if (!self.isTouching) return;
    if (!self.isTouching && self.triggeredRefreshing) return;
    [self layout];
}

- (void)layout{
    CGFloat offsetY = self.offsetY;
    
//    TLOG(@"%@ offsetY -> %f", NSStringFromClass(self.class),offsetY);
    if (offsetY>0) {
        [self setTriggeredRefreshing:NO];
        [self setHidden:YES];
        return;
    }
    
    [self setHidden:NO];
    
    
    if (![tableView.subviews.lastObject isEqual:self]) {
        [tableView bringSubviewToFront:self];
        //        TLOG(@"reset zIndex");
    }
    

    CGFloat indicatorY = self.indicatorY;
    CGFloat pullRatio = self.pullRatio;
    
    //    TLOG(@"pullRatio -> %f", pullRatio);
    
    [indicator setFrame:CGRectMake(indicatorX, indicatorY, indicatorW, indicatorH)];
    
    //    TLOG(@"indicator frame -> %@", NSStringFromCGRect(indicator.frame));
    
    if (pullRatio > 1) pullRatio = 1;
    
    if (self.isTouching) {
        if (pullRatio < 1) {
            [indicator setTitle:@"Continue pulling to refresh"];
            [self setTriggeredRefreshing:NO];
        }else{
            [indicator setTitle:@"Release to refresh"];
            [self setTriggeredRefreshing:YES];
        }
        //        [self.tableView setContentInset:UIEdgeInsetsMake(64+44*pullRatio, 0, 0, 0)];
    }
    
    [indicator update:pullRatio];
}

- (void)end{
    [self setIsTouching:NO];
    if ([self triggeredRefreshing]) {
        [self setHidden:YES];
        [self dispatchRefreshControlRequestRefreshing];
    }
    
}

//- (void)setHidden:(BOOL)hidden{
//    [super setHidden:hidden];
//    TLOG(@"%@ -> %d", NSStringFromClass(self.class), hidden);
//}

//- (void)setIsTouching:(BOOL)isTouching{
//    _isTouching = isTouching;
//    
//    if (isTouching) {
//        [self setHidden:NO];
//    }else{
//        [self setHidden:YES];
//    }
//}




#pragma mark - properties

- (void)setDelegate:(id<AGRefreshControlDelegate>)delegate{
    _delegate = delegate;
    tableView = [(AGViewController *)_delegate tableView];
}

#pragma mark - dispatchers

- (void)dispatchRefreshControlRequestRefreshing{

    if ([self isKindOfClass:[AGTopRefreshControl class]]) {
        if (_delegate && [_delegate respondsToSelector:@selector(topRefreshControlRequestRefreshing)]) {
            [_delegate topRefreshControlRequestRefreshing];
        }
    }
    
//    if ([self isKindOfClass:[AGBottomRefreshControl class]]) {
//        if (_delegate && [_delegate respondsToSelector:@selector(bottomRefreshControlRequestRefreshing)]) {
//            [_delegate bottomRefreshControlRequestRefreshing];
//        }
//    }
    
}

@end
