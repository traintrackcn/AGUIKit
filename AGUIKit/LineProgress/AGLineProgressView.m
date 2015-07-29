//
//  AGLineProgressView.m
//  AboveGEM
//
//  Created by traintrackcn on 29/12/14.
//
//

#import "AGLineProgressView.h"
#import "AGLineProgressInnerView.h"
#import "AGLineProgressViewLabel.h"
#import "GlobalDefine.h"
#import "AGStyleCoordinator.h"
#import "NSNumber+AGUtils.h"

@interface AGLineProgressView(){
    AGLineProgressViewLabel *textLabel;
    AGLineProgressInnerView *innerView;
}

@end

@implementation AGLineProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setInnerViewBackgroundColor:RGBA(227, 137, 49, 1)];
        [self setTextColorInner:RGBA(255, 255, 255, 1)];
        [self setTextColorOuter:RGBA(127, 0, 0, 1)];
        [self setBackgroundColor:RGBA(246, 246, 246, 1)];
    }
    return self;
}

#pragma mark - assemblers

- (void)assemble{
    [self assembleInnerView];
    [self assembleTextLabel];
}

- (void)assembleInnerView{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = self.frame.size.height;
    innerView = [[AGLineProgressInnerView alloc] init];
    [self addSubview:innerView];
    
    [innerView setFrame:CGRectMake(x, y, w, h)];
    [innerView setBackgroundColor:self.innerViewBackgroundColor];
//    [textLabel setTextAlignment:NSTextAlignmentRight];
//    [AGDebugUtil makeBorderForView:innerView];
    __block AGLineProgressView *pv = self;
    [innerView setUpdateTextLabelBlock:^(CGRect frame) {
        [pv updateTextLabel];
//        TLOG(@"frame -> %@", NSStringFromCGRect(frame));
    }];
}

- (void)assembleTextLabel{
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 80;
    CGFloat h = innerView.frame.size.height;
    
    textLabel = [[AGLineProgressViewLabel alloc] init];
    [textLabel setTextColor:self.textColorInner];
    [innerView addSubview:textLabel];
    [textLabel setFrame:CGRectMake(x, y, w, h)];
//    [textLabel setBackgroundColor:self.innerViewBackgroundColor];
    [textLabel setTextAlignment:NSTextAlignmentRight];
    [textLabel setAdjustsFontSizeToFitWidth:YES];
    [textLabel setFont:[AGStyleCoordinator fontTextCellContent]];
//    [AGDebugUtil makeBorderForView:textLabel];
}

#pragma mark - 

- (CGFloat)innerViewWidth{
    return self.frame.size.width * (self.progress.doubleValue);
}

- (void)updateTextLabel{
    [textLabel setText:[NSString stringWithFormat:@"%@", [self.progress valueForPercent]]];
    
    CGRect frame = textLabel.frame;
    CGFloat targetW = self.innerViewWidth;
    if (textLabel.frame.size.width > targetW){
        [textLabel setTextColor:self.textColorOuter];
        [textLabel setTextAlignment:NSTextAlignmentLeft];
        frame.origin = CGPointMake(targetW, 0);
    }else{
        [textLabel setTextColor:self.textColorInner];
        [textLabel setTextAlignment:NSTextAlignmentRight];
        frame.origin = CGPointMake(targetW - textLabel.frame.size.width, 0);
    }
    [textLabel setFrame:frame];
}

- (void)setProgress:(NSNumber *)progress{
    _progress = progress;
    
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    
    CGRect targetFrame = textLabel.frame;
    targetFrame = CGRectMake(0, 0, self.innerViewWidth, self.frame.size.height);
    
    [innerView.layer removeAllAnimations];
    
//    [UIView animateWithDuration:.33 animations:^{
//        [innerView setFrame:targetFrame];
//    }];
    
    [innerView setFrame:targetFrame];
}

@end
