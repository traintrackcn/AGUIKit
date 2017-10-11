//
//  LITTriggerCellLongValue.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

#import "LITTriggerCellLongValue.h"
#import "LITCell+Borders.h"

@interface LITTriggerCellLongValue(){
}

@end

@implementation LITTriggerCellLongValue

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedViewController:associatedViewController indexPath:indexPath];
    if (self) {
        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)didTapAny:(id)sender{
    [self sendActionRequestToViewController:nil];
}

@end
