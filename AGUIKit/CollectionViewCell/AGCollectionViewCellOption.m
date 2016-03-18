//
//  AGFilterCollectionViewCell.m
//  AboveGEM
//
//  Created by traintrackcn on 30/10/14.
//
//

#import "AGCollectionViewCellOption.h"
#import "AGStyleCoordinator.h"
#import "DSValueUtil.h"

@implementation AGCollectionViewCellOption

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self assembleTitle];
//        [self setBackgroundColor:[AGStyleCoordinator colorBackgroundNormal]];
    }
    return self;
}


#pragma mark - assemblers

- (void)assembleTitle{
    if (titleL) return;
    CGFloat spacing = 4.0;
    CGFloat x = spacing;
    CGFloat y = spacing;
    CGFloat w = self.frame.size.width - spacing*2;
    CGFloat h = self.frame.size.height - spacing *2;
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [titleL setNumberOfLines:0];
    [titleL setFont:[UIFont systemFontOfSize:12]];
//    [titleL setLineBreakMode:NSLineBreakByWordWrapping];
    [titleL setTextAlignment:NSTextAlignmentCenter];
    [titleL setClipsToBounds:YES];
    [titleL.layer setCornerRadius:4.0];
    [titleL setAdjustsFontSizeToFitWidth:YES];
    [titleL.layer setBorderColor:[AGStyleCoordinator colorOptionCellBorder].CGColor];
    [self.contentView addSubview:titleL];
}


- (void)setSelected:(BOOL)selected{
    if (selected) {
        [titleL.layer setBorderWidth:0];
        [titleL setBackgroundColor:[AGStyleCoordinator colorOptionCellBackgroundSelected]];
        [titleL setTextColor:[AGStyleCoordinator colorOptionCellTitleSelected]];
    }else{
        [titleL.layer setBorderWidth:1];
        [titleL setBackgroundColor:[AGStyleCoordinator colorOptionCellBackgroundNormal]];
        [titleL setTextColor:[AGStyleCoordinator colorOptionCellTitleNormal]];
    }
}



#pragma mark -

- (void)setValue:(id)value{
    [titleL setText:[DSValueUtil toString:value]];
}

@end
