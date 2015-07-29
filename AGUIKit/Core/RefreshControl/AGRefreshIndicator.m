//
//  AGRefreshControlIndicator.m
//  AboveGEM
//
//  Created by traintrackcn on 4/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGRefreshIndicator.h"
#import "AGViewController.h"
#import "GlobalDefine.h"

@interface AGRefreshIndicator(){
    UILabel *titleLabel;
//    NSTimeInterval duration;
    CGFloat titleW;
    CGFloat titleH;
}

@end

@implementation AGRefreshIndicator

- (id)init{
    self = [super init];
    if (self) {
//        duration = .33;
        titleW = 300;
        titleH = 20;
        [self assembleTitleLabel];
        
        [self setBackgroundColor:RGBA(242, 242, 242, 1)];
        [self.layer setCornerRadius:8.0];
    }
    return self;
}

#pragma mark - assemblers

- (void)assembleTitleLabel{
    titleLabel = [[UILabel alloc] init];
//    [titleLabel setBackgroundColor:RGBA(242, 242, 242, 1)];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [titleLabel.layer setCornerRadius:8.0];
    [self addSubview:titleLabel];
    [self layoutTitleLabel];
}

#pragma mark - properites

- (void)setTitle:(NSString *)title{
    [titleLabel setText:title];
}

#pragma mark - layout

- (void)layoutSubviews{
    [self layoutTitleLabel];
}

- (void)layoutTitleLabel{
    [titleLabel setFrame:CGRectMake((self.frame.size.width - titleW)/2, (self.frame.size.height - titleH)/2, titleW, titleH)];
}


#pragma mark - update views

- (void)update:(CGFloat)pullRatio{
    if (pullRatio > 1) pullRatio = 1;
    
    if (pullRatio > 0) {
        [self setHidden:NO];
        [self setAlpha:pullRatio];
    }else{
        [self setHidden:YES];
    }
}


@end
