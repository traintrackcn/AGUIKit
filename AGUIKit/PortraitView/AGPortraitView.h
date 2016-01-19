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


- (void)setImage:(UIImage *)img;
- (void)setUrl:(NSString *)urlStr;
- (void)setBackgroundColor:(UIColor *)backgroundColor;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;






@end
