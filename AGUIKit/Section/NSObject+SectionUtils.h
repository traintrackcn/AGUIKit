//
//  AGViewController+SectionComponents.h
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "GlobalDefine.h"
#import <Foundation/Foundation.h>

@class DASectionButton;
@interface NSObject (SectionUtils)

- (DASectionButton *)sectionButton:(NSInteger)section;
- (id)sectionItemWithClass:(Class)cls inSection:(NSInteger)section DEPRECATED_WITH_MSG("Use sectionWithClass:inSection: instead");
- (id)sectionWithClass:(Class)cls inSection:(NSInteger)section;
- (id)sectionItemInSection:(NSInteger)section;

@end
