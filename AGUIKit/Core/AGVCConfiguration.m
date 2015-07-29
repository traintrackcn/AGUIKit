//
//  AGForm.m
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGVCConfiguration.h"
#import "AGViewController.h"
#import "AGSectionUnit.h"
#import "AGHeaderViewStyleDefault.h"
#import "DSValueUtil.h"
#import "AGStyleCoordinator.h"

@interface AGVCConfiguration(){
    NSMutableDictionary *cellOptionalDic;
    NSMutableDictionary *cellClsDic;
    NSMutableDictionary *headerClsDic;
    NSMutableDictionary *cellTitleDic;
    NSMutableDictionary *sectionSeparatorDic;
    NSMutableDictionary *cellHeightDic;
    NSMutableDictionary *sectionUnitDic;
}

@end

@implementation AGVCConfiguration

#pragma mark -

- (id)init{
    self = [super init];
    if (self) {
        headerClsDic = [NSMutableDictionary dictionary];
        cellOptionalDic = [NSMutableDictionary dictionary];
        cellClsDic = [NSMutableDictionary dictionary];
        cellTitleDic = [NSMutableDictionary dictionary];
        sectionSeparatorDic = [NSMutableDictionary dictionary];
        cellHeightDic = [NSMutableDictionary dictionary];
        sectionUnitDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - input mapper

- (void)setCellOptionalAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [cellOptionalDic setObject:key forKey:key];
}

- (BOOL)isCellOptionalAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    if ([DSValueUtil isAvailable:[cellOptionalDic objectForKey:key]]) {
        return YES;
    }
    return NO;
}

- (void)setCellCls:(Class)cls inSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    [cellClsDic setValue:cls forKey:key];
}


- (Class)cellClsOfSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    return [cellClsDic objectForKey:key];
}

- (void)setSeparatorForSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    [sectionSeparatorDic setValue:[NSNumber numberWithBool:YES] forKey:key];
}

- (void)removeSeparatorForSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    [sectionSeparatorDic removeObjectForKey:key];
}

- (BOOL)separatorForSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    id value = [sectionSeparatorDic objectForKey:key];
    if ([DSValueUtil isAvailable:value]) {
        return [value boolValue];
    }
    return NO;
}


- (void)setCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [cellHeightDic setValue:[NSNumber numberWithDouble:height] forKey:key];
}

- (void)setCellHeight:(CGFloat)height atFirstIndexPathInSection:(NSInteger)section{
    NSString *key = [self keyOfIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    [cellHeightDic setValue:[NSNumber numberWithDouble:height] forKey:key];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    Class cellCls = [self cellClsOfIndexPath:indexPath];
//    TLOG(@"%@ height -> %f %@", cellCls, [cellCls height],indexPath);
    if ([cellHeightDic objectForKey:key]) return [[cellHeightDic objectForKey:key] doubleValue];
    return [cellCls height];
    
}

- (void)setCellCls:(Class)cls atIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [cellClsDic setValue:cls forKey:key];
}


- (Class)cellClsOfIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    if ([DSValueUtil isAvailable:[cellClsDic objectForKey:key]]) {
        return [cellClsDic objectForKey:key];
    }
    return [self cellClsOfSection:indexPath.section];
}


- (void)setCellTitle:(NSString *)title inSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    [cellTitleDic setValue:title forKey:key];
}

- (NSString *)cellTitleInSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    return [cellTitleDic objectForKey:key];
}

- (void)setCellTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [cellTitleDic setValue:title forKey:key];
}

- (NSString *)cellTitleOfIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    return [cellTitleDic objectForKey:key];
}

- (void)setHeaderCls:(Class)cls forSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    [headerClsDic setValue:cls forKey:key];
}


- (Class)headerClsOfSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    id cls = [headerClsDic objectForKey:key];
    if ([DSValueUtil isNotAvailable:cls]) {
        return [AGHeaderViewStyleDefault class];;
    }
    return cls;
}


- (void)setSectionUnit:(AGSectionUnit *)unit{
    NSString *key = [self keyOfSection:unit.section];
    [sectionUnitDic setValue:unit forKey:key];
}

- (AGSectionUnit *)unitOfSection:(NSInteger)section{
    NSString *key = [self keyOfSection:section];
    return [sectionUnitDic objectForKey:key];
}

#pragma mark - properties

- (NSString *)keyOfIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"seciton-%ld-index-%ld", (long)indexPath.section, (long)indexPath.row];
}

- (NSString *)keyOfSection:(NSInteger)section{
    return [NSString stringWithFormat:@"section-%ld", (long)section];
}


#pragma mark - 

//- (UITableViewCell *)currentCell{
//    return [self.target.tableView cellForRowAtIndexPath:self.currentIndexPath];
//}


@end
