//
//  LITTriggerCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

#import "LITTriggerCell.h"
#import "LITCell+Borders.h"
#import "AGUIDefine.h"

@interface LITTriggerCell(){

}



@end

@implementation LITTriggerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedViewController:associatedViewController indexPath:indexPath];
    if (self){
        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

#pragma mark - 

- (void)didTapAny:(id)sender{
    [self sendActionRequestToViewController:nil];
}

#pragma mark - styles

- (CGFloat)valueW{
    return (STYLE_DEVICE_WIDTH/3.0)*2.0 - self.paddingLR - self.paddingLR;
}
@end
