//
//  AGHeader.h
//  AboveGEM
//
//  Created by traintrackcn on 21/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGHeaderView : UIView{

}

#pragma mark - components
- (UITableView *)tableView;
@property (nonatomic, strong) UIView *borderBottomView;

#pragma mark - styles
+ (CGFloat)height;
@property (nonatomic, assign) CGFloat paddingLR;

#pragma mark - properties
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) id value;

@end
