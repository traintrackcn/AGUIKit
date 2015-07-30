//
//  AGFormInput.m
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCell.h"
#import "AGVCConfiguration.h"
#import "AGViewController.h"
#import "AGStyleCoordinator.h"
#import "DSValueUtil.h"
#import "NSObject+Singleton.h"
#import "DSDeviceUtil.h"
#import "AGUIDefine.h"
#import "GlobalDefine.h"

@implementation AGCell


@synthesize height = _height;

- (id)init{
   @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ Failed to call designated initializer. Invoke `initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie:` instead.", NSStringFromClass([self class])] userInfo:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor clearColor]];
        [self assemble];
    }
    return self;
}



- (void)dealloc{
    [_remoter cancelAllRequests];
}

#pragma mark - properties

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self applySelectedStyle];
    }else{
        [self applyUnselectedStyle];
    }
}

- (void)applySelectedStyle{
    [self setBackgroundColor:[AGStyleCoordinator colorForKey:@"cell-background-selected"]];
    self.textLabel.textColor = [AGStyleCoordinator colorForKey:@"cell-title-selected"];
    self.detailTextLabel.textColor = [AGStyleCoordinator colorForKey:@"cell-content-selected"];
}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:[AGStyleCoordinator colorForKey:@"cell-background-unselected"]];
    self.textLabel.textColor = [AGStyleCoordinator colorForKey:@"cell-title-unselected"];
    self.detailTextLabel.textColor = [AGStyleCoordinator colorForKey:@"cell-content-unselected"];
}

#pragma mark - properties

- (AGRemoter *)remoter{
    if ([DSValueUtil isNotAvailable:_remoter]) {
        _remoter = [AGRemoter instanceWithDelegate:self];
    }
    return _remoter;
}

- (UITableView *)tableView{
    if ([self.associatedViewController isKindOfClass:[AGViewController class]]) {
        return [(AGViewController *)self.associatedViewController tableView];
    }
    return nil;
}

- (void)endEditingForAssociatedView{
    [[(AGViewController *)self.associatedViewController view] endEditing:YES];
}

- (AGVCConfiguration *)config{
    AGViewController *vc = (AGViewController *)self.associatedViewController;
    if (!vc) return nil;
    return vc.config;
}

- (void)setValue:(id)value{
    _value = value;
}

- (BOOL)isCachedValueSameAsTargetValue:(id)targetValue{
    if (self.value){
        if ([targetValue isEqual:self.value]) {
//            TLOG(@"[%@] setting same value", NSStringFromClass(self.class));
            return YES;
        }
    }
    return NO;
}

#pragma mark - assemblers

- (void)assemble{
    
}

- (void)assembleGC{
    UITapGestureRecognizer *gc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCell)];
    [self addGestureRecognizer:gc];
}

- (void)assembleBottomBorder{
    CGFloat x = self.paddingLR;
    CGFloat y = [self.class height] - 1;
    CGFloat w = [DSDeviceUtil bounds].size.width - self.paddingLR;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, 1)];
    [self.contentView addSubview:v];
    [v setBackgroundColor:[AGStyleCoordinator colorCellBorder]];
}

#pragma mark - interactive actions

- (void)didTapCell{
//    [self dispatchRequestSetCurrentIndexPath];
    [self activateSelector];
}

- (void)activateSelector{
    AGViewController *vc = self.associatedViewController;
    [vc.view endEditing:YES];
}

#pragma mark - view controller actions

- (void)pushViewController:(UIViewController *)viewController fromNaviC:(UINavigationController *)naviC{
    AGViewController *vc = self.associatedViewController;
//    TLOG(@"vc -> %@", vc);
    [vc.view endEditing:YES];
    [naviC pushViewController:viewController animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController{
    UINavigationController *naviC = (UINavigationController *)[[self associatedViewController] parentViewController ];
//    TLOG(@"naviC -> %@", naviC);
    if ([DSValueUtil isAvailable:naviC]){
        [self pushViewController:viewController fromNaviC:naviC];
    }else{
        [self pushViewController:viewController fromNaviC:[AGUIDefine singleton].rootViewController];
    }
    
}


#pragma mark - dispatchers

- (void)dispatchRequestReloadIndexPath{
    if (_associatedViewController) {
        [_associatedViewController cellRequestReloadIndexPath:self.indexPath];
    }
}

//- (void)dispatchRequestSetCurrentIndexPath{
//    if (_associatedViewController) {
//        [_associatedViewController cellRequestSetCurrentIndexPath:self.indexPath];
//    }
//}

- (void)dispatchRequestSetValue:(id)value{
    if (_associatedViewController) {
        [_associatedViewController cellRequestSetValue:value atIndexPath:self.indexPath];
    }
}

//- (id)dispatchRequestValue{
//    if (_associatedViewController) {
//        return [_associatedViewController cellRequestValueAtIndexPath:self.indexPath];
//    }
//    return nil;
//}

- (id)dispatchRequestParameters{
//    TLOG(@"_associatedViewController -> %@", _associatedViewController);
    if (_associatedViewController) {
        return [_associatedViewController cellRequestParameterAtIndexPath:self.indexPath];
    }
    
    return nil;
}

- (NSArray *)parameters{
    id obj = [self dispatchRequestParameters];
    
//    TLOG(@"obj -> %@ %@", obj, self.indexPath);
    
    if ([DSValueUtil isNotAvailable:obj]) {
        return @[];
    }
    
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    
    return @[obj];
}

- (void)dispatchRequestAction:(id)action{
    if (_associatedViewController && [_associatedViewController respondsToSelector:@selector(cellRequestAction:atIndexPath:)]) {
        [_associatedViewController cellRequestAction:action atIndexPath:self.indexPath];
    }
}

#pragma mark - AGRemoterDelegate

- (void)remoterDataReceived:(id)responseData withRequestData:(DSRequest *)request{
    
}


#pragma mark - style block components for decorating

- (UIView *)backgroundViewStyleBlock{
    if (!_backgroundViewStyleBlock) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = [DSDeviceUtil bounds].size.width - self.paddingLR*2;
        CGFloat h = self.height;
        _backgroundViewStyleBlock = [[UIView alloc] init];
        [_backgroundViewStyleBlock setFrame:CGRectMake(x, y, w, h)];
    }
    return _backgroundViewStyleBlock;
}

- (UIView *)borderTopViewStyleBlock{
    if (!_borderTopViewStyleBlock) {
        CGFloat x = self.paddingLR;
        CGFloat w = [DSDeviceUtil bounds].size.width-x*2;
        _borderTopViewStyleBlock = [[UIView alloc] initWithFrame:CGRectMake(x, -1, w, 1)];
        [_borderTopViewStyleBlock setBackgroundColor:self.borderColor];
    }
    return _borderTopViewStyleBlock;
}



- (UIView *)borderBottomViewStyleBlock{
    
    if (!_borderBottomViewStyleBlock) {
        CGFloat x = self.paddingLR;
        CGFloat w = [DSDeviceUtil bounds].size.width-x*2;
        _borderBottomViewStyleBlock = [[UIView alloc] initWithFrame:CGRectMake(x, [self.class height] - 1, w, 1)];
        [_borderBottomViewStyleBlock setBackgroundColor:self.borderColor];
    }
    
    return _borderBottomViewStyleBlock;
}

- (UIView *)borderLeftViewStyleBlock{
    if (!_borderLeftViewStyleBlock) {
        CGFloat x= self.paddingLR;
        _borderLeftViewStyleBlock = [[UIView alloc] initWithFrame:CGRectMake(x, 0, self.borderWidth, [self.class height])];
        [_borderLeftViewStyleBlock setBackgroundColor:self.borderColor];
//        [AGDebugUtil makeBorderForView:_borderLeftViewStyleBlock];
    }
    
    return _borderLeftViewStyleBlock;
}

- (UIView *)borderRightViewStyleBlock{
    if (!_borderRightViewStyleBlock) {
        CGFloat x = [DSDeviceUtil bounds].size.width-self.paddingLR-self.borderWidth;
        _borderRightViewStyleBlock = [[UIView alloc] initWithFrame:CGRectMake(x, 0, self.borderWidth, [self.class height])];
        [_borderRightViewStyleBlock setBackgroundColor:self.borderColor];
        
    }
    
    return _borderRightViewStyleBlock;
}


//solid

- (UIView *)borderTopViewStyleSolid{
    if (!_borderTopViewStyleSolid) {
        _borderTopViewStyleSolid = [self assembleBorderView];
        CGRect frame = CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, self.borderWidth);
        [_borderTopViewStyleSolid setFrame:frame];
    }
    return _borderTopViewStyleSolid;
}

- (UIView *)borderBottomViewStyleSolid{
    
    if (!_borderBottomViewStyleSolid) {
        _borderBottomViewStyleSolid = [self assembleBorderView];
        [self layoutBorderBottomViewStyleSolid];
    }
    
    return _borderBottomViewStyleSolid;
}

- (void)layoutBorderBottomViewStyleSolid{
    CGRect frame = CGRectMake(0, self.height - self.borderWidth, [DSDeviceUtil bounds].size.width, self.borderWidth);
    [_borderBottomViewStyleSolid setFrame:frame];
}


- (UIView *)borderBottomViewStylePaddingLR{
    if (!_borderBottomViewStylePaddingLR) {
        _borderBottomViewStylePaddingLR = [self assembleBorderView];
        CGFloat y = [self.class height] - self.borderWidth;
        CGFloat x = self.paddingLR;
        CGFloat w = [DSDeviceUtil bounds].size.width - x*2;
        CGFloat h = self.borderWidth;
        CGRect frame = CGRectMake(x, y, w, h);
        [_borderBottomViewStylePaddingLR setFrame:frame];
    }

    return _borderBottomViewStylePaddingLR;
}


- (UIView *)assembleBorderView{
    UIView *borderView = [[UIView alloc] init];
    [borderView setBackgroundColor:self.borderColor];
    return borderView;
}

- (UIView *)borderViewInstance{
    return [self assembleBorderView];
}

#pragma mark - styles

- (void)setHeight:(CGFloat)height{
    _height = height;
    CGFloat h = [self.config cellHeightAtIndexPath:self.indexPath];
    TLOG(@"h -> %f height -> %f", h, height);
    if (h != height) {
        [self.config setCellHeight:height atIndexPath:self.indexPath];
        
//        if (![DSDeviceUtil iOS8AndAbove]) {
            [self.associatedViewController reloadVisibleIndexPaths];
//        }
        
    }
}

+ (CGFloat)height{
    return 44.0;
}

- (CGFloat)height{
    if (_height) return _height;
    return [self.class height];
}

- (UIColor *)borderColor{
    return [AGStyleCoordinator colorCellBorder];
}

- (CGFloat)paddingLR{
    return 8.0;
}

- (CGFloat)paddingTB{
    return 6.0;
}

- (CGFloat)borderWidth{
    return .5f;
}

@end
