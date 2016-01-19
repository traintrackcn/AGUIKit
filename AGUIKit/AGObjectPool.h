//
//  AGObjectPool.h
//  AGUIKit
//
//  Created by Tao Yunfei on 11/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGModel.h"

@interface AGObjectPool : AGModel

- (id)objectForKey:(nonnull NSString *)key;
- (void)setObject:(nonnull id)object forKey:(nonnull id<NSCopying>)key;

@end
