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
#import "DATableView.h"



@interface AGViewController () <AGCellDelegate>{
    
}

@property (nonatomic, strong) UIView *overlayContainer;
@property (nonatomic, strong) NSMutableArray *externalViews;

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

//- (void)loadView{
//    CGRect frame = CGRectMake(0, 0, STYLE_DEVICE_WIDTH, STYLE_DEVICE_HEIGHT);
//    DATableView* tv = [[DATableView alloc]initWithFrame:frame style: UITableViewStylePlain];
//    [tv setDataSource:self];
//    [tv setDelegate:self];
//    [tv setControllerClassName:self.className];
//    [self setView:tv];
//    [self setTableView:tv];
//}

- (void)viewDidLoad{
    TLOG(@"%@", self.className);
    [super viewDidLoad];
    [self.parentView addSubview:self.overlayContainer];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (self.backgroundColor) [self.view setBackgroundColor:self.backgroundColor];
}

- (void)viewWillAppear:(BOOL)animated{
    TLOG(@"%@", self.className);
    [super viewWillAppear:animated];
    [self setNavigationController];
    [self showExternalViews];
    
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
//    TLOG(@"%@", self.className);
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
//    TLOG(@"%@", self.className);
    [super viewWillDisappear:animated];
    [self hideExternalViews];
}

- (void)viewDidDisappear:(BOOL)animated{
//    TLOG(@"%@", self.className);
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    TLOG(@"%@", self.className);
    [self clearFloatedMessage];
    [self.view.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self resetExternalViews];
}

#pragma mark - component

- (void)hideExternalViews{
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v setHidden:YES];
    }
}

- (void)showExternalViews{
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v setHidden:NO];
    }
    
}

- (void)resetExternalViews{
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v removeFromSuperview];
    }
    
    _externalViews = nil;
    _overlayContainer = nil;
}

- (void)setNavigationController{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:YES];
}

- (UIView *)parentView{
    return self.navigationController.view;
}

- (void)addOverlay:(UIView *)view{
    [self.overlayContainer addSubview:view];
}

- (void)enableOverlay:(BOOL)enabled{
    [self.overlayContainer setUserInteractionEnabled:enabled];
}

- (void)addExternalView:(UIView *)view{
    if (!view) return;
    
    [self.parentView insertSubview:view belowSubview:self.overlayContainer];
    [self.externalViews addObject:view];
    
}

- (UIView *)overlayWithTag:(NSInteger)tag{
    return [self.overlayContainer viewWithTag:tag];
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
    id title = [self titleAtIndexPath:indexPath];
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
        [cell setTitle: title ];
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

- (UIView *)overlayContainer{
    if (!_overlayContainer) {
        CGFloat y = self.subviewContainerY;
        CGFloat h = self.subviewContainerH;
        CGFloat w = self.tableView.frame.size.width;
        _overlayContainer =  [[UIView alloc] initWithFrame:CGRectMake(0, y, w, h)];
//        _overlayContainer.layer.borderWidth = 3;
//        _overlayContainer.layer.borderColor = [UIColor blueColor].CGColor;
        [_overlayContainer setUserInteractionEnabled:NO];
        
        [self.externalViews addObject:_overlayContainer];
    }
    
    return _overlayContainer;
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
    TLOG(@"%@", NSStringFromClass(self.class));
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
        [_objPool setParentClassName:NSStringFromClass(self.class)];
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

- (NSMutableArray *)externalViews{
    if (!_externalViews) {
        _externalViews = [NSMutableArray array];
    }
    return _externalViews;
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    TLOG(@"");
    return [self numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    TLOG(@"========================");
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    TLOG(@"");
    NSInteger numOfRowsInSection = [self numberOfRowsInSection:section];
    
    BOOL hasSeparator = [self.config separatorForSection:section];
    if (hasSeparator) {
        if ([self isSeparatorCellAvailableInSection:section]) {
            numOfRowsInSection ++;
        }
    }
    
//    TLOG(@"section-%d rows -> %d", section,numOfRowsInSection);
    
    return numOfRowsInSection;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self isSeparatorCellAtIndexPath:indexPath]){
        return [AGSeparatorCell height];
    }
    
    if (![self.config cellHeightCalculatedAtIndexPath:indexPath]) {
        id value = [self valueAtIndexPath:indexPath];
        Class cellCls = [self.config cellClsOfIndexPath:indexPath];
        [self.config setCellHeight:[cellCls heightOfValue:value] atIndexPath:indexPath];
    }
    
    return [self.config cellHeightAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    TLOG(@"");
    return [self headerForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"");
    if ([self isSeparatorCellAtIndexPath:indexPath]) return [self assembleSeparatorCell];
    AGCell *cell = [self cellForIndexPath:indexPath];
    if (!cell) return [self cellForException];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"");
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (unit) [unit didSelect:idx];
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

- (id)titleAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    id titleInConfig = [self.config cellTitleOfIndexPath:indexPath];
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (titleInConfig) return titleInConfig;
    if (unit) return [unit titleAtIndex:idx];
    
    return nil;
}

- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (unit) [unit setValue:value atIndex:idx];
}

- (id)valueForHeaderOfSection:(NSInteger)section{
    AGSectionUnit *unit = [self.config unitOfSection:section];
    if (unit) return unit.headerValue;
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
- (void)endEditing:(BOOL)endEditing{
    [self.view endEditing:endEditing];
    
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v endEditing:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
//    TLOG(@"self.parentView.subviews -> %@", self.parentView.subviews);
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
