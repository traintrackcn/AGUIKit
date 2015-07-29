//
//  DSRegistrationCountrySelector.m
//  og
//
//  Created by traintrackcn on 12/11/13.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "AGTextSelector.h"
#import "AGModel.h"
#import "AGViewController.h"
#import "AGVCConfiguration.h"
#import "AGSelectorItem.h"
#import "DSValueUtil.h"
#import "AGTextCell.h"
#import "AGButtonCell.h"
#import "AGViewController+Datasource.h"
#import "AGButtonItem.h"

typedef NS_ENUM(NSInteger, Section) {
    SectionItem,
    SectionButton,
    SectionCount
};

@interface AGTextSelector(){
    NSArray *itemsFirstLettersSorted;
    NSArray *itemsSorted;
    UITableView *tableV;
    UILabel *titleV;
    UIView *layoutV;
}

@end


@implementation AGTextSelector

+ (instancetype)instance{
    return [[self.class alloc] init];
}


#pragma mark - setters

- (void)setItems:(NSArray *)items{
    _items = items;
    [self sortItems];
    
    NSInteger num = self.SectionCount - 1;
    for (NSInteger section = 0; section < num; section++) {
        [self.config setCellCls:[AGTextCell class] inSection:section];
    }
    
    [self.config setCellCls:[AGButtonCell class] inSection:self.SectionButton];
}

#pragma mark - properties

- (NSInteger)SectionButton{
    return itemsSorted.count + 1;
}

- (NSInteger)SectionCount{
    return self.SectionButton + 1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    if (section == self.SectionButton) {
        return 1;
    }else{
        NSArray *tmpItems = [itemsSorted objectAtIndex:section];
        return tmpItems.count;
    }
    
    return 0;
    
}



- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    id value;
    
    NSInteger section = indexPath.section;
    
    if (section == self.SectionButton) {
        value = @[[AGButtonItem instanceWithTitle:@"Cancel" target:self action:@selector(didTapCancel:)] ];
    }else{
        value = [self titleAtIndexPath:indexPath];
    }
    
    
    return value;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return itemsFirstLettersSorted;
}

#pragma mark - properties

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id nowValue = [self itemAtIndexPath:indexPath];
    [self setValueForAssociatedCell:nowValue];
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    NSArray *tmpItems = [itemsSorted objectAtIndex:section];
    return [DSValueUtil itemAtIndex:index inArray:tmpItems];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    return [self titleOfItem:item];
}

- (NSString *)titleOfItem:(id)item{
    NSString *title = @"";
    
    if ([item respondsToSelector:@selector(name)]) {
        title = [(AGSelectorItem *)item name];
    }else if ([item respondsToSelector:@selector(key)]) {
        title = [(AGSelectorItem *)item key];
    }else if ([item respondsToSelector:@selector(optionText)]) {
        title = [(AGSelectorItem *)item optionText];
    }
    
    return title;
}

#pragma mark - sorters

- (void)sortItems{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    
    for (int i=0; i<self.items.count; i++) {
        id item = [self.items objectAtIndex:i];
        NSString *firstLetter;
        NSString *title = [self titleOfItem:item];
        
        if ([item respondsToSelector:@selector(name)]) {
            firstLetter = [title substringWithRange:NSMakeRange(0, 1)];
        }else{
            firstLetter = @"";
        }
        

        NSMutableArray *arrWithTheFirstLetter = [d objectForKey:firstLetter];
        BOOL alreadyHasTheArr = [DSValueUtil isAvailable:arrWithTheFirstLetter];
        
        if (!alreadyHasTheArr) {
            arrWithTheFirstLetter = [NSMutableArray array];
            [d setObject:arrWithTheFirstLetter forKey:firstLetter];
        }
        
        [arrWithTheFirstLetter addObject:item];
        
    }
    
    NSArray *tmpFirstLetters = [d allKeys];
    NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    NSArray *sortDesArr = [NSArray arrayWithObject:sortDes];
    //    LOG_DEBUG(@"items -> %@", items);
//    items = [items sortedArrayUsingDescriptors:sortDesArr];
    itemsFirstLettersSorted = [tmpFirstLetters sortedArrayUsingDescriptors:sortDesArr];
//    TLOG(@"itemsFirstLettersSorted -> %@", itemsFirstLettersSorted);
    
    NSMutableArray *tmpItemsSorted = [NSMutableArray arrayWithCapacity:itemsFirstLettersSorted.count];
    for (int i=0; i<itemsFirstLettersSorted.count; i++) {
        NSString *firstLetter = [itemsFirstLettersSorted objectAtIndex:i];
        NSMutableArray *arrWithTheFirstLetter = [d objectForKey:firstLetter];
        [tmpItemsSorted addObject:arrWithTheFirstLetter];
    }
    
    itemsSorted  = tmpItemsSorted;
//    TLOG(@"itemsSorted -> %@", itemsSorted);

}

#pragma mark - interactive actions

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
