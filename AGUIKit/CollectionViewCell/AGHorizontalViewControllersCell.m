//
//  AGMultipleViewControllersCell.m
//  AboveGEM
//
//  Created by traintrackcn on 10/12/14.
//
//

#import "AGHorizontalViewControllersCell.h"
#import "AGCollectionViewCellViewController.h"
#import "AGCollectionViewLayout.h"
#import "AGCollectionViewLayoutHorizontalPages.h"
#import "AGViewController+Datasource.h"
#import "AGViewController.h"
#import "GlobalDefine.h"

NSString *AGHorizontalViewControllersCellDidChange = @"AGHorizontalViewControllersCellDidChange";

@interface AGHorizontalViewControllersCell() <UICollectionViewDelegate>{
}

@end

@implementation AGHorizontalViewControllersCell

#pragma mark - properties

- (CGFloat)height{
    return [[(AGViewController *)self.associatedViewController config] cellHeightAtIndexPath:self.indexPath];
}

- (Class)collectionViewCellCls{
    return [AGCollectionViewCellViewController class];
}

- (void)didSelectItem:(id)item{
//    TLOG(@"item -> %@", self.collectionView.visibleCells);
    NSDictionary *action = @{@"type":AGHorizontalViewControllersCellDidChange,@"value":item};
    [self dispatchRequestAction:action];
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    AGCollectionViewCellViewController *vcCell = (AGCollectionViewCellViewController *)cell;
    AGViewController *vc = vcCell.viewController;
    TLOG(@"vc -> %@ cell->%@ ", vc, vcCell);
    if (vc) {
        [vc viewWillAppear:NO];
    }
}

//- (void)willDisplayCellAtIndex:(NSInteger)index{
//    [super willDisplayCellAtIndex:index];
////    TLOG(@"index -> %d %@", index, items);
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//    AGCollectionViewCellViewController *cell = (AGCollectionViewCellViewController *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    TLOG(@"vc -> %@ cell->%@ num -> %@", cell.viewController, cell, [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]);
//    if (cell.viewController) {
//        [cell.viewController viewWillAppear:NO];
//    }
//}

@end
