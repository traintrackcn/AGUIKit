//
//  AGCell+InputField.h
//  Distributors
//
//  Created by Tao Yunfei on 1/5/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "AGCell.h"
#import "DATextInputDelegate.h"

@interface AGCell (TextInputComponents)

- (UITextField *)textInputField;
- (UITextView *)textInputBox;
- (DATextInputDelegate *)textInputDelegate;




@end
