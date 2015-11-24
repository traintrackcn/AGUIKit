//
//  AGSection.m
//  AboveGEM
//
//  Created by traintrackcn on 15/1/15.
//
//

#import "AGSectionUnit.h"
#import "AGVCConfiguration.h"
//#import "AGHeaderViewStyleDefault.h"

@implementation AGSectionUnit

+ (instancetype)instanceWithSection:(NSInteger)section config:(AGVCConfiguration *)config{
    return [[self.class alloc] initWithSection:section config:config];
}

- (instancetype)initWithSection:(NSInteger)section config:(AGVCConfiguration *)config{
    self = [super init];
    if (self) {
        [self setConfig:config];
        [self setSection:section];
        [self setReadonly:NO];
        [config setSectionUnit:self];
        [self setAssociatedViewController:self.config.target];
    }
    return self;
}

- (id)valueAtIndex:(NSInteger)index{
    return nil;
}

- (id)paramterAtIndex:(NSInteger)index{
    return nil;
}

- (void)action:(id)action atIndex:(NSInteger)index{
    
}

- (void)setValue:(id)value atIndex:(NSInteger)index{
    
}



- (NSInteger)numberOfRows{
    return 1;
}

- (id)headerValue{
    return nil;
}

- (void)didSelect:(NSInteger)index{
    
}

//- (Class)headerClass{
//    return [AGHeaderViewStyleDefault class];
//}

@end
