//
//  AGCollectionViewCell.h
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class AGCollectionViewCellValue;
@class AGRemoter;
@class AGViewController;

@interface AGCollectionViewCell : UICollectionViewCell{
//    AGRemoter *remoter;
}

@property (nonatomic, strong) id value;
@property (nonatomic, strong) AGRemoter *remoter;
@property (nonatomic, weak) AGViewController *associatedViewController;

@end
