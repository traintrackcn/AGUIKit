//
//  UILabel+AGUtil.m
//  AboveGEM
//
//  Created by Tao Yunfei on 5/21/15.
//
//

#import "UILabel+AGUtil.h"

@implementation UILabel (AGUtil)

- (void)setUnderlineForText:(NSString *)text underlineStyle:(NSUnderlineStyle)underlineStyle underlineColor:(UIColor *)underlineColor textColor:(UIColor *)textColor{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedText setAttributes:@{
                                    NSForegroundColorAttributeName: textColor,
                                    NSUnderlineColorAttributeName: underlineColor,
                                    NSUnderlineStyleAttributeName: @(underlineStyle)
                                    }
                            range:NSMakeRange(0, text.length)];
    
    [self setAttributedText:attributedText];
}

- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor exceptTitle:(NSString *)title{
    NSInteger startIdx = title.length;
    NSRange range = NSMakeRange(startIdx, text.length - title.length);
    
//    TLOG(@"text -> %d %@", text.length, NSStringFromRange(range));
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedText setAttributes:@{
                                    NSForegroundColorAttributeName: textColor
                                    }
                            range:range];
    
    [self setAttributedText:attributedText];
}

- (void)resizeWithMaxSize:(CGSize)maxSize{
    NSDictionary *attributes = @{
                                 NSFontAttributeName: self.font
                                 };
    CGRect rect = [self.text boundingRectWithSize:maxSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    
//    TLOG(@"rect -> %@ font -> %@", NSStringFromCGRect(rect), self.font);
    rect.origin = self.frame.origin;
    
    [self setFrame:rect];
    
//    [self sizeToFit];
    
}

- (void)moveTo:(CGPoint)pos{
    CGRect frame = self.frame;
    frame.origin = pos;
    [self setFrame:frame];
}


- (void)applyShadow{
    self.layer.shadowOpacity = .2;
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 1);
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = UIScreen.mainScreen.scale;
}

@end
