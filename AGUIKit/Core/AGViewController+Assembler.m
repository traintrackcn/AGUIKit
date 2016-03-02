//
//  AGViewController+Assembler.m
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGViewController+Assembler.h"
#import "AGViewController+Datasource.h"
#import "AGTopRefreshControl.h"
#import "AGHeaderViewStyleDefault.h"
#import "GlobalDefine.h"
#import "DSValueUtil.h"
#import "AGAssembler.h"

@implementation AGViewController(Assembler)


- (void)assemble{
    [self willReloadVisibleIndexPaths];
    [self assembleTableView];
    [self didReloadVisibleIndexPaths];
}

- (AGCell *)dummyCellInstanceAtIndex:(NSInteger)index{
    AGCell *cell = [[AGCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    [cell setAssociatedViewController:self];
    [cell setIndexPath:[NSIndexPath indexPathForRow:index inSection:SectionDummy]];
    return cell;
}

- (AGCell *)assembleCellAtIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView{
    Class cls = [self.config cellClsOfIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    NSString *cellId = NSStringFromClass(cls);
    
    if (self.cacheEveryCell) {
        cellId = [NSString stringWithFormat:@"%@-%ld-%ld",NSStringFromClass(cls), (long)idx,(long)section];
    }
    
    
    AGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    id value = [self valueAtIndexPath:indexPath];
    @try {
        
        //    TLOG(@"cell id -> %@ %@ %@", cellId, value, indexPath);
    
        if (!cell) {
            cell = [[cls alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//            TLOG(@"cell -> %@ self -> %@",cell, self);
            [cell setAssociatedViewController:self];
        }
        
        NSInteger numberOfRows = [self numberOfRowsInSection:section];
        BOOL bLastRow = (idx+1 == numberOfRows)?YES:NO;
        BOOL bFirstRow = idx == 0?YES:NO;
    
        [cell setIndexPath:indexPath];
        [cell setIsLastRow:bLastRow];
        [cell setIsFirstRow:bFirstRow];
        [cell setTitle: [self.config cellTitleOfIndexPath:indexPath] ];
        [cell setIsOptional: [self.config isCellOptionalAtIndexPath: indexPath ] ];
        [cell setValue:value];
    }@catch (NSException *exception) {
        TLOG(@"%@ exception -> %@ %@",cell.class, exception,value);
    }
    
    return cell;
}

- (UIView *)assembleHeaderForSection:(NSInteger)section{
    Class cls = [self.config headerClsOfSection:section];
    id value = nil;
//    NSInteger rows = [self numberOfRowsInSection:section];
    
    @try {
        value = [self valueForHeaderOfSection:section];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    }
    
//    TLOG(@"cls -> %@ value -> %@", cls, value);
    
    if (value){
        AGHeaderView *v = [[cls alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, [cls height])];
        [v setAssociatedViewController:self];
        [v setSection:section];
        [v setValue:value];
        return v;
    }
    
    return [self dummyHeaderView];
}



- (void)assembleTableView{
    
    tableV = [AGAssembler assembleTableViewStyleDefaultWithDelegate:self paddingTop:0 paddingBottom:0];
    [tableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableV];
    
//    [AGDebugUtil makeBorderForView:tableV];
    
    overlayContentView = [[UIView alloc] init];
    [overlayContentView setUserInteractionEnabled:NO];
    [self.view addSubview:overlayContentView];
    
    if (self.backgroundColor){
        [tableV setBackgroundColor:[UIColor clearColor]];
        [self.view setBackgroundColor:self.backgroundColor];
    }
}



- (void)assembleTopRefreshControl{
    if (!self.supportsRefreshControl || [DSValueUtil isAvailable:topRefreshControl]) return;
    topRefreshControl = [[AGTopRefreshControl alloc] init];
    [topRefreshControl setDelegate:self];
    [tableV addSubview:topRefreshControl];
}

@end
