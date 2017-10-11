//
//  LITTextFieldConfig.h
//  AboveGEM
//
//  Created by Tao Yunfei on 22/08/2017.
//
//

#import "AGModel.h"

@interface LITCellCharacter : AGModel

@property (nonatomic, assign) BOOL atFirst;
@property (nonatomic, assign) BOOL atLast;

@property (nonatomic, assign) BOOL borderBottomPaddingL;
@property (nonatomic, assign) BOOL borderBottom;
@property (nonatomic, assign) BOOL borderTop;

@property (nonatomic, strong) id userInfo;

@end
