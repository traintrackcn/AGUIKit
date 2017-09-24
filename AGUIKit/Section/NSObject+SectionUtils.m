//
//  AGViewController+SectionComponents.m
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "NSObject+SectionUtils.h"
#import "DASectionButton.h"
#import "NSObject+ObjPool.h"
#import "NSObject+AGVCConfig.h"
#import "AGObjectPool.h"

#define KEY_SECTION_PREFIX @"KEY_SECTION_PREFIX"

@implementation NSObject (SectionUtils)

- (DASectionButton *)sectionButton:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    DASectionButton *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [DASectionButton instanceWithSection:section config:self.config];
        [self.objPool setObject:item forKey:key ];
    }
    return item;
}


- (id)sectionItemWithClass:(Class)cls inSection:(NSInteger)section{
    id item = [self sectionItemInSection:section];
    if (!item) {
        item = [cls instanceWithSection:section config:self.config];
        [self.objPool setObject:item forKey:[self keyOfSection:section]];
    }
    return item;
    
}

- (id)sectionWithClass:(Class)cls inSection:(NSInteger)section{
    id item = [self sectionItemInSection:section];
    if (!item) {
        item = [cls instanceWithSection:section config:self.config];
        [self.objPool setObject:item forKey:[self keyOfSection:section]];
    }
    return item;
    
}

- (id)sectionItemInSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    id item = [self.objPool objectForKey:key];
    return item;
}

#pragma mark - utils

- (NSString *)keyOfSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@_%@", KEY_SECTION_PREFIX, [NSNumber numberWithInteger:section]];

}

@end
