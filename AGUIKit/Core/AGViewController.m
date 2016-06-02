//
//  AGFormBaseViewController.m
//  AboveGEM
//
//  Created by traintrackcn on 16/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGViewController.h"
#import "AGViewController+Message.h"
#import "AGViewController+Separator.h"
#import "AGViewController+LoginUI.h"


#import "AGCell.h"
#import "AGSeparatorCell.h"
#import "AGSectionUnit.h"
#import "AGHeaderViewStyleDefault.h"

#import "DSValueUtil.h"
#import "DSDeviceUtil.h"
#import "GlobalDefine.h"
#import "AGUIDefine.h"

#import "AGRemoterResultError.h"
#import "AGRemoterResult.h"




@interface AGViewController () <AGCellDelegate>{
    
}

@property (nonatomic, strong) UIView *subviewContainer; //overlay with fixed position
@property (nonatomic, assign) BOOL isSubviewContainerAdded;

@end

@implementation AGViewController

+ (instancetype)instance{
    return [[self.class alloc] init];
}

- (id)init{
    self = [super init];
    if (self) {
        [self setConfig:[AGVCConfiguration instance]];
        [self.config setTarget:self];
        animationDuration = .33;
        
    }
    return self;
}

#pragma mark - interactive ops

- (void)didTapView:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark - life cycle

- (void)viewDidLoad{
    TLOG(@"%@", self.className);
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (self.backgroundColor) [self.view setBackgroundColor:self.backgroundColor];
}

- (void)viewWillAppear:(BOOL)animated{
    TLOG(@"%@", self.className);
    [super viewWillAppear:animated];
    [self setNavigationController];
    [self subviewContainer]; //check to re-add subview container to superview
    
    if (self.flagDoReload) {
        [self willDoReload];
        [self setFlagDoReload:NO];
    }
    
}

- (void)viewWillLayoutSubviews{
//    TLOG(@"%@", self.className);
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
//    TLOG(@"%@", self.className);
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidAppear:(BOOL)animated{
    TLOG(@"%@", self.className);
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    TLOG(@"%@", self.className);
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    TLOG(@"%@", self.className);
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    TLOG(@"%@", self.className);
    [self clearFloatedMessage];
    [self.view.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self resetSubviewContainer];
}

#pragma mark - layout



- (void)layoutAccordingToTabBarController{
//    TLOG(@"self.parentViewController -> %@", self.parentViewController);
    if ([self.parentViewController isKindOfClass:[UITabBarController class]]) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        CGFloat top = contentInset.top;
        CGFloat bottom = STYLE_TAB_BAR_HEIGHT;
        [self.tableView setContentInset:UIEdgeInsetsMake(top, 0, bottom, 0)];
    }
}

#pragma mark - component

- (void)setNavigationController{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:YES];
}

- (UIView *)parentView{
//    TLOG(@"self.navigationController.view -> %@", self.navigationController.view.subviews);
//    return self.navigationController.view;
    TLOG(@"self.tableView.superview -> %@", self.tableView.superview);
    return self.tableView.superview;
}

- (void)addSubview:(UIView *)view{
    [self.subviewContainer addSubview:view];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    [self.subviewContainer setUserInteractionEnabled:userInteractionEnabled];
}

- (UIView *)subviewWithTag:(NSInteger)tag{
    return [self.subviewContainer viewWithTag:tag];
}

- (void)resetSubviewContainer{
    [_subviewContainer removeFromSuperview];
    _subviewContainer = nil;
}

- (AGCell *)dummyCellInstanceAtIndex:(NSInteger)index{
    AGCell *cell = [[AGCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    [cell setAssociatedViewController:self];
    [cell setIndexPath:[NSIndexPath indexPathForRow:index inSection:SectionDummy]];
    return cell;
}

- (AGCell *)cellForIndexPath:(NSIndexPath *)indexPath{
    Class cls = [self.config cellClsOfIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    NSString *cellId = NSStringFromClass(cls);
    
    if (self.cacheEveryCell) {
        cellId = [NSString stringWithFormat:@"%@-%ld-%ld",NSStringFromClass(cls), (long)idx,(long)section];
    }
    
    AGCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    id value = [self valueAtIndexPath:indexPath];
    @try {
        if (!cell) {
            cell = [[cls alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            [cell setAssociatedViewController:self];
        }
        
        NSInteger numberOfRows = [self numberOfRowsInSection:section];
        BOOL bLastRow = (idx+1 == numberOfRows)?YES:NO;
        BOOL bFirstRow = idx == 0?YES:NO;
        
        [cell setIndexPath:indexPath];
        [cell setIsLastRow:bLastRow];
        [cell setIsFirstRow:bFirstRow];
        [cell setTitle: [self.config cellTitleOfIndexPath:indexPath] ];
        [cell setIsOptional: [self.config isCellOptionalAtIndexPath: indexPath ] ];
        [cell setValue:value];
    }@catch (NSException *exception) {
        TLOG(@"%@ exception -> %@ %@",cell.class, exception,value);
    }
    
    return cell;
}

- (AGCell *)cellForException{
    return [[AGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AGCell class])];
}

- (UIView *)headerForSection:(NSInteger)section{
    Class cls = [self.config headerClsOfSection:section];
    id value = nil;
    //    NSInteger rows = [self numberOfRowsInSection:section];
    
    @try {
        value = [self valueForHeaderOfSection:section];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    }
    
    //    TLOG(@"cls -> %@ value -> %@", cls, value);
    
    if (value){
        AGHeaderView *v = [[cls alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, [cls height])];
        [v setAssociatedViewController:self];
        [v setSection:section];
        [v setValue:value];
        return v;
    }
    
    return [self dummyHeaderView];
}

- (UIView *)dummyHeaderView{
    if (!_dummyHeaderView) {
        _dummyHeaderView = [[UIView alloc] init];
    }
    return _dummyHeaderView;
}

- (UIView *)subviewContainer{
    if (!_subviewContainer) {
        CGFloat y = self.subviewContainerY;
        CGFloat h = self.subviewContainerH;
        CGFloat w = self.tableView.frame.size.width;
        _subviewContainer =  [[UIView alloc] initWithFrame:CGRectMake(0, y, w, h)];
        [_subviewContainer setBackgroundColor:[UIColor redColor]];
        _subviewContainer.alpha = .1f;
        _subviewContainer.layer.borderWidth = 1;
    }
    
    if (!self.isSubviewContainerAdded && self.parentView) {
        [self setIsSubviewContainerAdded:YES];
        [self.parentView addSubview:_subviewContainer];
    }
    
    return _subviewContainer;
}




#pragma mark - view controller transitions

- (UINavigationController *)defaultNavigationController{
    UINavigationController *naviC = self.parentViewController.navigationController;
    
    if (!naviC) {
        naviC = self.navigationController;
    }
    
    return naviC;
}

- (void)pushViewController:(AGViewController *)viewController{
    [self.defaultNavigationController pushViewController:viewController animated:YES];
}

//- (void)presentViewController:(AGViewController *)viewController{
//}


#pragma mark - update table view actions

- (void)willDoReload{
    [self reloadVisibleIndexPaths];
}

- (void)willReloadVisibleIndexPaths{
    
}

- (void)didReloadVisibleIndexPaths{
    
}



- (void)reloadVisibleIndexPaths{
    TLOG(@"=== %@ reloadVisibleIndexPaths ===", NSStringFromClass(self.class));
    [self willReloadVisibleIndexPaths];
    [self.tableView reloadData];
    [self didReloadVisibleIndexPaths];
}

- (void)reloadIndexPath:(NSIndexPath *)indexPath{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated{
    [self willReloadVisibleIndexPaths];
    if (animated){
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self didReloadVisibleIndexPaths];
}



#pragma mark - properties

- (BOOL)cacheEveryCell{
    return NO;
}

- (AGViewController *)previousViewController{
    if (_previousViewController) return _previousViewController;
//    TLOG(@"self.navigationController.viewControllers -> %@", self.navigationController.viewControllers);
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSInteger idx = [viewControllers indexOfObject:self];
    idx --;
    if (idx < 0) return nil;
    return [viewControllers objectAtIndex:idx];
}

+ (CGFloat)defaultContentInsetTop{
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0) {
        return 64.0;
    }
    return 0;
}

+ (CGFloat)defaultContentHeightWithNavigationBar{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0) {
        return bounds.size.height;
    }
    return bounds.size.height - 64;
}



- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
    }
    return _objPool;
}

- (id)ws{
    _ws = self;
    return _ws;
}

- (NSString *)className{
    return NSStringFromClass(self.class);
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger numOfRowsInSection = [self numberOfRowsInSection:section];
    
    BOOL hasSeparator = [self.config separatorForSection:section];
    if (hasSeparator) {
        if ([self isSeparatorCellAvailableInSection:section]) return numOfRowsInSection + 1;
    }
    
    return numOfRowsInSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    Class cls = [self.config headerClsOfSection:section];
    NSInteger rows = [self numberOfRowsInSection:section];
    id value = nil;
    
    @try {
        value = [self valueForHeaderOfSection:section];;
    }@catch (NSException *exception) {
        
    }
    
    if (!value || rows == 0) return 0;
    if (cls) return [cls height];
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    BOOL hasSeparator = [self.config separatorForSection:section];
    if (hasSeparator) {
        if ([self isSeparatorCellAtIndexPath:indexPath]) return [AGSeparatorCell height];
    }
    
    return [self.config cellHeightAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headerForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    
    BOOL hasSeparator = [self.config separatorForSection:section];
    if (hasSeparator) {
        if ([self isSeparatorCellAtIndexPath:indexPath]) return [self assembleSeparatorCell];
    }
    
    AGCell *cell = [self cellForIndexPath:indexPath];
    
    if (!cell) return [self cellForException];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *sectionUnit = [self.config unitOfSection:section];
    if (sectionUnit) [sectionUnit didSelect:idx];
}



#pragma mark - table view stuff


- (NSInteger)numberOfSections{
    return 0;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (unit) return unit.numberOfRows;
    return 0;
}


- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (unit) return [unit valueAtIndex:idx];
    return nil;
}

- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if ([DSValueUtil isAvailable:unit]) [unit setValue:value atIndex:idx];
}

- (id)valueForHeaderOfSection:(NSInteger)section{
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if ([DSValueUtil isAvailable:unit]) return unit.headerValue;
    return nil;
}


- (AGCell *)cellAtIndexPath:(NSIndexPath *)indexPath{
    AGCell *cell = (AGCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

- (UIView *)headerOfSection:(NSInteger)section{
    return [self.tableView headerViewForSection:section];
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - error handlers

- (NSArray *)messagesOfError:(id)error{
    NSMutableArray *arr = [NSMutableArray array];
    
    if ([error isKindOfClass:[NSError class]]) {
        NSError *item = error;
        error = [[AGRemoterResultError alloc] init];
        [error updateWithOriginalErrorUserInfo:item.userInfo];
    }
    
    if ( [error isKindOfClass:[AGRemoterResultError class]]){
        AGRemoterResultError *item = (AGRemoterResultError *)error;
        //append message for users
        if (item.message) [arr addObject:item.message];
        if (arr.count == 0) { //if no message for users, append message for developers
            if (item.localizedDesc) [arr addObject:item.localizedDesc];
            if (item.developMessage){
                if (![item.developMessage isEqualToString:@""]) [arr addObject:item.developMessage];
            }
        }
    }

    return arr;
}

- (BOOL)setRemoteMessagesForError:(AGRemoterResultError *)error{
    if (!error) return NO;
//    AGRemoterResultError *error = result.errorParsed;
    NSArray *msgs = [self messagesOfError:error];
    [self setFailureMessages:msgs];
    return YES;
}

#pragma mark - dummy cell stuff

- (void)pushViewController:(AGViewController *)viewController fromDummyCellAtIndex:(NSInteger)index{
    dummyCell = [self dummyCellInstanceAtIndex:index];
    [viewController setAssociatedCell:dummyCell];
    [dummyCell pushViewController:viewController];
}

#pragma mark - associated cell ops

- (void)setValueForAssociatedCell:(id)value{
    if (_associatedCell) {
        [_associatedCell dispatchRequestSetValue:value];
        [_associatedCell dispatchRequestReloadIndexPath];
    }
}

#pragma mark - CellDelegate

- (void)cellRequestReloadIndexPath:(NSIndexPath *)indexPath{
    [self reloadIndexPath:indexPath];
}

-(void)cellRequestSetValue:(id)value atIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
    if (section == SectionDummy){
        if (index == SectionDummyCellLoginUI){
//            TLOG(@"value -> %@", value);
            [self didDismissLoginUI];
        }
    }
    
    @try {
        [self setValue:value atIndexPath:indexPath];
    }@catch (NSException *exception) {
//        [AGMonitor logClientException:exception fnName:CURRENT_FUNCTION_NAME];
    }
}



- (id)cellRequestParameterAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"indexPath -> %@", indexPath);
    @try {
        NSInteger section = indexPath.section;
        NSInteger idx = indexPath.row;
        AGSectionUnit *unit = [self.config unitOfSection:section];
//        TLOG(@"section -> %d unit -> %@", section, unit);
        if (unit) return [unit paramterAtIndex:idx];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    }
    
    
    
    return nil;
}

- (void)cellRequestAction:(id)action atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
//    TLOG(@"action -> %@", action);
    if (unit) return [unit action:action atIndex:idx];
}

#pragma mark - style

- (CGFloat)subviewContainerY{
    CGFloat y = 0;
    if (!self.prefersStatusBarHidden) y += STYLE_STATUS_BAR_HEIGHT;
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) y += STYLE_NAVIGATION_BAR_HEIGHT;
    return y;
}

- (CGFloat)subviewContainerH{
    CGFloat h = STYLE_DEVICE_HEIGHT - self.subviewContainerY;
    if ([self.parentViewController.parentViewController isKindOfClass:[UITabBarController class]]) h -= STYLE_TAB_BAR_HEIGHT;
    return h;
}


@end
