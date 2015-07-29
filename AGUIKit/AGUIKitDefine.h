//
//  AGVCGlobalDefine.h
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AGUIKitDefine : NSObject

- (BOOL)loggedRoleIsRetailCustomer;
- (NSString *)sessionRoleCode;

@property (nonatomic, strong) Class loginUIClass;
@property (nonatomic, strong) NSArray *availableLanguages;
@property (nonatomic, strong) UINavigationController *rootViewController;
@property (nonatomic, copy) BOOL (^loggedRoleIsRetailCustomerBlock)(void);
@property (nonatomic, copy) NSString *(^sessionRoleCodeBlock)(void);

@end
