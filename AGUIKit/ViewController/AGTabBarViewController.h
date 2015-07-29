//
//  AGCommissionEarningsViewController.h
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

#import "AGViewController.h"
#import "AGHorizontalViewControllersCell.h"
#import "AGTabBarCell.h"

@interface AGTabBarViewController : AGViewController{
    NSMutableArray *titleValueArr;
    NSMutableArray *contentValueArr;
}

- (AGHorizontalViewControllersCell *)contentCell;
- (AGTabBarCell *)tabBarCell;
- (void)contentDidChangeToIndex:(NSInteger)index;
- (void)tabBarDidChangeToIndex:(NSInteger)index;

@property (nonatomic, strong) NSArray *titleItems;
@property (nonatomic, strong) NSArray *contentItems;

@end
