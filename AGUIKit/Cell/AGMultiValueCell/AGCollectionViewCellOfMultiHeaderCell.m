//
//  AGCollectionViewCellOfMultiHeaderCell.m
//  AboveGEM
//
//  Created by traintrackcn on 3/2/15.
//
//

#import "AGCollectionViewCellOfMultiHeaderCell.h"
#import "AGStyleCoordinator.h"

@implementation AGCollectionViewCellOfMultiHeaderCell

- (UIFont *)textFont{
    return [AGStyleCoordinator fontMultiValueCellHeader];
}

@end
