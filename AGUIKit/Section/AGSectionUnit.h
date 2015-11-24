//
//  AGSection.h
//  AboveGEM
//
//  Created by traintrackcn on 15/1/15.
//
//

#import <Foundation/Foundation.h>

@class AGVCConfiguration;
@class AGViewController;

@interface AGSectionUnit : NSObject

+ (instancetype)instanceWithSection:(NSInteger)section config:(AGVCConfiguration *)config;
- (instancetype)initWithSection:(NSInteger)section config:(AGVCConfiguration *)config;

- (void)setValue:(id)value atIndex:(NSInteger)index;
- (id)valueAtIndex:(NSInteger)index;
- (id)paramterAtIndex:(NSInteger)index;
- (void)action:(id)action atIndex:(NSInteger)index;
- (NSInteger)numberOfRows;
- (void)didSelect:(NSInteger)index;

- (id)headerValue;
//- (Class)headerClass;
@property (nonatomic, weak) AGVCConfiguration *config;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL readonly;
@property (nonatomic, weak) AGViewController *associatedViewController;

@end
