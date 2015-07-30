//
//  DSAlertUtil.m
//  og
//
//  Created by traintrackcn on 13-5-20.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "MKInfoPanel.h"
#import "SVProgressHUD.h"
#import "DSAlertUtil.h"
#import "AGTextCoordinator.h"
#import "AGUITextKeyDefine.h"

static const CGFloat DS_SECONDS_HIDE_AFTER = 3.0f;


typedef enum {
    ViewTagPermissionError = 100,
    ViewTagInvaildProfileAddress,
    ViewTagShoppingService,
    ViewTagWarning,
    ViewTagUserAgreementViewTag
}ViewTag;

static DSAlertUtil *___instanceDSAlertUtil;

@interface DSAlertUtil(){
    BOOL bAlerted;
}

@end

@implementation DSAlertUtil

+ (DSAlertUtil *)sharedInstance{
    if (___instanceDSAlertUtil==nil) {
        ___instanceDSAlertUtil = [[DSAlertUtil alloc] init];
    }
    return ___instanceDSAlertUtil;
}

#pragma mark - show alert

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message tag:(int)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...{
    
    if (bAlerted) return;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: otherButtonTitles, nil];
    [alert setTag:tag];
    [alert show];
    bAlerted = YES;
}



- (void)showAlertShoppingServiceUnavailable{
    NSString *msg = @"Shopping service is unavailable.";
    [self showAlertWithTitle:[AGTextCoordinator textForKey:KEY_LBL_WARNING] message:msg tag:ViewTagShoppingService cancelButtonTitle:[AGTextCoordinator textForKey:KEY_LBL_OK] otherButtonTitles:nil];
}


- (void)showAlertWarningMessage:(NSString *)msg{
    [self showAlertWithTitle:[AGTextCoordinator textForKey:KEY_LBL_WARNING] message:msg tag:ViewTagWarning cancelButtonTitle:[AGTextCoordinator textForKey:KEY_LBL_OK] otherButtonTitles:nil];
}


- (void)showAlertUserAgreement{
    
}


#pragma mark - SVProgressHUD



+ (void)showSVPKeywordIsEmpty{
    [SVProgressHUD showErrorWithStatus:[AGTextCoordinator textForKey:KEY_MSG_KEYWORK_IS_EMPTY]];
}

+ (void)showSVPProcessing{
    [SVProgressHUD showWithStatus:[AGTextCoordinator textForKey:KEY_MSG_PROCESSING] maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPSaving{
    [SVProgressHUD showWithStatus:[AGTextCoordinator textForKey:KEY_MSG_SAVING] maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPValidating{
    [SVProgressHUD showWithStatus:[AGTextCoordinator textForKey:KEY_MSG_VALIDATING] maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPStatusForCustomText:(NSString *)text{
    [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSVPErrorForCustomText:(NSString *)text{
    [SVProgressHUD showErrorWithStatus:text ];
}

+ (void)showSVPSuccessForCustomText:(NSString *)text{
    [SVProgressHUD showSuccessWithStatus:text];
}


+ (void)dismissSVP{
    [SVProgressHUD dismiss];
}

#pragma mark - kinds of panels

+ (void)showGlobalPanelErrorConnectionError{
    [self showGlobalPanelStyleErrorWithTitle:[AGTextCoordinator textForKey:KEY_LBL_NETWORK_ERROR]
                     subtitle:[AGTextCoordinator textForKey:KEY_MSG_CHECK_YOUR_CONNECTION]];
}

+ (void)showGobalPanelErrorCannotReachHost{
     [self showGlobalPanelStyleErrorWithTitle:[AGTextCoordinator textForKey:KEY_LBL_SERVER_MAINTENANCE]
                      subtitle:[AGTextCoordinator textForKey:KEY_MSG_UNDERGOING_MAINTENANCE]];
}

+ (void)showGlobalPanelErrorOops{
    [self showGlobalPanelStyleErrorWithTitle:[AGTextCoordinator textForKey:KEY_LBL_OOPS] subtitle:[AGTextCoordinator textForKey:KEY_MSG_OOPS_SOMETING_WRONG]];
}

//+ (void)showGlobalPanelErrorOops{
//    [self showGlobalPanelStyleErrorWithTitle:[AGTextCoordinator textOopsSomethingWrong] subtitle:nil];
//}

+ (void)showGlobalPanelStyleErrorWithTitle:(NSString *)title subtitle:(NSString *)subtitle{
    [MKInfoPanel showPanelInWindow: self.window
                              type:MKInfoPanelTypeError
                             title:title
                          subtitle:subtitle
                         hideAfter:DS_SECONDS_HIDE_AFTER];
    
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    bAlerted = NO;
    
    NSInteger tag = [alertView tag];
    
//    LOG_DEBUG(@"alertView btnIdx -> %ld tag -> %ld", (long)buttonIndex, (long)tag);
    
    switch (tag) {
        case ViewTagPermissionError:
//            [[DSRootViewController sharedInstance] dismiss];
            break;
        case ViewTagShoppingService:
//            [[DSRootViewController sharedInstance] showCatalogsVCWithToggle:NO initMenuSelection:NO];
            break;
        default:
            break;
    }
    
}


#pragma mark - properties
+ (UIWindow *)window{
    //    LOG_DEBUG(@"windows -> %@", [[UIApplication sharedApplication] windows]);
    return [[[UIApplication sharedApplication] windows] objectAtIndex:0];
}



@end
