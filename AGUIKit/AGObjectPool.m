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

- (id)objectForKey:(NSString *)key class:(Class)cls{
    id obj = [self.dic objectForKey:key];
    if (!obj) {
        obj = [[cls alloc] init];
        [self.dic setObject:obj forKey:key];
    }
    return obj;
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
