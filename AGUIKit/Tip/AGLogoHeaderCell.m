//
//  AGBigHeaderCell.m
//  AboveGEM
//
//  Created by traintrackcn on 8/12/14.
//
//

#import "AGLogoHeaderCell.h"
#import "NSString+AGUtils.h"
#import "DSDeviceUtil.h"
#import "AGStyleCoordinator.h"

@interface AGLogoHeaderCell(){
    UILabel *titleLabel;
}

@end

@implementation AGLogoHeaderCell

+ (CGFloat)height{
    return 75;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assembleTitleView];
    }
    return self;
}


- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

- (void)assembleTitleView{
    
    CGRect bounds = [DSDeviceUtil bounds];
    //    CGFloat titleH = 40;
    CGFloat x = self.paddingLR;
    CGFloat w = bounds.size.width-x*2;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w ,self.class.height)];
    
//    [titleLabel setFont:[AGStyleCoordinator fontLoginHeaderCell]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setNumberOfLines:0];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [titleLabel setAdjustsFontSizeToFitWidth:YES];
//    [AGDebugUtil makeBorderForView:titleLabel];
    //    [titleLabel setBackgroundColor:[UIColor redColor]];
    //    [titleLabel.layer setBorderWidth:1.0];
 
    
    CALayer *layer = titleLabel.layer;
    [layer setShadowColor:[[UIColor blackColor] CGColor]];
    [layer setShouldRasterize:YES];
    [layer setShadowRadius:3];
    [layer setShadowOffset:CGSizeMake(0, 0)];
    [layer setShadowOpacity:.7];
    
//    layer.shadowPath = [UIBezierPath bezierPathWithRect:titleLabel.bounds].CGPath;
    
    [self.contentView addSubview:titleLabel];
}

- (void)setValue:(id)value{
    
    if (![value isKindOfClass:[NSString class]]) return;
//    NSString *key = @"\\n";
//    NSString *text = [value stringByReplacingOccurrencesOfString:key withString:@"\n"];
    NSString *text = [value stringByReplacingBackslashN];
//    TLOG(@"text -> %@", text);
    
    NSInteger brIdx = [text rangeOfString:@"\n"].location;
    NSArray *textArr = [text componentsSeparatedByString:@"\n"];
    NSString *subtitle = textArr.lastObject;
//    TLOG(@"brIdx -> %d", brIdx);
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor whiteColor],
                              NSFontAttributeName: [AGStyleCoordinator fontLoginHeaderCellTitle]
                              };
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    [attributedText setAttributes:@{
                                    NSFontAttributeName: [AGStyleCoordinator fontLoginHeaderCellSubtitle]
                                    } range:NSMakeRange(brIdx, subtitle.length+1)];
    
    
    [titleLabel setAttributedText:attributedText];
//    [titleLabel setText:text];
//    [titleLabel setText:@"sdf\ndsf"];
}

@end
