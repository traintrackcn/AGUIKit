//
//  AGViewController+Datasource.h
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGViewController.h"

@interface AGViewController(Datasource)


- (UIView *)headerOfSection:(NSInteger)section;
- (id)valueForHeaderOfSection:(NSInteger)section;

- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
- (id)valueAtIndexPath:(NSIndexPath *)indexPath;

- (AGCell *)cellAtIndexPath:(NSIndexPath *)indexPath;


- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

@end
