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

@property (nonatomic, strong) UIView *circleView;

@end

@implementation AGPortraitView

@synthesize borderColor = _borderColor;

+ (instancetype)instanceWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    AGPortraitView *instance = [[AGPortraitView alloc] initWithFrame:frame borderColor:borderColor borderWidth:borderWidth];
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBorderColor:borderColor];
        [self setBorderWidth:borderWidth];
        [self assemble];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self assemble];
    }
    return self;
}

#pragma mark -

- (void)assemble{
    [self addSubview:self.circleView];
    [self addSubview:self.imageView];
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    if (_circleView){
        [_circleView setBackgroundColor:borderColor];
    }
}

#pragma mark - properties

- (UIImageView *)imageView{
    if (!_imageView) {
        TLOG(@"self.borderWidth -> %f", self.borderWidth);
        CGFloat x = self.borderWidth;
        CGFloat y = x;
        CGFloat w = self.frame.size.width - x*2;
        CGFloat h = w;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView.layer setCornerRadius:w/2.0];
        [_imageView setClipsToBounds:YES];
//        _imageView.layer.borderWidth = 1;
//        CGFloat r = w/2.0;
//        [AGStyleCoordinator decorateCircleMaskForView:_imageView radius:r];
        
//        [AGDebugUtil makeBorderForView:_imageView];
    }
    return _imageView;
}

- (UIView *)circleView{
    if (!_circleView) {
        CGFloat x = 0;
        CGFloat y = x;
        CGFloat w = self.frame.size.width;
        CGFloat h = w;
        _circleView = [[UIView alloc] init];
        
        CGRect frame = CGRectMake(x, y, w, h);
        [_circleView setFrame:frame];
        [_circleView setClipsToBounds:YES];
        [_circleView.layer setCornerRadius:w/2];
        [_circleView setBackgroundColor:_borderColor];
    }
    return _circleView;
}



#pragma mark - styles

- (UIColor *)borderColor{
    if (_borderColor) return _borderColor;
    return RGBA(138, 123, 119, 1);
}

- (CGFloat)borderWidth{
    if (_borderWidth) return _borderWidth;
    return 0;
}


@end
