//
//  DSAlertUtil.h
//  og
//
//  Created by traintrackcn on 13-5-20.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAlertUtil : NSObject <UIAlertViewDelegate>

+ (DSAlertUtil *)sharedInstance;

- (void)showAlertShoppingServiceUnavailable;
- (void)showAlertWarningMessage:(NSString *)msg;


#pragma mark - 

#pragma mark - svp status/alert/progress

+ (void)showSVPProcessing;
+ (void)showSVPSaving;
+ (void)showSVPValidating;
+ (void)showSVPKeywordIsEmpty;
+ (void)showSVPStatusForCustomText:(NSString *)text;
+ (void)showSVPErrorForCustomText:(NSString *)text;
+ (void)showSVPSuccessForCustomText:(NSString *)text;
+ (void)dismissSVP;

#pragma mark - panel
+ (void)showGlobalPanelErrorConnectionError;
+ (void)showGobalPanelErrorCannotReachHost;
+ (void)showGlobalPanelErrorOops;



#pragma mark - 
+ (UIWindow *)window;

@end
