//
//  AGPeriodCell.m
//  AboveGEM
//
//  Created by traintrackcn on 12/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGPeriodCell.h"
#import "AGPeriodSelector.h"
#import "GlobalDefine.h"
#import "DSValueUtil.h"

@interface AGPeriodCell(){
    AGPeriodSelector *picker;
}

@end

@implementation AGPeriodCell

- (void)activateSelector{
    NSDate *value = [self value];
//    TLOG(@"value -> %@", value);
    
    id collection = [self dispatchRequestParameters];

    if ([DSValueUtil isNotAvailable:picker]) {
        picker = [[AGPeriodSelector alloc] init];
    }
    [picker setTitle:@"Select Date"];
    [picker setCollection:collection];
    [picker setAssociatedCell:self];
    [picker setContentView:[picker contentViewWithValue:value]];
    [self pushViewController:picker];
//    self pushViewController:picker fromNaviC:[AGroo]
}

- (void)setValue:(id)value{
    [super setValue:value];
    [contentLabel setText:value];
}

@end
