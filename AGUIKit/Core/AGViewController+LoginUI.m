//
//  AGViewController+LoginUI.m
//  AboveGEM
//
//  Created by traintrackcn on 7/11/14.
//
//

#import "AGViewController+LoginUI.h"
#import "AGViewController+Assembler.h"
#import "AGUIKitDefine.h"
#import "NSObject+singleton.h"
#import "AGPresentableViewController.h"

@implementation AGViewController(LoginUI)


- (void)presentAssociatedLoginUI{
    dummyCell = [self assembleDummyCellAtIndex:SectionDummyCellLoginUI];
    
    
    [[AGUIKitDefine singleton].loginUIClass presentWithDelegate:dummyCell];
}

- (void)didDismissLoginUI{
    [self reloadVisibleIndexPaths];
    dummyCell = nil;
}


@end
