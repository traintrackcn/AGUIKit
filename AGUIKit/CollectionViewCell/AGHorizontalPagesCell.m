//
//  AGCellStyleSelector.m
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGHorizontalPagesCell.h"
#import "AGCollectionViewLayoutHorizontalPages.h"
#import "AGCollectionViewLayoutHorizontalUnits.h"
#import "AGCollectionViewCell.h"
#import "DSDeviceUtil.h"
#import "DSValueUtil.h"

@interface AGHorizontalPagesCell() <UICollectionViewDataSource, UICollectionViewDelegate>{
    
}

@end

@implementation AGHorizontalPagesCell

@synthesize items = _items;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        selectedIndex = NSNotFound;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        [self.contentView addSubview:self.collectionView];
        [self makeDefaultSelection];
    }
}

#pragma mark - assemblers

- (UICollectionView *)collectionView{
//    TLOG(@"");
    if (!_collectionView) {
        Class cls = self.collectionViewCellCls;
        UICollectionViewLayout *layout = self.collectionViewLayout;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, self.height) collectionViewLayout:layout];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
//        [self.contentView addSubview:collectionV];
        [_collectionView setPagingEnabled:YES];
    }
    
    return _collectionView;
}



#pragma mark - properties

- (Class)collectionViewCellCls{
    return nil;
}
   
//- (UICollectionView *)collectionView{
//   return collectionV;
//}

- (UICollectionViewLayout *)collectionViewLayout{
    if ([DSValueUtil isNotAvailable:collectionViewLayout]) {
            collectionViewLayout = [[AGCollectionViewLayoutHorizontalPages alloc] init];
        [collectionViewLayout setCellW:[DSDeviceUtil bounds].size.width];
        [collectionViewLayout setCellH:self.height]; //CollectionViewCell
    }
    return collectionViewLayout;
}

#pragma mark - selection ops

- (NSInteger)selectedIndex{
    return selectedIndex;
}


- (BOOL)selectIndex:(NSInteger)index{
    if(selectedIndex == index) return NO;
    selectedIndex = index;
    return YES;
}

- (void)selectIndexAndDispatchSelectedItem:(NSInteger)index{
    if ([self selectIndex:index]) {
        [self dispatchSelectedItem];
    }
    
}

- (void)dispatchSelectedItem{
    if ([DSValueUtil isAvailable:self.selectedItem]){
        [self didSelectItem:self.selectedItem];
    }
}

- (void)selectIndexAndScrollToIndex:(NSInteger)index{
    if ([self selectIndex:index]) {
        [self scrollToIndex:index animated:YES];
    }
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    
    CGFloat targetContentOffsetX = [DSDeviceUtil bounds].size.width * index;
//    TLOG(@"targetContentOffsetX:%f collectionV.contentOffset.x:%f %@", targetContentOffsetX, collectionV.contentOffset.x, collectionV);
    if (self.collectionView.contentOffset.x != targetContentOffsetX){
        [self.collectionView setContentOffset:CGPointMake(targetContentOffsetX, 0) animated:animated];
    }
}

- (void)didSelectItem:(id)item{
    
}

- (id)selectedItem{
    if ([DSValueUtil isNotAvailable:self.items]) return nil;
    return [self.items objectAtIndex:selectedIndex];
}

- (void)makeDefaultSelection{
    if (selectedIndex != NSNotFound) return;
    [self selectIndex:0];
}



#pragma mark - setter


- (void)setItems:(NSArray *)items{
//    TLOG(@"theItems -> %@", theItems);
    if (_items) return;
    if (![items isKindOfClass:[NSArray class]]) return;
    _items = items;
    [self.collectionView reloadData];
}

- (NSArray *)items{
    if (!_items) {
        return @[];
    }
    return _items;
}

- (void)setValue:(id)value{
    if ([self isCachedValueSameAsTargetValue:value]) return;
    [super setValue:value];
    [self setItems:value];
}

#pragma mark - UICollectionViewDelegate & DataSource


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    Class cls = self.collectionViewCellCls;
    NSString *cellId = NSStringFromClass(cls);
    id value = [self.items objectAtIndex:index];
    AGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setAssociatedViewController:self.associatedViewController];
    [cell setValue:value];
//    TLOG(@"idx:%d value:%@", index, value);
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items?self.items.count:0;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger index = indexPath.row;
//    id item = [items objectAtIndex:index];
//    TLOG(@"item -> %@", item);
//}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    CGFloat contentW = scrollView.contentSize.width;
    CGFloat targetContentOffsetX = (*targetContentOffset).x;
    NSInteger targetIdx = targetContentOffsetX/[DSDeviceUtil bounds].size.width;
//    TLOG(@"targetIdx -> %d", targetIdx);
//    TLOG(@"");
    [self selectIndexAndDispatchSelectedItem:targetIdx];
}

@end
