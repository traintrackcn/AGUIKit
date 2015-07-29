//
//  AGPortraitView.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/10/15.
//
//

#import "AGPortraitView.h"
#import "GlobalDefine.h"
#import "DSImage.h"
#import "AGStyleCoordinator.h"

@interface AGPortraitView(){
    
}

@property (nonatomic, strong) UIImageView *circleView;

@end

@implementation AGPortraitView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self assemble];
    }
    return self;
}

- (void)assemble{
    [self addSubview:self.circleView];
    [self addSubview:self.imageView];
}

#pragma mark - properties

- (UIImageView *)imageView{
    if (!_imageView) {
        CGFloat x = self.borderWidth;
        CGFloat y = x;
        CGFloat w = self.frame.size.width - x*2;
        CGFloat h = w;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        CGFloat r = w/2.0;
        [AGStyleCoordinator decorateCircleMaskForView:_imageView radius:r];
        
//        [AGDebugUtil makeBorderForView:_imageView];
    }
    return _imageView;
}

- (UIImageView *)circleView{
    if (!_circleView) {
        CGFloat x = 0;
        CGFloat y = x;
        CGFloat w = self.frame.size.width;
        CGFloat h = w;
        _circleView = [[UIImageView alloc] initWithImage:self.circleImageInstance];
        
        CGRect frame = CGRectMake(x, y, w, h);
        [_circleView setFrame:frame];
        
//        [AGDebugUtil makeBorderForView:_circleView];
    }
    return _circleView;
}

- (UIImage *)circleImageInstance{
    CGFloat w = self.frame.size.width;
    CGFloat h = w;
    UIImage *circleImage = [DSImage circleWithSize:CGSizeMake(w, h) fillColor:self.borderColor];
    return circleImage;
}

#pragma mark - styles

- (UIColor *)borderColor{
    return RGBA(138, 123, 119, 1);
}

- (CGFloat)borderWidth{
    return 0;
}


@end
