//
//  AGFormLabelUnit.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTextfieldCellStyleOptions.h"
#import "AGLabel.h"
#import "DSValueUtil.h"
#import "AGStyleCoordinator.h"


@interface AGTextfieldCellStyleOptions(){
    
}

@end

@implementation AGTextfieldCellStyleOptions


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self assemble];
    }
    return self;
}


#pragma mark - assemblers

- (void)assemble{
//    [self assembleTitleContainer];
    [self assembleTitleView];
    [self assembleContentLabel];
//    [self assembleArrow];
    [self assembleGC];
    [self assembleBottomBorder];
}

- (void)assembleContentLabel{
    if ([DSValueUtil isAvailable:contentLabel]) return;
    CGFloat x = self.frame.size.width / 3.0;
    CGFloat w = self.frame.size.width - x - 24.0;
    contentLabel = [[AGLabel alloc] initWithFrame:CGRectMake(x, 0, w, [self.class height])];
//    [contentLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [contentLabel setTextColor:[AGStyleCoordinator colorTextfieldContent]];
    [contentLabel setTextAlignment:NSTextAlignmentRight];
    [contentLabel setFont:[AGStyleCoordinator fontWithSize:16]];
    [self.contentView addSubview:contentLabel];
}



- (void)setValue:(id)value{
    [super setValue:value];
    [contentLabel setText:[DSValueUtil toString:value]];
}

#pragma mark -
- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutContentLabel];
}

- (void)layoutContentLabel{
    [contentLabel setFrame:self.inputFieldFrame];
}

@end
