//
//  AGTextBoxCell.m
//  AboveGEM
//
//  Created by traintrackcn on 9/10/14.
//
//

#import "AGTextfieldBoxCell.h"

@implementation AGTextfieldBoxCell

#pragma mark - 

+ (CGFloat)height{
    return 160.0;
}

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    [self setInputIsBox:YES];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

@end
