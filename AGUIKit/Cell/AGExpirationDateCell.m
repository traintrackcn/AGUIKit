//
//  AGFormExpirationDateCell.m
//  AboveGEM
//
//  Created by traintrackcn on 15/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGExpirationDateCell.h"
#import "AGExpirationDateSelector.h"
#import "NSObject+Singleton.h"
#import "NSDate+AGUtils.h"

@implementation AGExpirationDateCell

- (void)activateSelector{
    [self endEditingForAssociatedView];
    NSDate *value = [self value];
    AGExpirationDateSelector *picker = [AGExpirationDateSelector singleton];
    [picker setTitle:@"Select Expiration Date"];
    [picker setAssociatedCell:self];
    [picker setContentView:[picker contentViewWithValue:value]];
    [self pushViewController:picker];
}

- (void)setValue:(id)value{
    [super setValue:value];
    NSDate *d = (NSDate *)value;
    [contentLabel setText:d.textStyleDefault];
}

@end
