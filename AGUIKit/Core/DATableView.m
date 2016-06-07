//
//  DATableView.m
//  AGUIKit
//
//  Created by Tao Yunfei on 6/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "DATableView.h"
#import "GlobalDefine.h"

@implementation DATableView

- (void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
    TLOG(@"contenInset -> %@", NSStringFromUIEdgeInsets(contentInset));
}

@end
