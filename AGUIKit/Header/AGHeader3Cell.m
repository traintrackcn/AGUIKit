//
//  AGHeader3Cell.m
//  AboveGEM
//
//  Created by traintrackcn on 28/12/14.
//
//

#import "AGHeader3Cell.h"
#import "AGStyleCoordinator.h"

@implementation AGHeader3Cell

+ (CGFloat)height{
    return 60;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [titleLabel setFont:[AGStyleCoordinator fontHeader3]];
        [self setBackgroundColor:[AGStyleCoordinator colorBackgroundCommission]];
    }
    return self;
}



#pragma mark -
- (void)setValue:(id)value{
    [super setValue:value];
}

@end
