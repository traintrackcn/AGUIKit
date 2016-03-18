//
//  AGQuantityPickerView.m
//  AboveGEM
//
//  Created by traintrackcn on 18/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGQuantityPickerView.h"
#import "DSValueUtil.h"
#import "AGStyleCoordinator.h"
#import "GlobalDefine.h"

@interface AGQuantityPickerView(){
    
}

@property (nonatomic, assign) CGSize componentSize;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UILabel *quantityLabel;

@end

@implementation AGQuantityPickerView

+ (instancetype)instanceWithValue:(NSInteger)value{
    AGQuantityPickerView *instance = [[AGQuantityPickerView alloc]  initWithFrame:CGRectMake(0, 0, 120, 40)];
    [instance setMinValue:AG_MIN_QUANTITY];
    [instance setMaxValue:AG_MAX_QUANTITY];
    [instance setValue:value];
    return instance;
}

+ (instancetype)instanceWithValue:(NSInteger)value maxValue:(NSInteger)maxValue{
    AGQuantityPickerView *instance = [[AGQuantityPickerView alloc]  initWithFrame:CGRectMake(0, 0, 120, 40)];
    [instance setMinValue:AG_MIN_QUANTITY];
    [instance setMaxValue:maxValue];
    [instance setValue:value];
    return instance;
}

+ (instancetype)instanceWithValue:(NSInteger)value minValue:(NSInteger)minValue{
    AGQuantityPickerView *instance = [[AGQuantityPickerView alloc]  initWithFrame:CGRectMake(0, 0, 120, 40)];
    [instance setMinValue:minValue];
    [instance setMaxValue:AG_MAX_QUANTITY];
    [instance setValue:value];
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self assemble];
        
        [self.layer setBorderWidth:1];
        [self.layer setCornerRadius:4.0];
        [self.layer setBorderColor:self.borderColor.CGColor];
    }
    return self;
}

#pragma mark - assemblers

- (void)assemble{
    [self addSubview:self.plusButton];
    [self addSubview:self.minusButton];
    [self addSubview:self.quantityLabel];
}

- (UIButton *)assembleButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [AGDebugUtil makeBorderForView:btn];
    return btn;
}

#pragma mark - properties

- (CGSize)componentSize{
    if (CGSizeEqualToSize(_componentSize, CGSizeZero)) {
        _componentSize = CGSizeMake(self.frame.size.width/3.0, self.frame.size.height);
    }
    return _componentSize;
}

- (UIButton *)plusButton{
    if (!_plusButton) {
        _plusButton = [self assembleButtonWithTitle:@"+" target:self action:@selector(didTapPlusButton:)];
        [_plusButton setFrame:CGRectMake(self.componentSize.width*2, 0, self.componentSize.width, self.componentSize.height)];
        [self decorateButton:_plusButton];
        
//        [_plusButton setTitleColor:self.borderColor forState:UIControlStateDisabled];
//        [_plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _plusButton;
}

- (UIButton *)minusButton{
    if ([DSValueUtil isNotAvailable:_minusButton]) {
        _minusButton = [self assembleButtonWithTitle:@"-" target:self action:@selector(didTapMinusButton:)];
        [_minusButton setFrame:CGRectMake(0, 0, self.componentSize.width, self.componentSize.height)];
//        [_minusButton setTitleColor:self.borderColor forState:UIControlStateDisabled];
        
        [self decorateButton:_minusButton];
    }
    return _minusButton;
}

- (void)decorateButton:(UIButton *)btn{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:self.borderColor forState:UIControlStateDisabled];
}

- (UILabel *)quantityLabel{
    if ([DSValueUtil isNotAvailable:_quantityLabel]) {
        _quantityLabel = [[UILabel alloc] init];
        [_quantityLabel setTextAlignment:NSTextAlignmentCenter];
        [_quantityLabel setFrame:CGRectMake(self.componentSize.width, 0, self.componentSize.width, self.componentSize.height)];
        [_quantityLabel setFont:[UIFont systemFontOfSize:16]];
        _quantityLabel.layer.borderWidth = 1;
        _quantityLabel.layer.borderColor = self.borderColor.CGColor;
    }
    return _quantityLabel;
}

- (NSInteger)value{
    return [DSValueUtil toInteger:_quantityLabel.text];
}

- (void)setValue:(NSInteger)value{
    [_quantityLabel setText:[NSString stringWithFormat:@"%ld",(long)value]];
}

#pragma mark - 

- (void)setMaxValue:(NSInteger)maxValue{
    _maxValue = maxValue;
    [self updateButtonStatus];
}

- (void)setMinValue:(NSInteger)minValue{
    _minValue = minValue;
    [self updateButtonStatus];
}

#pragma mark -

- (void)updateButtonStatus{
    
    [self.minusButton setEnabled:YES];
    [self.plusButton setEnabled:YES];
    
    
    TLOG(@"maxValue -> %d minValue -> %d value -> %d", self.maxValue, self.minValue, self.value);
    
    if (self.maxValue == self.minValue) {
        [self.minusButton setEnabled:NO];
        [self.plusButton setEnabled:NO];
        return;
    }
    
    if (self.value == self.maxValue) {
        [self.plusButton setEnabled:NO];
        return;
    }
    
    if (self.value == self.minValue) {
        [self.minusButton setEnabled:NO];
        return;
    }
}

#pragma mark - styles

- (UIColor *)borderColor{
    return RGBA(214, 214, 214, 1);
}

#pragma mark - interactive actions

- (void)didTapPlusButton:(id)sender{
//    TLOG(@"");
    NSInteger valueOld = self.value;
    NSInteger valueNew = valueOld+1;
    if (valueNew > self.maxValue) valueNew = self.maxValue;
    
//    TLOG(@"value -> %d valueNew -> %d valueMax -> %d", valueOld, valueNew, self.maxValue);
    
    if (valueNew != self.value) {
        [self dispatchWillChangeValue:valueNew];
    }
    
    [self setValue:valueNew];
    [self updateButtonStatus];
    
}

- (void)didTapMinusButton:(id)sender{
    NSInteger valueOld = self.value;
    NSInteger valueNew = valueOld-1;
    if (valueNew < self.minValue) valueNew = self.minValue;
    
    if (valueNew != self.value) {
        [self dispatchWillChangeValue:valueNew];
    }
    [self setValue:valueNew];
    [self updateButtonStatus];
}

#pragma mark - 


- (void)dispatchWillChangeValue:(NSInteger)value{
    if (_delegate && [_delegate respondsToSelector:@selector(quantityPickerViewWillChangeValue:)]) {
        if ([_delegate quantityPickerViewWillChangeValue:value]) {
            [self dispatchDidChangeValue:value];
        }
    }
}

- (void)dispatchDidChangeValue:(NSInteger)value{
    if (_delegate && [_delegate respondsToSelector:@selector(quantityPickerViewDidChangeValue:)]) {
        [self setValue:value];
        [_delegate quantityPickerViewDidChangeValue:value];
    }
}

@end
