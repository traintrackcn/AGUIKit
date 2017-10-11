//
//  LITTextFieldCellFormPassword.m
//  AboveGEM
//
//  Created by Tao Yunfei on 22/09/2017.
//
//

#import "LITTextFieldCellFormPassword.h"

@implementation LITTextFieldCellFormPassword

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedViewController:associatedViewController indexPath:indexPath];
    if (self) {
        TLOG(@"textF -> %@", self.textF);
        [self.textF setSecureTextEntry:YES];
    }
    return self;
}

@end
