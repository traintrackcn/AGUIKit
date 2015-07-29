//
//  AGViewController+Datasource.m
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGViewController+Datasource.h"
#import "AGSectionUnit.h"
#import "DSValueUtil.h"

@implementation AGViewController(Datasource)

- (NSInteger)numberOfSections{
    return 0;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
//    AGSectionUnit *unit = [self.config unitOfSection:section];
//    if (unit) return unit.numberOfRows;
    return 0;
}


- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (unit) return [unit valueAtIndex:idx];
    return nil;
}

- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if ([DSValueUtil isAvailable:unit]) [unit setValue:value atIndex:idx];
}

- (id)valueForHeaderOfSection:(NSInteger)section{
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if ([DSValueUtil isAvailable:unit]) return unit.headerValue;
    return nil;
}


- (AGCell *)cellAtIndexPath:(NSIndexPath *)indexPath{
    AGCell *cell = (AGCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

- (UIView *)headerOfSection:(NSInteger)section{
    return [self.tableView headerViewForSection:section];
}

@end
