//
//  AGHorizontalTabsCell.m
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

#import "AGTabBarCell.h"
#import "AGCollectionViewCellTab.h"
#import "AGStyleCoordinator.h"

NSString *AGTabBarCellDidChange = @"AGTabBarCellDidChange";

@implementation AGTabBarCell


+ (CGFloat)height{
    return 44.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self assembleBottomBorder];
        [collectionV setBackgroundColor:self.backgroundColorValue];
    }
    return self;
}

- (Class)collectionViewCellCls{
    return [AGCollectionViewCellTab class];
}

- (void)didSelectItem:(id)item{
    NSDictionary *action = @{@"type":AGTabBarCellDidChange,@"value":item};
    [self dispatchRequestAction:action];
    
}

- (void)setValue:(id)value{
    [self setItems:value];
}

#pragma mark - styles

- (UIColor *)backgroundColorValue{
    return [AGStyleCoordinator colorTabBarCellBackgroundNormal];
}

@end
