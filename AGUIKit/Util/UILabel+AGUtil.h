//
//  UILabel+AGUtil.h
//  AboveGEM
//
//  Created by Tao Yunfei on 5/21/15.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (AGUtil)

- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor exceptTitle:(NSString *)title;
- (void)resizeWithMaxSize:(CGSize)maxSize;
- (void)moveTo:(CGPoint)pos;

@end
