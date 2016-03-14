//
//  AGViewController+SectionComponents.m
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGViewController+SectionComponents.h"
#import "DASectionButton.h"

#import "AGObjectPool.h"

#define KEY_SECTION_BUTTON @"KEY_SECTION_BUTTON"

@implementation AGViewController (SectionComponents)

- (DASectionButton *)sectionButton:(NSInteger)section{
    NSString *key = [NSString stringWithFormat:@"%@_%ld", KEY_SECTION_BUTTON, section];
    DASectionButton *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [DASectionButton instanceWithSection:section config:self.config];
        [self.objPool setObject:item forKey:key ];
    }
    return item;
}


@end
