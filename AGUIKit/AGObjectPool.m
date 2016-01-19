//
//  AGObjectPool.m
//  AGUIKit
//
//  Created by Tao Yunfei on 11/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGObjectPool.h"
#import "GlobalDefine.h"

@interface AGObjectPool(){
    
}

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation AGObjectPool


- (void)setObject:(id)object forKey:(nonnull id<NSCopying>)key{
    [self.dic setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key{
    return [self.dic objectForKey:key];
}

- (void)dealloc{
    TLOG(@"");
    _dic = nil;
}

#pragma mark - properties

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

@end
