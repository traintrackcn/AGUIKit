//
//  AGVCGlobalDefine.m
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

#import "AGUIKitDefine.h"

@implementation AGUIKitDefine

- (BOOL)loggedRoleIsRetailCustomer{
    return self.loggedRoleIsRetailCustomerBlock();
}

- (NSString *)sessionRoleCode{
    return self.sessionRoleCodeBlock();
}

@end
