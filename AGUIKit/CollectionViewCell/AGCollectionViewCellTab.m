//
//  AGCollectionViewCellTabBar.m
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

#import "AGCollectionViewCellTab.h"
#import "AGCollectionViewCellValue.h"
#import "AGStyleCoordinator.h"
#import "DSValueUtil.h"
#import "DSImage.h"

@interface AGCollectionViewCellTab(){
    
}

@property (nonatomic, strong) UIImageView *pointIconView;

@end

@implementation AGCollectionViewCellTab


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self assembleTitle];
        [self addSubview:self.pointIconView];
        [self setBackgroundColor:[AGStyleCoordinator colorTabBarCellBackgroundNormal]];
    }
    return self;
}


#pragma mark - assemblers

- (void)assembleTitle{
    if ([DSValueUtil isAvailable:titleL]) return;
    CGFloat spacing = 0;
    CGFloat x = spacing;
    CGFloat y = spacing;
    CGFloat w = self.frame.size.width - spacing*2;
    CGFloat h = self.frame.size.height - spacing *2;
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [titleL setNumberOfLines:0];
    
    //    [titleL setLineBreakMode:NSLineBreakByWordWrapping];
    [titleL setTextAlignment:NSTextAlignmentCenter];
    [titleL setClipsToBounds:YES];
//    [titleL.layer setCornerRadius:4.0];
    [titleL setAdjustsFontSizeToFitWidth:YES];
    [titleL setBackgroundColor:[AGStyleCoordinator colorTabBarCellBackgroundNormal]];
//    [titleL.layer setBorderColor:[AGStyleCoordinator colorOptionCellBorder].CGColor];
    [self.contentView addSubview:titleL];
}

- (UIImageView *)pointIconView{
    if ([DSValueUtil isNotAvailable:_pointIconView]) {
        CGFloat h = 10;
        CGFloat w = 16;
        CGFloat y = self.frame.size.height - h;
        CGFloat x = (self.frame.size.width - w)/2.0;
        _pointIconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        UIImage *img = [DSImage triangleWithSize:CGSizeMake(w, h) fillColor:[UIColor whiteColor]];
        [_pointIconView setImage:img];
//        [AGDebugUtil makeBorderForView:_pointIconView];
    }
    return _pointIconView;
}

#pragma mark -

- (void)setSelected:(BOOL)selected{
    if (selected) {
        [titleL setFont:[AGStyleCoordinator fontTabBarTitleHighlight]];
        [titleL setTextColor:[AGStyleCoordinator colorTabBarCellTitleHighlight]];
        [self.pointIconView setHidden:NO];
    }else{
        [titleL setFont:[AGStyleCoordinator fontTabBarTitleNormal]];
        [titleL setTextColor:[AGStyleCoordinator colorTabBarCellTitleNormal]];
        [self.pointIconView setHidden:YES];
    }
}



#pragma mark -

- (void)setValue:(id)aValue{
    [super setValue:aValue];
//    TLOG(@"value -> %@", self.value);
    [titleL setText:[DSValueUtil toString:[(AGCollectionViewCellValue *)self.value value]].uppercaseString];
}


@end
