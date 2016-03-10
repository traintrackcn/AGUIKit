//
//  AGSectionLoader.m
//  AboveGEM
//
//  Created by Tao Yunfei on 3/10/16.
//
//

#import "AGSectionLoader.h"
#import "AGSectionUnit.h"
#import "AGVCConfiguration.h"

@interface AGSectionLoader(){
    
}



@end

@implementation AGSectionLoader

- (void)setCore:(id)core{
    _core = core;
    [_core setAssociatedSectionLoader:self];
}

#pragma mark -

- (void)setValue:(id)value atIndex:(NSInteger)index{
    [self.core setValue:value atIndex:index];
}

- (id)valueAtIndex:(NSInteger)index{
    return [(AGSectionUnit *)self.core valueAtIndex:index];
}

- (id)paramterAtIndex:(NSInteger)index{
    return [self.core paramterAtIndex:index];
}

- (void)action:(id)action atIndex:(NSInteger)index{
    [self.core action:action atIndex:index];
}

- (NSInteger)numberOfRows{
    return [self.core numberOfRows];
}

- (void)didSelect:(NSInteger)index{
    [self.core didSelect:index];
}

- (id)headerValue{
    return [self.core headerValue];
}

@end
