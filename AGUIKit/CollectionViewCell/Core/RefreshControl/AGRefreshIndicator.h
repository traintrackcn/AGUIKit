//
//  AGRefreshControlIndicator.h
//  AboveGEM
//
//  Created by traintrackcn on 4/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGRefreshIndicator : UIView

- (void)setTitle:(NSString *)title;
- (void)update:(CGFloat)pullRatio;

@end
