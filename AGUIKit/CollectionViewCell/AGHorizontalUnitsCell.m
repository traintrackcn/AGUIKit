//
//  AGHorizontalSelectorCell.m
//  AboveGEM
//
//  Created by traintrackcn on 21/10/14.
//
//

#import "AGHorizontalUnitsCell.h"
#import "AGCollectionViewLayoutHorizontalUnits.h"
#import "AGCollectionViewCell.h"
#import "DSValueUtil.h"
#import "DSDeviceUtil.h"

@interface AGHorizontalUnitsCell()<UICollectionViewDataSource, UICollectionViewDelegate>{
    UICollectionViewLayout *collectionViewLayout;
//    NSInteger numberOfCellsInOneScreen;
}

@end

@implementation AGHorizontalUnitsCell

//- (void)setDefaultIndex:(NSInteger)index{
//    selectedIndex = index;
//}

- (NSInteger)selectedIndex{
    return selectedIndex;
}

- (void)didSelectItem:(id)item{
    
}

- (id)selectedItem{
    if ([DSValueUtil isNotAvailable:self.items]) return nil;
    return [self.items objectAtIndex:selectedIndex];
}

- (void)selectIndexWithoutDispatchingDidSelect:(NSInteger)targetIndex{
    if (selectedIndex == targetIndex) return;
    
    UICollectionViewCell *selectedCell = [collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    UICollectionViewCell *targetCell = [collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0]];
    [selectedCell setSelected:NO];
    [targetCell setSelected:YES];
    
    selectedIndex = targetIndex;
    
    [self scrollToIndex:targetIndex animated:YES];
}

#pragma mark - 

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self assembleCollectionView];
    }
    return self;
}

- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

- (void)assembleCollectionView{
    if ([DSValueUtil isNotAvailable:collectionV]) {
        Class cls = self.collectionViewCellCls;
        UICollectionViewLayout *layout = self.collectionViewLayout;
        collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, [self.class height]) collectionViewLayout:layout];
        [collectionV setDelegate:self];
        [collectionV setDataSource:self];
        [collectionV registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
        [collectionV setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:collectionV];
        
    
        [collectionV setPagingEnabled:YES];
        [collectionV setShowsHorizontalScrollIndicator:NO];
        [collectionV setDelegate:self];
        [collectionV setAllowsSelection:YES];
        [collectionV setAllowsMultipleSelection:NO];}
    
}

#pragma mark - properties

- (Class)collectionViewCellCls{
    return nil;
}

- (UICollectionView *)collectionView{
    return collectionV;
}

- (UICollectionViewLayout *)collectionViewLayout{
    if ([DSValueUtil isNotAvailable:collectionViewLayout] ) {
        CGSize size = CGSizeMake([DSDeviceUtil bounds].size.width / 3, 44.0);
        collectionViewLayout = [[AGCollectionViewLayoutHorizontalUnits alloc] initWithCellSize:size];
    }
    return collectionViewLayout;
}





#pragma mark - value ops

- (void)setItems:(NSArray *)items{
    if (![items isKindOfClass:[NSArray class]]) return;
    _items = items;
    [self.collectionView reloadData];
}



#pragma mark - UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    Class cls = self.collectionViewCellCls;
    NSString *cellId = NSStringFromClass(cls);
    AGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setValue:[self.items objectAtIndex:index]];
    
//    TLOG(@"index -> %d selectedIndex -> %d", index, selectedIndex);
    if (index == selectedIndex ) {
        [cell setSelected:YES];
    }else{
        [cell setSelected:NO];
    }
    
    return cell;
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    @try {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }@catch (NSException *exception) {
//        TLOG(@"exception -> %@", exception);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberOfItems;
}

- (NSInteger)numberOfItems{
    return [DSValueUtil isAvailable:self.items]?self.items.count:0;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger targetIdx = indexPath.row;
    
    if ( targetIdx != selectedIndex) {
        
        //unhighlight selected cell
        @try {
            UICollectionViewCell *selectedCell = [collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
            [selectedCell setSelected:NO];
        }@catch (NSException *exception) {}
        
        
        if(selectedIndex != targetIdx){
            selectedIndex = targetIdx;
            
            if ([DSValueUtil isAvailable:self.selectedItem]){
                [self didSelectItem:self.selectedItem];
            }
        }
        
        [self scrollToIndex:targetIdx animated:YES];
        
        
    }
}

@end
