//
//  AGObjectPool.h
//  AGUIKit
//
//  Created by Tao Yunfei on 11/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGModel.h"

@interface AGObjectPool : AGModel

- (id)objectForKey:(NSString *)key class:(Class)cls;

@end
