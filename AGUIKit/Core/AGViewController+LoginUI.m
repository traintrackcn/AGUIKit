//
//  AGViewController+LoginUI.m
//  AboveGEM
//
//  Created by traintrackcn on 7/11/14.
//
//

#import "AGViewController+LoginUI.h"
#import "AGViewController.h"
#import "AGUIDefine.h"
#import "NSObject+singleton.h"
#import "AGPresentableViewController.h"

@implementation AGViewController(LoginUI)


- (void)presentAssociatedLoginUI{
    
    if (![AGUIDefine singleton].loginViewControllerClass) return;
    
    dummyCell = [self dummyCellInstanceAtIndex:SectionDummyCellLoginUI];
    [[AGUIDefine singleton].loginViewControllerClass presentWithDelegate:dummyCell];
}

- (void)didDismissLoginUI{
    [self reloadVisibleIndexPaths];
    dummyCell = nil;
}


@end
