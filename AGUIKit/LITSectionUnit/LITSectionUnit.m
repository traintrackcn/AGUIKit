//
//  LITSectionUnit.m
//  AboveGEM
//
//  Created by Tao Yunfei on 14/09/2017.
//
//

#import "LITSectionUnit.h"
#import "AGViewController.h"

@implementation LITSectionUnit

- (id)headerCls{
    return nil;
}

- (void)reload:(BOOL)animated{
    [self.associatedVC reloadVisibleIndexPathsInSection:self.section animated:animated];
}

@end
