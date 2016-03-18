//
//  AGHeaderViewStyleDark.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/27/15.
//
//

#import "AGHeaderViewStyleDarkCompact.h"
#import "AGStyleCoordinator.h"
#import "GlobalDefine.h"

@interface AGHeaderViewStyleDarkCompact(){
    UILabel *_titleLabel;
}

@end

@implementation AGHeaderViewStyleDarkCompact

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[AGStyleCoordinator colorBackgroundNormal]];
//        [AGDebugUtil makeBorderForView:self];
    }
    return self;
}

- (void)assemble{
    [self addSubview:self.titleLabel];
}

#pragma mark - components

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [super titleLabel];
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_titleLabel setTextColor:RGBA(102, 102, 102, 1)];
    }
    return _titleLabel;
}

#pragma mark - styles

+ (CGFloat)height{
    return 30.0;
}

- (CGFloat)paddingLR{
    return 10.0;
}

@end
