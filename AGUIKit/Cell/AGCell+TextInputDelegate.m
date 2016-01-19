//
//  AGCell+TextInputDelegate.m
//  AGUIKit
//
//  Created by Tao Yunfei on 12/7/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGCell+TextInputDelegate.h"
#import "DSDeviceUtil.h"
#import "GlobalDefine.h"

@implementation AGCell (TextInputDelegate)

#pragma mark - properties

- (UITextView *)inputBox{
    return nil;
}

- (UITextField *)inputField{
    return nil;
}

- (BOOL)inputIsBox{
    return NO;
}

- (BOOL)inputIsField{
    return ![self inputIsBox];
}

#pragma mark - UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self shouldBeginEditing];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self didEndEditingWithText:textField.text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.textAlignment == NSTextAlignmentRight){
        if (range.location == textField.text.length && [string isEqualToString:@" "]) {
            // ignore replacement string and add your own
            textField.text = [textField.text stringByAppendingString:@"\u00a0"];
            return NO;
        }
    }
    
    
    
    // for all other cases, proceed with replacement
    return YES;
}

#pragma mark - UITextViewDelegate


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //    TLOG(@"");
    [self shouldBeginEditing];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self didEndEditingWithText:textView.text];
}

#pragma mark -

- (void)shouldBeginEditing{
    
    beginEditingNum ++;
    TLOG(@"====== beginEditingNum %ld ======", (long)beginEditingNum);
    
    UIEdgeInsets insetOld = self.tableView.contentInset;
    
    self.obUIKeyboardWillChangeFrameNotification = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        id userInfo = note.userInfo;
        //        CGRect keyboardFrameBegin = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        //        CGFloat keyboardFrameBeginY = keyboardFrameBegin.origin.y;
        CGRect keyboardFrameEnd = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardFrameEndY = keyboardFrameEnd.origin.y;
        CGFloat screenH = [DSDeviceUtil bounds].size.height;
        CGFloat keyboardH = keyboardFrameEnd.size.height;
        //        TLOG(@"Keyboard will change frame -> %@ keyboardFrameEndY -> %f screenH -> %f keyboardH -> %f", note.userInfo, keyboardFrameEndY, screenH, keyboardH);
        
        
        UIEdgeInsets insetNew = insetOld;
        
        //keyboard is showing up
        if (screenH != keyboardFrameEndY) {
            insetNew.bottom = keyboardH;
            [self.tableView setContentInset:insetNew];
            TLOG(@"adjust table view content inset -> %@", NSStringFromUIEdgeInsets(insetNew));
            //            TLOG(@"keyboard is showing up prevKeyboardFrameEndY %f", prevKeyboardFrameEndY);
            if (self.inputIsBox) {
                [self.tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
            if ([DSDeviceUtil isNotIOS8AndAbove]) {
                [self.tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
            
        }else{
            [self.tableView setContentInset:insetOld];
            
            //            TLOG(@"keyboard is dismissing prevKeyboardFrameEndY %f", prevKeyboardFrameEndY);
        }
        
        
        
    }];
    
    if ([DSDeviceUtil isNotIOS8AndAbove]) {
        [self.tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

static NSInteger beginEditingNum;

- (void)didEndEditingWithText:(NSString *)text{
    TLOG(@"====== didEndEditingWithText %ld ======", (long)beginEditingNum);
    //    [self inputFieldDidEndEditingWithText];
    if (self.inputIsField && self.inputField.textAlignment == NSTextAlignmentRight){
        text = [text stringByReplacingOccurrencesOfString:@"\u00a0" withString:@" "];
    }
    
    [self dispatchRequestSetValue:text];
    //    [[NSNotificationCenter defaultCenter] removeObserver:obUIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self.obUIKeyboardWillChangeFrameNotification];
    //    obUIKeyboardWillShowNotification = nil;
    [self setObUIKeyboardWillChangeFrameNotification:nil];
}


@end
