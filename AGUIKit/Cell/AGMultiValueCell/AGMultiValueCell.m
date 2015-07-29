//
//  AGTextCellStyleMultiValues.m
//  AboveGEM
//
//  Created by traintrackcn on 31/12/14.
//
//

#import "AGMultiValueCell.h"
#import "AGMultiValueView.h"
#import "AGMultiValueCellSynchronizer.h"
#import "AGCollectionViewCellValue.h"
#import "DSValueUtil.h"
#import "DSDeviceUtil.h"

NSString *AGMultiValueCellContentOffsetDidChange = @"AGMultiValueCellContentOffsetDidChange";

@interface AGMultiValueCell()<AGMultiValueViewDelegate>{
    
}

@end

@implementation AGMultiValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self assemble];
    }
    return self;
}

- (void)applySelectedStyle{
    
}


#pragma mark - assemblers

- (void)assemble{
    [self.multiValueView setDelegate:self];
    [self.contentView addSubview:self.multiValueView];
    
    
    [self assembleBottomBorder];
}

#pragma mark - properties

- (AGMultiValueView *)multiValueView{
    if ([DSValueUtil isNotAvailable:_multiValueView]) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = [DSDeviceUtil bounds].size.width;
        CGFloat h = self.height;
        _multiValueView = [[AGMultiValueView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
    }
    return _multiValueView;
}

#pragma mark - setter

- (void)setValue:(id)value{
    if (![value isKindOfClass:[NSArray class]]) return;
    [super setValue:value];
    [self.multiValueView setItems:(NSArray *)value];
    
    AGMultiValueCellSynchronizer *s = self.parameters.firstObject;
    if ([DSValueUtil isAvailable:s]){
        [self.multiValueView setContentOffset:s.contentOffset];
    }
    
    [self.multiValueView reloadData];
    
}

#pragma mark - 

- (void)multiValueViewContentOffsetDidChange:(CGPoint)contentOffset{
//    TLOG(@"");
    NSDictionary *action = @{@"type":AGMultiValueCellContentOffsetDidChange,@"value":[NSValue valueWithCGPoint:contentOffset]};
    [self dispatchRequestAction:action];
}

#pragma mark - cell item assembler

+ (NSMutableArray *)assembleItemWithValues:(NSArray *)values{
    NSMutableArray *item = [NSMutableArray array];
    for (NSInteger column = 0; column < values.count; column ++) {
        AGCollectionViewCellValue *value = [AGCollectionViewCellValue instance];
        [value setIndex:column];
        [value setValue:[values objectAtIndex:column]];
        [item addObject:value];
        
        if (column == 0){
            [value setTextAlignment:NSTextAlignmentLeft];
        }else{
            [value setTextAlignment:NSTextAlignmentRight];
        }
    }
    return item;
}

@end
