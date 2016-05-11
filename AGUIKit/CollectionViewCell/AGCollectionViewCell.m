//
//  AGCollectionViewCell.m
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCollectionViewCell.h"
#import "AGRemoter.h"
#import "DSValueUtil.h"

@interface AGCollectionViewCell() <AGRemoterDelegate>

@end

@implementation AGCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc{
    [_remoter cancelAllRequests];
}

- (AGRemoter *)remoter{
    if (!_remoter) {
        _remoter = [AGRemoter instanceWithDelegate:self];
    }
    return _remoter;
}

#pragma mark - AGRemoterDelegate

- (void)remoterDataReceived:(id)responseData withRequestData:(DSRequestInfo *)request{
    
}

@end
