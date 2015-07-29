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

@interface AGHorizontalViewControllersCell() {
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

- (void)willDisplayCellAtIndex:(NSInteger)index{
    [super willDisplayCellAtIndex:index];
//    TLOG(@"index -> %d %@", index, items);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    AGCollectionViewCellViewController *cell = (AGCollectionViewCellViewController *)[self.collectionView cellForItemAtIndexPath:indexPath];
    TLOG(@"vc -> %@", cell.viewController);
    if (cell.viewController) {
        [cell.viewController viewWillAppear:NO];
    }
}

#pragma mark - setter

//- (void)setValue:(id)value{
//    TLOG(@"value -> %@", value);
//    [super setValue:value];
//}

@end
