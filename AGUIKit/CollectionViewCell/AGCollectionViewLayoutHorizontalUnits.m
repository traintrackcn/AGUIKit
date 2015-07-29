//
//  AGSelectorLayoutStyleHorizontal.m
//  AboveGEM
//
//  Created by traintrackcn on 21/10/14.
//
//

#import "AGCollectionViewLayoutHorizontalUnits.h"

@interface AGCollectionViewLayoutHorizontalUnits(){
    CGFloat cellW;
    CGFloat cellH;
    NSMutableDictionary *cellAttributesDic;
}

@end

@implementation AGCollectionViewLayoutHorizontalUnits

- (id)initWithCellSize:(CGSize)size{
    self = [super init];
    if (self) {
        cellAttributesDic = [NSMutableDictionary dictionary];
        cellW = size.width;
        cellH = size.height; //CollectionViewCell
    }
    return self;
}


- (CGFloat)cellW{
    return cellW;
}

#pragma mark -

- (void)prepareLayout{
    NSInteger numSections = [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < numSections; section++){
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        CGFloat targetX = 0;
        for(NSInteger index = 0; index < numCells; index++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            [attributes setFrame:CGRectMake(targetX, 0, cellW, cellH)];
            targetX += cellW;
            [cellAttributesDic setObject:attributes forKey:indexPath];
        }
    }
    //end of first section
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"self.collectionView.frame -> %@", NSStringFromCGRect(self.collectionView.frame));
    
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (CGSize)collectionViewContentSize{
    NSInteger numCells = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(numCells*cellW, cellH);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *visibleCellsAttributes = [NSMutableArray array];
    CGFloat minX = rect.origin.x;
    CGFloat maxX = minX + rect.size.width;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    //    TLOG(@"rect -> %@", NSStringFromCGRect(rect));
    
    for (NSInteger section = 0; section < numSections; section ++) {
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        NSInteger maxIdx = numCells - 1;
        CGFloat unitW = cellW;
        NSInteger startIdx = floorf(minX/unitW);
        NSInteger endIdx = ceilf(maxX/unitW);
        
        if (endIdx > maxIdx) endIdx = maxIdx;
        if (startIdx < 0) startIdx = 0;
//        TLOG(@"unitW -> %f", unitW);
//        TLOG(@"minX -> %f maxX -> %f", minX, maxX);
//        TLOG(@"startIdx -> %d endIdx -> %d", startIdx, endIdx);
 //       TLOG(@"cellAttributesDic -> %@", cellAttributesDic);
        for (NSInteger i = startIdx; i<= endIdx; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [cellAttributesDic objectForKey:indexPath];
            //            TLOG(@"attributes -> %@ indexPath -> %@", attributes, indexPath);
            [visibleCellsAttributes addObject:attributes];
        }
    }
    
    
    
    return visibleCellsAttributes;
}

@end
