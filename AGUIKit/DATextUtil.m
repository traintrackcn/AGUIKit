//
//  DATextUtil.m
//  AGUIKit
//
//  Created by Tao Yunfei on 6/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "DATextUtil.h"

@interface DATextUtil(){
    
}

@property (nonatomic, strong) UILabel *helperForLabel;

@end

@implementation DATextUtil


- (CGSize)labelSizeRestrictedToMaxSize:(CGSize)maxSize attributedText:(NSAttributedString *)attributedText{
    [self.helperForLabel setAttributedText:attributedText];
    CGSize size = [self.helperForLabel sizeThatFits:maxSize];
    return size;
}

- (UILabel *)helperForLabel{
    if (!_helperForLabel) {
        _helperForLabel = [[UILabel alloc] init];
        [_helperForLabel setNumberOfLines:0];
    }
    return _helperForLabel;
}


@end
