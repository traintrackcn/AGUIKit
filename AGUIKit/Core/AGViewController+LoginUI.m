//
//  AGViewController+LoginUI.m
//  AboveGEM
//
//  Created by traintrackcn on 7/11/14.
//
//

#import "AGViewController+LoginUI.h"
#import "AGViewController+Assembler.h"
#import "AGUIDefine.h"
#import "NSObject+singleton.h"
#import "AGPresentableViewController.h"

@implementation AGViewController(LoginUI)


- (void)presentAssociatedLoginUI{
    dummyCell = [self assembleDummyCellAtIndex:SectionDummyCellLoginUI];
    
    
    [[AGUIDefine singleton].loginViewControllerClass presentWithDelegate:dummyCell];
}

- (void)didDismissLoginUI{
    [self reloadVisibleIndexPaths];
    dummyCell = nil;
}


@end
