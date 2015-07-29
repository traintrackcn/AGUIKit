//
//  AGTopRefreshControl.m
//  AboveGEM
//
//  Created by traintrackcn on 4/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTopRefreshControl.h"
#import "AGRefreshIndicator.h"
#import "AGViewController.h"

@interface AGTopRefreshControl(){
}

@end

@implementation AGTopRefreshControl


- (CGFloat)offsetY{
//    TLOG(@"tableView.contentOffset.y -> %f tableView.contentInset.top -> %f", tableView.contentOffset.y, tableView.contentInset.top);
    return tableView.contentOffset.y+tableView.contentInset.top;
}

- (CGFloat)indicatorY{
//    CGFloat visibleH = ABS(self.offsetY);
    return (- indicatorH - self.visibleH)/2.0 ;
}

- (CGFloat)pullRatio{
//    CGFloat visibleH = ABS(self.offsetY);
    return (self.visibleH/indicatorH)/factor;
}




@end
