//
//  AGFormKeyboardInput.m
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTextfieldCell.h"
#import "AGStyleCoordinator.h"
#import "DSValueUtil.h"
#import "GlobalDefine.h"
#import "DSDeviceUtil.h"

@interface AGTextfieldCell(){
//    id obUIKeyboardWillShowNotification;
    id obUIKeyboardWillChangeFrameNotification;
//    CGFloat spacing;
}

@end

@implementation AGTextfieldCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        paddingLR = 15.0;
//        spacing = 4.0f;
//        titleMaxH = 44.0;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assemble];
    }
    return self;
}

//+ (CGFloat)height{
//    return 80.0;
//}

- (CGFloat)titleMaxH{
    return 44.0;
}

- (CGFloat)spacing{
    return 4.0;
}

- (CGFloat)paddingLR{
    return 15.0;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:obUIKeyboardWillChangeFrameNotification];
}

- (void)applySelectedStyle{
    
}

#pragma mark - assemblers

- (void)assemble{
    [self assembleTitleView];
    [self assembleInputView];
    [self assembleBottomBorder];
}


- (void)assembleTitleView{
    if ([DSValueUtil isAvailable:titleLabel]) return;
//    CGFloat w = self.frame.size.width/3.0;
    titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[AGStyleCoordinator fontWithSize:16]];
    [titleLabel setTextColor:[AGStyleCoordinator colorTextfieldTitle]];
    [titleLabel setNumberOfLines:2];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    
//    [titleLabel.layer setBorderWidth:1.0];
    [self.contentView addSubview:titleLabel];
}

- (void)assembleStarView{
    if ([DSValueUtil isNotAvailable:starLabel]) {
        starLabel= [[UILabel alloc] init];
        UIFont *f = [UIFont boldSystemFontOfSize:24.0];
        [starLabel setText:@"*"];
        [starLabel setTextColor:[AGStyleCoordinator colorForKey:@"input-field-star"]];
        [starLabel setFont:f];
        [self.contentView addSubview:starLabel];
    }
}

- (void)removeStarView{
    if ([DSValueUtil isAvailable:starLabel]) {
        [starLabel removeFromSuperview];
        starLabel = nil;
    }
}

- (void)assembleInputView{
    if ([DSValueUtil isAvailable:inputView]) return;
    
    if (self.inputIsBox) {
        [self assembleInputBox];
    }else{
        [self assembleInputField];
    }
    
//    [inputView setBackgroundColor:RGBA(242, 242, 242, 1)];
//    [inputView.layer setBorderWidth:1.0];
    [self.contentView addSubview:inputView];
    
}

- (void)assembleInputBox{
    CGFloat x = self.paddingLR;
    CGFloat y = self.titleMaxH;
    CGFloat w = self.frame.size.width - self.paddingLR*2;
    CGFloat h = [self.class height] - self.titleMaxH;
    CGRect frame = CGRectMake(x, y, w, h);
    inputView = [[UITextView alloc] initWithFrame:frame];
    [self.inputBox setDelegate:self];
    [self.inputBox setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.inputBox setTextColor:[AGStyleCoordinator colorTextfieldContent]];
    
    [self.inputBox.layer setBorderWidth:1.0];
    [self.inputBox.layer setBorderColor:[AGStyleCoordinator colorCellBorder].CGColor];
    [self.inputBox setFont:[AGStyleCoordinator fontWithSize:16]];
//    [AGDebugUtil makeBorderForView:inputView];
//    TLOG(@"", <#__args...#>)
}


- (void)assembleInputField{
    
    
    inputView = [[UITextField alloc] init];
    [self.inputField setDelegate:self];
    [self.inputField setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
//    [self.inputField setRightView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 8)]];
//    [self.inputField setRightViewMode:UITextFieldViewModeAlways];
    [self.inputField setTextAlignment:NSTextAlignmentRight];
    [self.inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.inputField setTextColor:[AGStyleCoordinator colorTextfieldContent]];
    [self.inputField setAdjustsFontSizeToFitWidth:YES];
    [self.inputField.layer setBorderColor:[AGStyleCoordinator colorCellBorder].CGColor];
    [self.inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    [self.inputField.layer setBorderWidth:1.0];
    [self.inputField setFont:[AGStyleCoordinator fontWithSize:16]];
}

- (void)enableNumberPadForInputField{
    [self.inputField setKeyboardType:UIKeyboardTypeNumberPad];
    [self appendNumberPadToolbar];
}

- (void)enableNumberAndPunctuationPadForInputField{
    [self.inputField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self appendNumberPadToolbar];
}

- (void)appendNumberPadToolbar{
    UIToolbar  *numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, 50)];
    numberToolbar.items = [NSArray arrayWithObjects:
                           //                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad:)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(didTapDoneNumberPad:)],
                           //                           [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDone:)],
                           nil];
    [self.inputField setInputAccessoryView:numberToolbar];
}

#pragma mark - interactive actions

- (void)didTapDoneNumberPad:(id)sender{
    [self.inputField endEditing:YES];
}


#pragma mark - layout

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutTitleView];
    [self layoutStarView];
    [self layoutInput];
}


- (CGRect)inputFieldFrame{
    CGFloat x = 0;
    
    if ([DSValueUtil isAvailable:starLabel]){
        x = starLabel.frame.size.width + starLabel.frame.origin.x + self.spacing;
    }else{
        x = titleLabel.frame.size.width + titleLabel.frame.origin.x + self.spacing;
    }
    
    CGFloat y = 0;
    CGFloat w = self.frame.size.width - x - self.paddingLR;
    CGFloat h = [self.class height];
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator){
        w -= 14;
    }
    
    return CGRectMake(x, y, w, h);
}

- (void)layoutInput{
    if (self.inputIsBox){
        [self layoutInputBox];
    }else{
        [self layoutInputField];
    }
}

- (void)layoutInputField{
    [self.inputField setFrame:self.inputFieldFrame];
}

- (void)layoutTitleView{
    if (self.inputIsBox){
        [self layoutTitleViewForInputBox];
    }else{
        [self layoutTitleViewForInputField];
    }
}

- (void)layoutTitleViewForInputBox{
    
//    CGFloat h = titleMaxH;
    CGSize titleMaxSize = CGSizeMake(self.frame.size.width, self.titleMaxH);
    CGSize titleSize = [titleLabel.text boundingRectWithSize:titleMaxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin attributes:
                        @{NSFontAttributeName:[AGStyleCoordinator fontWithSize:14]} context:nil].size;
    
    CGRect titleFrame = titleLabel.frame;
    CGFloat y = (self.titleMaxH - titleSize.height)/2.0;
    titleFrame.origin = CGPointMake(self.paddingLR, y);
    titleFrame.size = CGSizeMake(titleSize.width, titleSize.height);
    [titleLabel setFrame:titleFrame];
    
    
    
}

- (void)layoutInputBox{
//    return;
    CGRect titleFrame = titleLabel.frame;
    CGSize titleSize = titleFrame.size;
    CGFloat paddingBottom = (self.titleMaxH - titleSize.height)/2.0;
    //resize input box
    CGFloat inputBoxW = self.frame.size.width - self.paddingLR *2;
    CGFloat inputBoxH = [self.class height] - self.titleMaxH - paddingBottom;
    CGRect inputBoxFrame = self.inputBox.frame;
    inputBoxFrame.size = CGSizeMake(inputBoxW, inputBoxH);
//    TLOG(@"inputBoxFrame -> %@", NSStringFromCGRect(inputBoxFrame));
    [self.inputBox setFrame:inputBoxFrame];
}

- (void)layoutTitleViewForInputField{
    
    CGSize titleMaxSize;
    
    if ([self.class height] > self.titleMaxH){
        titleMaxSize = CGSizeMake(self.frame.size.width-self.paddingLR*2, self.titleMaxH);
    }else{
        titleMaxSize = CGSizeMake((self.frame.size.width-self.paddingLR*2)/2, self.titleMaxH);
    }
    
    CGSize titleSize = [titleLabel.text boundingRectWithSize:titleMaxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin attributes:
                        @{NSFontAttributeName:[AGStyleCoordinator fontWithSize:14]} context:nil].size;
    
//    TLOG(@"titleMaxSize -> %@ titleSize -> %@", NSStringFromCGSize(titleMaxSize), NSStringFromCGSize(titleSize));
    
    CGRect titleFrame = titleLabel.frame;
    titleFrame.origin = CGPointMake(self.paddingLR, (self.titleMaxH - titleSize.height)/2.0);
    titleFrame.size = titleSize;
    [titleLabel setFrame:titleFrame];
//    [titleLabel.layer setBorderWidth:1.0];
}

- (void)layoutStarView{
    
    CGRect titleFrame = titleLabel.frame;
    CGRect starFrame = CGRectMake(titleFrame.origin.x + titleFrame.size.width + self.spacing, titleFrame.origin.y + self.spacing, 10, titleFrame.size.height);
    [starLabel setFrame:starFrame];
    
//    [starLabel.layer setBorderWidth:1.0];
}

#pragma mark - properties

- (UITextField *)inputField{
    return (UITextField *)inputView;
}

- (UITextView *)inputBox{
    return (UITextView *)inputView;
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    [titleLabel setText:title];
}

- (void)setPlaceholder:(NSString *)placeholder{
    [self.inputField setPlaceholder:placeholder];
}

- (void)setValue:(id)value{
    [super setValue:value];
    [self.inputField setText:[DSValueUtil toString:value]];
}

- (void)setIsOptional:(BOOL)isOptional{
    if (isOptional){
        [self removeStarView];
    }else{
        [self assembleStarView];
    }
}

- (void)setIsAdvanced:(BOOL)isAdvanced{
    // display more options icon
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

- (BOOL)inputIsField{
    return !self.inputIsBox;
}

#pragma mark -

- (void)shouldBeginEditing{
    
    beginEditingNum ++;
    TLOG(@"====== beginEditingNum %ld ======", (long)beginEditingNum);

    UIEdgeInsets insetOld = self.tableView.contentInset;
    
    obUIKeyboardWillChangeFrameNotification = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
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
    [[NSNotificationCenter defaultCenter] removeObserver:obUIKeyboardWillChangeFrameNotification];
    //    obUIKeyboardWillShowNotification = nil;
    obUIKeyboardWillChangeFrameNotification = nil;
}

@end
