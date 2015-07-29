//
//  AGButton.m
//  AboveGEM
//
//  Created by Tao Yunfei on 5/4/15.
//
//

#import "AGButton.h"
#import "AGStyleCoordinator.h"
#import "GlobalDefine.h"
#import "DSImage.h"

@implementation AGButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self.layer setCornerRadius:4.0];
        [self setClipsToBounds:YES];
        [self.titleLabel setFont:[AGStyleCoordinator fontButton]];
        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
//        [AGDebugUtil makeBorderForView:self];
        [self setEnabled:YES];
        
    }
    return self;
}


- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    
    UIControlState state = self.state;
    [self setTitleColor:[self titleColorForState:state] forState:UIControlStateNormal];
    [self setBackgroundImage:[self backgroundImageForState:state] forState:UIControlStateNormal];
    
}

#pragma mark - properties



- (UIColor *)titleColorForState:(UIControlState)state{
    UIColor *color = [UIColor blackColor];
    
    if (state == UIControlStateDisabled) {
        color = RGBA(153, 153, 153, 1);
    }
    
    if (state == UIControlStateNormal) {
        color = [AGStyleCoordinator colorButtonTitleNormal];
    }
    
    return color;
}


- (UIImage *)backgroundImageForState:(UIControlState)state{
    
//    TLOG(@"state -> %d", state);
    
    
    UIImage *img = [[UIImage alloc] init];
    
    if (state == UIControlStateDisabled) {
        img = [DSImage rectangleWithSize:CGSizeMake(1, 1) fillColor:RGBA(217, 217, 217, 1)];
    }
    
    if (state == UIControlStateNormal) {
        img = [DSImage rectangleWithSize:CGSizeMake(1, 1) fillColor:[AGStyleCoordinator colorTheme]];
    }
    
    return img;
    
}

@end
