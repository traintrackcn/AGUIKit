//
//  AGCommissionEarningsViewController.m
//  AboveGEM
//
//  Created by traintrackcn on 11/12/14.
//
//

#import "AGTabBarViewController.h"
#import "AGCollectionViewCellValue.h"
#import "AGTabBarCell.h"
#import "AGHorizontalViewControllersCell.h"
#import "DSDeviceUtil.h"
#import "DSValueUtil.h"
#import "AGAssembler.h"
#import "AGVCConfiguration.h"

typedef NS_ENUM(NSInteger, Section) {
    SectionTabBar,
    SectionContent,
    SectionCount
};

@interface AGTabBarViewController (){
    
    
}

@end

@implementation AGTabBarViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self.config setCellCls:[AGTabBarCell class] inSection:SectionTabBar];
        [self.config setCellCls:[AGHorizontalViewControllersCell class] inSection:SectionContent];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateContentCellH{
    CGFloat cellH = [DSDeviceUtil bounds].size.height - AG_STATUS_BAR_HEIGHT - AG_NAVIGATION_BAR_HEIGHT ;
    
    if ([self isSectionTabBarAvailable]) {
        cellH -= [AGTabBarCell height];
    }
    
    [self.config setCellHeight:cellH atFirstIndexPathInSection:SectionContent];
}


- (void)willReloadVisibleIndexPaths{
    [self updateContentCellH];
}

#pragma mark - table view stuff

- (NSArray *)titleItems{
    if ([DSValueUtil isNotAvailable:_titleItems]) {
        return titleValueArr;
    }
    return _titleItems;
}

- (NSArray *)contentItems{
    if ([DSValueUtil isNotAvailable:_contentItems]) {
        return contentValueArr;
    }
    return _contentItems;
}

- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    id value;
    
    if (section == SectionTabBar){
        value = self.titleItems;
    }
    
    if (section == SectionContent) {
        value = self.contentItems;
    }
    
    return value;
}

- (NSInteger)numberOfSections{
    return SectionCount;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section == SectionTabBar) {
        if ([self isSectionTabBarAvailable]) return 1;
    }
    if (section == SectionContent) return 1;
    return 0;
}

#pragma mark - 

- (BOOL)isSectionTabBarAvailable{
    if(titleValueArr && titleValueArr.count>1) return YES;
    return NO;
}

#pragma mark - events

- (void)tabBarDidChangeToIndex:(NSInteger)index{
    [self.contentCell selectIndexAndScrollToIndex:index];
}

- (void)contentDidChangeToIndex:(NSInteger)index{
    [self.tabBarCell selectIndexWithoutDispatchingDidSelect:index];
}

#pragma mark - AGCellDelegate

- (void)cellRequestAction:(id)action atIndexPath:(NSIndexPath *)indexPath{
    //    TLOG(@"action -> %@", action);
    NSInteger section = indexPath.section;
//    NSString *type = [action objectForKey:@"type"];
    AGCollectionViewCellValue *value = [action objectForKey:@"value"];
    
    if (section == SectionContent){
        //        TLOG(@"make tab bar cell sync")
        [self contentDidChangeToIndex:value.index];
    }
    
    if (section == SectionTabBar){
        //        TLOG(@"make VCs cell sync");
        [self tabBarDidChangeToIndex:value.index];
    }
    
}


#pragma mark - properties

- (AGHorizontalViewControllersCell *)contentCell{
    return (AGHorizontalViewControllersCell *)[self cellAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SectionContent]];
}

- (AGTabBarCell *)tabBarCell{
    return (AGTabBarCell *)[self cellAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SectionTabBar]];
}

@end
