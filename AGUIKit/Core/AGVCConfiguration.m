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
#import "GlobalDefine.h"

@interface AGVCConfiguration(){
    NSMutableDictionary *cellOptionalDic;
    NSMutableDictionary *cellClsDic;
    NSMutableDictionary *headerClsDic;
    NSMutableDictionary *cellTitleDic;
    NSMutableDictionary *sectionSeparatorDic;
    NSMutableDictionary *cellHeightDic;
    NSMutableDictionary *sectionUnitDic;
//    NSMutableDictionary *cellDynamicHeightDic;
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
//        cellDynamicHeightDic = [NSMutableDictionary dictionary];
        sectionUnitDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - 

- (void)clearSettingsForSection:(NSInteger)section{
    [self clearSettingsForSection:section dic:headerClsDic];
    [self clearSettingsForSection:section dic:cellOptionalDic];
    [self clearSettingsForSection:section dic:cellClsDic];
    [self clearSettingsForSection:section dic:cellHeightDic];
//    [self clearSettingsForSection:section dic:cellDynamicHeightDic];
//    TLOG(@"cellHeightDic -> %@", cellHeightDic);
}

- (void)clearSettingsForSection:(NSInteger)section dic:(NSMutableDictionary *)dic{
    NSString *prefix = [NSString stringWithFormat:@"section-%ld",(long)section];
    NSDictionary *tmpDic = [NSDictionary dictionaryWithDictionary:dic];
    for (NSString *key in tmpDic) {
//        TLOG(@"prefix -> %@ key -> %@", prefix,key);
        if ([key rangeOfString:prefix].location != NSNotFound) {
            [dic removeObjectForKey:key];
        }
    }
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


//- (void)setCellDynamicHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
//    NSString *key = [self keyOfIndexPath:indexPath];
//    [cellDynamicHeightDic setValue:[NSNumber numberWithDouble:height] forKey:key];
//}
//
//- (CGFloat)cellDynamicHeightAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *key = [self keyOfIndexPath:indexPath];
//    CGFloat h = [[cellDynamicHeightDic objectForKey:key] floatValue];
//    return h;
//}

- (void)setCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [cellHeightDic setValue:[NSNumber numberWithDouble:height] forKey:key];
}

- (void)setCellHeight:(CGFloat)height atFirstIndexPathInSection:(NSInteger)section{
    NSString *key = [self keyOfIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    [cellHeightDic setValue:[NSNumber numberWithDouble:height] forKey:key];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"cellHeightDic -> %@", cellHeightDic);
    NSString *key = [self keyOfIndexPath:indexPath];
    Class cellCls = [self cellClsOfIndexPath:indexPath];
    NSNumber *calculatedHObj = [cellHeightDic objectForKey:key];
    if (calculatedHObj) return [calculatedHObj floatValue];
    return [cellCls height];
    
}

- (BOOL)cellHeightCalculatedAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    if ([cellHeightDic objectForKey:key]) return YES;
    return NO;
}

- (void)setCellCls:(Class)cls atIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    [cellClsDic setValue:cls forKey:key];
}


- (Class)cellClsOfIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyOfIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self unitOfSection:section];
    Class cls = [cellClsDic objectForKey:key];
    if (!cls && unit) cls = [unit clsAtIndex:idx];
    if (cls) return cls;
    
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
    return [NSString stringWithFormat:@"section-%ld-index-%ld", (long)indexPath.section, (long)indexPath.row];
}

- (NSString *)keyOfSection:(NSInteger)section{
    return [NSString stringWithFormat:@"section-%ld", (long)section];
}


#pragma mark - 

//- (UITableViewCell *)currentCell{
//    return [self.target.tableView cellForRowAtIndexPath:self.currentIndexPath];
//}


@end
