//
//  AGFormBaseViewController.m
//  AboveGEM
//
//  Created by traintrackcn on 16/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGViewController.h"
#import "AGCell.h"
#import "DSReachabilityManager.h"
#import "AGViewController+Message.h"
#import "AGViewController+Datasource.h"
#import "AGViewController+Assembler.h"
#import "AGViewController+Separator.h"
#import "AGViewController+LoginUI.h"
#import "AGTopRefreshControl.h"
#import "AGSectionUnit.h"
#import "UIAlertView+Blocks.h"
#import "DSValueUtil.h"
#import "DSDeviceUtil.h"
#import "GlobalDefine.h"
#import "AGRemoter.h"
#import "AGRemoterResultError.h"
#import "AGRemoterResult.h"
#import "AGUIDefine.h"
#import "NSObject+singleton.h"
#import "AGObjectPool.h"

@interface AGViewController () {
    
    NSString *roleCodeBeforeDisappeared;
}

@end

@implementation AGViewController


- (id)init{
    self = [super init];
    if (self) {
        [self setConfig:[AGVCConfiguration instance]];
        [self.config setTarget:self];
        animationDuration = .33;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    TLOG(@"self.view.frame -> %@", NSStringFromCGRect(self.view.frame));
    
    //settting naviBar
//    UINavigationBar *naviBar = self.navigationController.navigationBar;
//    [naviBar setTranslucent:YES];
//    [naviBar ]
//    TLOG(@"tableViewContentInsetTop -> %f", self.tableViewContentInsetTop);
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
//    [self setExtendedLayoutIncludesOpaqueBars:YES];
    
    [self assemble];
    
    // view tap listener
//    UITapGestureRecognizer *gc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
//    [self.view addGestureRecognizer:gc];
}

- (void)viewWillAppear:(BOOL)animated{
//    TLOG(@"");
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:YES];
    [self layoutViews];
    
    //if view is re appeard
    if ([DSValueUtil isAvailable:roleCodeBeforeDisappeared]){
        // if role changed then reload current view
//        TLOG(@"roleCodeBeforeDisappeared -> %@ [AGSession singleton].roleCode -> %@", roleCodeBeforeDisappeared, [AGSession singleton].roleCode);
        if (![roleCodeBeforeDisappeared isEqualToString:[AGUIDefine singleton].sessionRoleCode]){
//            [self reloadVisibleIndexPaths];
            [self setFlagDoReload:YES];
        }
    }
    
    
    if (self.flagDoReload) {
        [self willDoReload];
        [self setFlagDoReload:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    roleCodeBeforeDisappeared = [AGUIDefine singleton].sessionRoleCode;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    TLOG(@"%@", NSStringFromClass(self.class));
//    [self layoutTableView];
    
    //assemble RefreshControl in layoutSubviews block to avoid unexcept RefreshControl.layout actions
    [self assembleTopRefreshControl];
}

- (void)cancelAllRequests{
    [self resetFloatedMessage];
    [_remoter cancelAllRequests];
}

- (void)dealloc{
    TLOG(@"%@", NSStringFromClass(self.class));
    [tableV setDelegate:nil];
    [self cancelAllRequests];
    [self.view.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}


- (CGFloat)tableViewContentInsetTop{
    CGFloat top = 0;
    
    if (!self.prefersStatusBarHidden) {
        top += 20.0;
    }
    
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]){
//        UINavigationController *naviC = (UINavigationController *)self.parentViewController;
//        if (!naviC.navigationBarHidden) {
            top += 44;
//        }
    }
    
    return top;
}


//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return [AGConfigurationCoordinator singleton].defaultStatusBarStyle;
//}
#pragma mark - interactive ops

- (void)didTapView:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark - layout

- (void)layoutViews{
    [self layoutDefault];
    [self layoutAccordingToTabBarController];
}

- (void)layoutDefault{
    CGRect frame = self.view.frame;
    
    if (![DSDeviceUtil iOS8AndAbove]) {
        //        CGFloat w = [DSDeviceUtil bounds].size.width;
        //        CGFloat h = [DSDeviceUtil bounds].size.height;
        frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        TLOG(@"%@ frame -> %@ %@ %d",NSStringFromClass(self.class) ,NSStringFromCGRect(frame), self.navigationController, self.navigationController.navigationBar.hidden);
    }
    
    [self.tableView setFrame:frame];
    //    [AGDebugUtil makeBorderForView:tableV];
    [overlayContentView setFrame:frame];
    //    TLOG(@"tableViewContentInsetTop -> %f", self.tableViewContentInsetTop);
    //    TLOG(@"frame -> %@", NSStringFromCGRect(frame));
}

- (void)layoutAccordingToTabBarController{
//    TLOG(@"self.parentViewController -> %@", self.parentViewController);
    if ([self.parentViewController isKindOfClass:[UITabBarController class]]) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        CGFloat top = contentInset.top;
        CGFloat bottom = 50.0;
        [self.tableView setContentInset:UIEdgeInsetsMake(top, 0, bottom, 0)];
    }
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

- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated{
    [self willReloadVisibleIndexPaths];
    if (animated){
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
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
//    TLOG(@"self.navigationController.viewControllers -> %@", self.navigationController.viewControllers);
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSInteger idx = [viewControllers indexOfObject:self];
    idx --;
    if (idx < 0) return nil;
    return [viewControllers objectAtIndex:idx];
}

- (AGRemoter *)remoter{
    if ([DSValueUtil isNotAvailable:_remoter]) {
        _remoter = [AGRemoter instanceWithDelegate:self];
    }
    return _remoter;
}

- (UITableView *)tableView{
    return tableV;
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

+ (instancetype)instance{
    return [[self.class alloc] init];
}


//- (void)setTitle:(NSString *)title{
//    [super setTitle:[title uppercaseString]];
//}

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
    }
    return _objPool;
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
    id value = nil;
    
    @try {
        value = [self valueForHeaderOfSection:section];;
    }@catch (NSException *exception) {
        
    }
    
    if ([DSValueUtil isNotAvailable:value]) {
        return 0;
    }

    if ([DSValueUtil isAvailable: cls ]) {
        return [cls height];
    }
    
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
    return [self assembleHeaderForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSInteger section = indexPath.section;
//    NSInteger idx = indexPath.row;
    
//    TLOG(@"section -> %d", section);
    
    BOOL hasSeparator = [self.config separatorForSection:section];
    if (hasSeparator) {
        if ([self isSeparatorCellAtIndexPath:indexPath]) return [self assembleSeparatorCell];
    }
    
    AGCell *cell = [self assembleCellAtIndexPath:indexPath forTableView:tableView];
    
//    TLOG(@"cell -> %@", [cell class]);
    if ([DSValueUtil isNotAvailable:cell]) {
//        TLOG(@"%@ section -> %ld  index -> %ld has exception",NSStringFromClass(self.class), (long)section, (long)idx);
        return [self cellForException];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    AGSectionUnit *sectionUnit = [self.config unitOfSection:section];
    if (sectionUnit) [sectionUnit didSelect:idx];
}

- (AGCell *)cellForException{
    return [[AGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AGCell class])];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    if(self.supportsRefreshControl) [topRefreshControl begin];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.supportsRefreshControl) [topRefreshControl dragging];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(self.supportsRefreshControl) [topRefreshControl end];
}

#pragma mark - error handlers

- (NSArray *)messagesOfError:(AGRemoterResultError *)error{
    NSMutableArray *arr = [NSMutableArray array];
    
    //append message for users
    if ([DSValueUtil isAvailable:error.message]) {
        [arr addObject:error.message];
    }
    
    if (arr.count == 0) { //if no message for users, append message for developers
        
        if ([DSValueUtil isAvailable:error.localizedDesc]){
            [arr addObject:error.localizedDesc];
        }
        
        if ([DSValueUtil isAvailable:error.developMessage]){
            if (![error.developMessage isEqualToString:@""]){
                [arr addObject:error.developMessage];
            }
        }
        
    }
    
    return arr;
}

- (void)setRemoteMessagesForError:(AGRemoterResultError *)error{
//    AGRemoterResultError *error = result.errorParsed;
    NSArray *msgs = [self messagesOfError:error];
    [self setFailureMessages:msgs];
}


- (void)alertRemoteMessagesForError:(AGRemoterResultError *)error{
    NSArray *msgs = [self messagesOfError:error];
    NSString *text = [msgs componentsJoinedByString:@"/n"];
    [UIAlertView showWithTitle:nil message:text cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
}

#pragma mark -  AGRemoterDelegate
- (void)remoterDataReceived:(id)responseData withRequestData:(DSRequest *)request{
    
}

- (void)remoterErrorOccured:(AGRemoterResult *)result{
    [self setRemoteMessagesForError:result.errorParsed];
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

- (void)cellRequestReloadIndexPath:(NSIndexPath *)indexPath{
    [self reloadVisibleIndexPaths];
//    [self reloadVisibleIndexPathsInSection:indexPath.section animated:NO];
//    [self.config setCurrentIndexPath:nil];
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

#pragma mark - AGRefreshControlDelegate

- (void)topRefreshControlRequestRefreshing{
    TLOG(@"");
}

#pragma mark -
- (NSString *)validateText:(NSString *)text{
    if ([DSValueUtil isAvailable:text]) return text;
    return @"";
}



@end
