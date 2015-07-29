//
//  AGHorizontalSelectorCell.h
//  AboveGEM
//
//  Created by traintrackcn on 21/10/14.
//
//

#import "AGCell.h"

@interface AGHorizontalUnitsCell : AGCell{
    UICollectionView *collectionV;
    NSInteger selectedIndex;
//    NSArray *items;
}

//- (void)setUnits:(NSArray *)units;

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;
- (NSInteger)selectedIndex;
- (void)selectIndexWithoutDispatchingDidSelect:(NSInteger)targetIndex;
- (Class)collectionViewCellCls;
- (UICollectionView *)collectionView;
- (UICollectionViewLayout *)collectionViewLayout;

@property (nonatomic, strong) NSArray *items;

@end
