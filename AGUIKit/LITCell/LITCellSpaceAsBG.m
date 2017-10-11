//
//  LITCellSpaceAsBG.m
//  AboveGEM
//
//  Created by Tao Yunfei on 21/09/2017.
//
//

#import "LITCellSpaceAsBG.h"
#import "AGUIDefine.h"

@implementation LITCellSpaceAsBG

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 

- (void)applySelectedStyle{

}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
}

@end
