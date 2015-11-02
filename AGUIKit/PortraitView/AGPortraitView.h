//
//  AGPortraitView.h
//  AboveGEM
//
//  Created by Tao Yunfei on 4/10/15.
//
//

#import <UIKit/UIKit.h>

@interface AGPortraitView : UIView

+ (instancetype)instanceWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;



@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIImageView *imageView;

@end
