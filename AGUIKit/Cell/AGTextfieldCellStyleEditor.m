//
//  AGTextfieldCellStyleEditor.m
//  AboveGEM
//
//  Created by traintrackcn on 16/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTextfieldCellStyleEditor.h"
#import "AGTextfieldEditor.h"

@implementation AGTextfieldCellStyleEditor


- (void)assemble{
    [super assemble];
//    [arrowV removeFromSuperview];
}

- (void)activateSelector{
    AGTextfieldEditor *vc = [[AGTextfieldEditor alloc] init];
    [vc setAssociatedCell:self];
    [vc setTitle:self.title];
    [vc setValue:[self value] ];
    [self pushViewController:vc];
}


@end
