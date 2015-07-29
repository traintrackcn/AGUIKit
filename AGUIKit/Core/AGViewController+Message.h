//
//  AGViewController+DisplayMessages.h
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGViewController.h"

@interface AGViewController (DisplayMessages)


- (void)floatMessageProcessing;
- (void)floatMessage:(NSString *)message;
- (void)clearFloatedMessage;
- (void)resetFloatedMessage;


#pragma mark - display messages at the top of table view

- (void)setFailureMessages:(NSArray *)messages;
- (void)setSuccessMessages:(NSArray *)messages;
//- (void)clearMessages;
- (void)clearSetMessages;


@end
