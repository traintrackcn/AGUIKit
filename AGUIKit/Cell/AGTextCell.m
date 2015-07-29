//
//  AGFormTextCell.m
//  AboveGEM
//
//  Created by traintrackcn on 15/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTextCell.h"
#import "DSValueUtil.h"
#import "DSDeviceUtil.h"
#import "AGStyleCoordinator.h"

@interface AGTextCell(){
    UILabel *_textLabel;
    UILabel *_detailTextLabel;
}

@end

@implementation AGTextCell

+ (CGFloat)height{
    return 44.0;
}

- (CGFloat)paddingLR{
    return 16.0;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assemble];
    }
    return self;
}

- (void)assemble{
    [super assemble];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.detailTextLabel];
    [self assembleBottomBorder];
}


//#pragma mark - assemblers
#pragma mark - dynamic styles


#pragma mark -

- (void)setTitle:(NSString *)title{
    [self.textLabel setText:[DSValueUtil toString:title]];
}

- (void)setValue:(id)value{
    NSString *text = [DSValueUtil toString:value];
    [self.detailTextLabel setText:text];
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = [DSDeviceUtil bounds].size.width/2-self.paddingLR;
        CGFloat h = self.height;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_textLabel setTextColor:[AGStyleCoordinator colorCellTitleSelected]];
        [_textLabel setNumberOfLines:0];
        [_textLabel setAdjustsFontSizeToFitWidth:YES];
        [_textLabel setFont:[AGStyleCoordinator fontTextCellTitle]];
//        [AGDebugUtil makeBorderForView:_textLabel];
    }
    return _textLabel;
}

- (UILabel *)detailTextLabel{
    if (!_detailTextLabel) {
//        CGFloat w = self.textLabel.frame.size.width;
//        CGFloat x = self.textLabel.frame.origin.x + self.textLabel.frame.size.width;
//        CGFloat y = 0;
//        CGFloat h = self.height;
        _detailTextLabel = [super detailTextLabel];
        [_detailTextLabel setTextColor:[AGStyleCoordinator colorCellTitleSelected]];
        [_detailTextLabel setFont:[AGStyleCoordinator fontTextCellContent]];
        [_detailTextLabel setAdjustsFontSizeToFitWidth:YES];
        [_detailTextLabel setNumberOfLines:0];
        [_detailTextLabel setTextAlignment:NSTextAlignmentRight];
//        [AGDebugUtil makeBorderForView:_detailTextLabel];
    }
    return _detailTextLabel;
}

@end
