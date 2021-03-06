//
//  AGForm.h
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGModel.h"
#import "AGCell.h"


enum{
    AGIndexInvalid = -1,
    AGIndexDefault
};

@class AGParty;
@class AGViewController;
@class AGSectionUnit;

@interface AGVCConfiguration : AGModel{
}

#pragma mark - input properties' dic

- (void)setCellOptionalAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isCellOptionalAtIndexPath:(NSIndexPath *)indexPath;

//- (void)resetCellCls;
- (void)setCellCls:(Class)cls inSection:(NSInteger)section;

- (void)setCellCls:(Class)cls atIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClsOfIndexPath:(NSIndexPath *)indexPath;

- (void)setCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (void)setCellHeight:(CGFloat)height atFirstIndexPathInSection:(NSInteger)section;
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath;

- (void)setCellTitle:(NSString *)title inSection:(NSInteger)section;

- (void)setCellTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)cellTitleOfIndexPath:(NSIndexPath *)indexPath;

- (void)setHeaderCls:(Class)cls forSection:(NSInteger)section;
- (Class)headerClsOfSection:(NSInteger)section;

- (void)setSeparatorForSection:(NSInteger)section;
- (void)removeSeparatorForSection:(NSInteger)section;
- (BOOL)separatorForSection:(NSInteger)section;

- (void)setSectionUnit:(AGSectionUnit *)unit;
- (AGSectionUnit *)unitOfSection:(NSInteger)section;

@property (nonatomic, weak) AGViewController *target;

//- (UITableViewCell *)currentCell;

//@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
