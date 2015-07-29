//
//  AGPortraitView.h
//  AboveGEM
//
//  Created by Tao Yunfei on 4/10/15.
//
//

#import <UIKit/UIKit.h>

@interface AGPortraitView : UIView

//- (instancetype)initWithFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth;
- (UIColor *)borderColor;
- (CGFloat)borderWidth;

@property (nonatomic, strong) UIImageView *imageView;

@end
