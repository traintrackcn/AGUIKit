//
//  AGHeaderViewDefault.m
//  AboveGEM
//
//  Created by traintrackcn on 6/11/14.
//
//

#import "AGHeaderViewStyleDefault.h"
#import "AGStyleCoordinator.h"
#import "DSValueUtil.h"

@implementation AGHeaderViewStyleDefault

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self assemble];
        [self setBackgroundColor:[AGStyleCoordinator colorHeaderViewBackground]];
    }
    return self;
}

#pragma mark - assemblers

- (void)assemble{
    [self addSubview:self.titleLabel];
    [self addSubview:self.borderBottomView];
}

#pragma mark - setters

- (void)setValue:(id)value{
    [super setValue:value];
    if ([DSValueUtil isAvailable:value]){
        [self.titleLabel setText:[DSValueUtil toString:value]];
    }
}

#pragma mark - components

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        CGFloat x = self.paddingLR;
        CGFloat w = self.frame.size.width - self.paddingLR * 2;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w, [self.class height])];
        [_titleLabel setTextColor:self.titleColor];
        [_titleLabel setFont:[AGStyleCoordinator fontHeaderViewTitle]];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
//        [self addSubview:titleLabel];
    }
    return _titleLabel;
}

#pragma mark - styles

- (CGFloat)paddingLR{
    return 15.0;
}

- (UIColor *)titleColor{
    return [AGStyleCoordinator colorLightText];
}

@end
