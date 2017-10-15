//
//  LITCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 24/08/2017.
//
//

#import "LITCell.h"
#import "AGUIDefine.h"
#import "AGObjectPool.h"
#import "LITVC.h"

@interface LITCell ()

@end

@implementation LITCell


- (id)init{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ Failed to call designated initializer. Invoke `initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie:` instead.", NSStringFromClass([self class])] userInfo:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAssociatedVC:associatedVC];
        [self setIndexPath:indexPath];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)didTapAny:(id)sender{
}

#pragma mark - setters

- (void)_setValue:(id)value{
    _value = value;
}

- (void)_setTitle:(id)title{
    _title = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    //    TLOG(@"selected -> %@", @(selected));
    [super setSelected:selected animated:animated];
    if (selected) {
        [self applySelectedStyle];
    }else{
        [self applyUnselectedStyle];
    }
}

#pragma mark - utils

- (void)reload{
    [self.associatedVC reloadIndexPath:self.indexPath];
}

- (void)setValueForViewController:(id)value{
    [self.associatedVC setValue:value atIndexPath:self.indexPath];
}

- (NSArray *)parametersFromViewController{
    id obj = [self.associatedVC parameterAtIndexPath:self.indexPath];
    if (!obj) return @[];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    
    return @[obj];
}

- (void)sendActionRequestToViewController:(id)action{
    //    TLOG(@"_associatedViewController -> %@", _associatedViewController);
    //    TLOG(@"action -> %@", action);
    [self.associatedVC action:action atIndexPath:self.indexPath];
}

#pragma mark - properties

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}

- (AGObjectPool *)objPoolOfAssociatedVC{
    return [self.associatedVC objPool];
}

- (LITCellCharacter *)character{
    return self.parametersFromViewController.firstObject;
}

- (UITableView *)tableView{
    return [self.associatedVC tableView];
}

#pragma mark - styles

+ (CGFloat)height{
    return 44.0;
}

- (void)setHeight:(CGFloat)height{
    [self.associatedVC setCellHeight:height atIndexPath:self.indexPath];
}

- (CGFloat)height{
    return [self.associatedVC cellHeightAtIndexPath:self.indexPath];
}

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (void)applySelectedStyle{
    
}



@end
