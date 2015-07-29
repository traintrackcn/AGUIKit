//
//  AGLineProgressView.h
//  AboveGEM
//
//  Created by traintrackcn on 29/12/14.
//
//

#import <UIKit/UIKit.h>

@interface AGLineProgressView : UIView

- (void)assemble;

@property (nonatomic, strong) NSNumber *progress;
@property (nonatomic, strong) UIColor *innerViewBackgroundColor;
@property (nonatomic, strong) UIColor *textColorInner;
@property (nonatomic, strong) UIColor *textColorOuter;

@end
