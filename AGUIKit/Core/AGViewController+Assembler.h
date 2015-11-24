//
//  AGViewController+Assembler.h
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGViewController.h"

@interface AGViewController(Assembler)


- (void)assemble;
- (void)assembleTopRefreshControl;
- (AGCell *)dummyCellInstanceAtIndex:(NSInteger)index;
- (AGCell *)assembleCellAtIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView;
- (UIView *)assembleHeaderForSection:(NSInteger)section;


@end
