//
//  AGFormAddressCell.m
//  AboveGEM
//
//  Created by traintrackcn on 15/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTitleCell.h"
#import "AGLabel.h"
#import "AGStyleCoordinator.h"

@implementation AGTitleCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        paddingLR = 15.0;
        [self assemble];
    }
    return self;
}

#pragma mark - assemblers

- (void)assemble{
    [self assembleContentLabel];
}

- (void)assembleContentLabel{
    contentLabel = [[AGLabel alloc] initWithFrame:CGRectMake(self.paddingLR, 28, self.frame.size.width - self.paddingLR*2, [AGTitleCell height] - 28 - self.paddingTB)];
    [contentLabel setFont:self.contentFont];
    [self addSubview:contentLabel];
}

- (void)setValue:(id)value{
    [super setValue:value];
}

#pragma mark - styles

- (UIFont *)contentFont{
    return [UIFont systemFontOfSize:16];
}

- (CGFloat)paddingLR{
    return 15.0;
}

@end
