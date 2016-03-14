//
//  AGViewController+SectionComponents.h
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGViewController.h"

@class DASectionButton;
@interface AGViewController (SectionComponents)

- (DASectionButton *)sectionButton:(NSInteger)section;

@end
