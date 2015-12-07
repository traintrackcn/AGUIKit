//
//  AGCell+TextInputDelegate.h
//  AGUIKit
//
//  Created by Tao Yunfei on 12/7/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGCell.h"

@interface AGCell (TextInputDelegate)

- (BOOL)inputIsBox;
- (BOOL)inputIsField;
- (UITextField *)inputField;
- (UITextView *)inputBox;

@end
