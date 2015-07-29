//
//  AGLabel.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGLabel.h"

@implementation AGLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    CGFloat padding = 8.0;
    UIEdgeInsets insets = {0, padding, 0, padding};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
