//
//  DASectionButton.h
//  Distributors
//
//  Created by Tao Yunfei on 1/7/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGSectionUnit.h"

@interface DASectionButton : AGSectionUnit

@property (nonatomic, assign) NSInteger paddingT;
@property (nonatomic, assign) NSInteger paddingB;

@property (nonatomic, strong) id value;
@property (nonatomic, assign) BOOL disabled;

@end
