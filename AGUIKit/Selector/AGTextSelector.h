//
//  DSSelector.h
//  og
//
//  Created by traintrackcn on 12/19/13.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGViewController.h"
//@class AGVCConfiguration;
@interface AGTextSelector : AGViewController

+ (instancetype)instance;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) NSArray *items;
@property (nonatomic, assign) Class cellCls;



@end
