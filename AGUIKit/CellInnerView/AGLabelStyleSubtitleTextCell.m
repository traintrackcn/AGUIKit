//
//  AGLabelStyleSubtitleTextCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 5/22/15.
//
//

#import "AGLabelStyleSubtitleTextCell.h"
#import "AGStyleCoordinator.h"

@implementation AGLabelStyleSubtitleTextCell

- (UIFont *)textFont{
    return [UIFont systemFontOfSize:14];
}

- (UIFont *)detailTextFont{
    return [UIFont systemFontOfSize:14];
}

- (BOOL)borderEnabled{
    return NO;
}

@end
