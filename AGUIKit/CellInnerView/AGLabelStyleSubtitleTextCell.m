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
    return [AGStyleCoordinator fontWithSize:14];
}

- (UIFont *)detailTextFont{
    return [AGStyleCoordinator fontWithSize:14];
}

- (BOOL)borderEnabled{
    return NO;
}

@end
