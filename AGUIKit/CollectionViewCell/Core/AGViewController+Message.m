//
//  AGViewController+DisplayMessages.m
//  AboveGEM
//
//  Created by traintrackcn on 18/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGViewController+Message.h"
#import "AGVCSuccessMessagesView.h"
#import "AGVCFailureMessagesView.h"
#import "DSValueUtil.h"
#import "DSDeviceUtil.h"
#import "AGStyleCoordinator.h"
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, UIViewTag) {
    UIViewTagFloatMessageBox = 999
};


@implementation AGViewController (DisplayMessages)

#pragma mark - float message ops

- (void)floatMessageProcessing{
    [self floatMessage:@"Processing"];
}

- (void)floatMessage:(NSString *)message{
//    TLOG(@"");
    UIView *v = [overlayContentView viewWithTag:UIViewTagFloatMessageBox];
    if ([DSValueUtil isNotAvailable:v]){
        v = [self assemblerFloatedView];
        [overlayContentView addSubview:v];
        [overlayContentView setUserInteractionEnabled:YES];
    }
    
    UILabel *titleView = (UILabel *)[v subviews].firstObject;
    [titleView setText:message];
//    [v.layer removeAllAnimations];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [v setAlpha:1];
    }];
    
    
}

- (void)clearFloatedMessage{
//    TLOG(@"");
    [self doClearFloatedMessage];
//    UIView *v = [overlayContentView viewWithTag:UIViewTagFloatMessageBox];
//    if ([DSValueUtil isAvailable:v]){
//        [UIView animateWithDuration:animationDuration animations:^{
//            [v setAlpha:0];
//        } completion:^(BOOL finished) {
//            TLOG(@"finished -> %d", finished);
////            if (finished){
//                [self doClearFloatedMessage];
////            }
//        }];
//    }
    
}

- (void)resetFloatedMessage{
    [self doClearFloatedMessage];
}

- (void)doClearFloatedMessage{
    //    TLOG(@"v.subviews -> %@", v.subviews);
    UIView *v = [overlayContentView viewWithTag:UIViewTagFloatMessageBox];
    if ([DSValueUtil isNotAvailable:v]) return;
    if (v.subviews.count >= 2){
        UIActivityIndicatorView *indicatorV = (UIActivityIndicatorView *)[v.subviews objectAtIndex:1];
        [indicatorV stopAnimating];
    }
    [v removeFromSuperview];
    [overlayContentView setUserInteractionEnabled:NO];
}

#pragma mark - floated message assemblers

- (UIView *)assemblerFloatedView{
    CGFloat w = 124;
    CGFloat h = 100;
    CGFloat x = ([DSDeviceUtil bounds].size.width - w)/2.0;
    CGFloat y = ([DSDeviceUtil bounds].size.height - h)/2.0;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    [v.layer setCornerRadius:12.0];
    [v setClipsToBounds:YES];
    [v setTag:UIViewTagFloatMessageBox];
    
    [v setBackgroundColor:[[AGStyleCoordinator colorForKey:@"floated-message-background"] colorWithAlphaComponent:.7]];
    
    
    //assemble title view
    UILabel *titleView = [self assembleFloatedTitleLabel:CGSizeMake(w, h)];
    [v addSubview:titleView];
    
    //assemble indicator
    UIView *indicatorV = [self assembleFloatedIndicator:CGSizeMake(w, h)];
    [v addSubview:indicatorV];
    
    [v setAlpha:0];
    
    
    
    return v;
}

- (UIView *)assembleFloatedIndicator:(CGSize)containerSize{
    CGFloat w = 60;
    CGFloat h = 60;
    CGFloat x = (containerSize.width - w)/2.0;
    CGFloat y = 10;
    
    
    UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [v setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [v.layer setBorderWidth:1];
    [v startAnimating];
    return v;
}

- (UILabel *)assembleFloatedTitleLabel:(CGSize)containerSize{
    CGFloat padding = 4.0f;
    CGFloat w = containerSize.width;
    CGFloat h = 30.0;
    CGFloat x = 0;
    CGFloat y = containerSize.height - h - padding;
    CGRect frame = CGRectMake(x, y, w, h);
    UILabel *l = [[UILabel alloc] initWithFrame:frame];
    [l setAdjustsFontSizeToFitWidth:YES];
    [l setFont:[UIFont boldSystemFontOfSize:16.0]];
    //        TLOG(@"%@ self.parentViewController -> %@",self.class, self.navigationController);
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setTextColor:[AGStyleCoordinator colorForKey:@"floated-message"]];
    return l;
}





#pragma mark - display message ops

- (void)setSuccessMessages:(NSArray *)messages{
    [self displayMessages:messages cls:[AGVCSuccessMessagesView class]];
}

- (void)setFailureMessages:(NSArray *)messages{
    [self displayMessages:messages cls:[AGVCFailureMessagesView class]];
}

- (void)displayMessages:(NSArray *)messages cls:(Class)cls{
    if (messages.count == 0) return;
    if (cls == nil) cls = [AGVCMessagesView class];
    
    AGVCMessagesView *v = [[cls alloc] init];
    [v updateMessages:messages];
    [tableV setTableHeaderView:v];
    [tableV scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)clearSetMessages{
    [self.tableView setTableHeaderView:nil];
}

@end
