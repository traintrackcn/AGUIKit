//
//  AGVCGlobalDefine.m
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

#import "AGUIDefine.h"

@implementation AGUIDefine

- (NSArray *)availableLanguages{
    if (_availableLanguages) {
        return _availableLanguages;
    }
    return @[];
}

- (BOOL)sessionRoleIsRetailCustomer{
    if (self.sessionRoleIsRetailCustomerBlock) {
        return self.sessionRoleIsRetailCustomerBlock();
    }
    return YES;
}

- (NSString *)sessionRoleCode{
    if (self.sessionRoleCodeBlock){
        return self.sessionRoleCodeBlock();
    }
    return @"";
}

@end
