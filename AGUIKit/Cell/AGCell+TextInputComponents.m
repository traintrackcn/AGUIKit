//
//  AGCell+InputField.m
//  Distributors
//
//  Created by Tao Yunfei on 1/5/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGCell+TextInputComponents.h"
#import "AGObjectPool.h"
#import "AGUIDefine.h"


@interface AGCell ()<UITextViewDelegate, UITextFieldDelegate>{
}

@end

@implementation AGCell (TextInputComponents)

#pragma mark - components

- (UITextField *)textInputField{
//    TLOG(@"%@", CURRENT_FUNCTION_NAME);
    NSString *key = CURRENT_FUNCTION_NAME;
    UITextField *item = [self.objPool objectForKey:key];
    
    if (!item) {
        item = [[UITextField alloc] init];
        [item setDelegate:self.textInputDelegate];
        [item setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [item setTextAlignment:NSTextAlignmentRight];
        [item setClearButtonMode:UITextFieldViewModeWhileEditing];
        [item setTextColor:COLOR(AG_UI_DEFINE.RGB_TEXT_INPUT)];
        [item setAdjustsFontSizeToFitWidth:YES];
        [item setAutocorrectionType:UITextAutocorrectionTypeNo];
        [item setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//        [item.layer setBorderWidth:1];
        [item setFont:FONT_WITH_SIZE(18.0)];
        
        [self.objPool setObject:item forKey:key];
        
    }
    
    return item;
}

- (UITextView *)textInputBox{
    NSString *key = CURRENT_FUNCTION_NAME;
    UITextView *item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[UITextView alloc] init];
        [item setDelegate:self.textInputDelegate];
        [self.objPool setObject:item forKey:key];
        [item setFont:FONT_WITH_SIZE(18.0)];
        [item setTextColor:COLOR(AG_UI_DEFINE.RGB_TEXT_INPUT)];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

- (DATextInputDelegate *)textInputDelegate{
    NSString *key = [NSString stringWithFormat:@"%@-%@", CURRENT_FUNCTION_NAME, self.indexPath];
    id item = [self.objPool objectForKey:key];
    if (!item) {
        item = [[DATextInputDelegate alloc] initWithCell:self];
        [self.objPool setObject:item forKey:key];
    }
    return item;
}

@end
