//
//  AGPresentableViewController.m
//  AboveGEM
//
//  Created by Tao Yunfei on 5/7/15.
//
//

#import "AGPresentableViewController.h"
//#import "AGRootViewController.h"
#import "AGUIKitDefine.h"
#import "NSObject+Singleton.h"
#import "GlobalDefine.h"

static NSMutableDictionary* _singletonsAGPresentableViewController;

@implementation AGPresentableViewController

+ (AGViewController *)baseViewController{
    return (AGViewController *)[AGUIKitDefine singleton].rootViewController;
}

+ (UIViewController *)basePresentedViewController{
    return self.baseViewController.presentedViewController;
}

+ (UIViewController *)availableViewController{
    UIViewController *vc;
    
    if (self.basePresentedViewController) {
        vc = self.basePresentedViewController;
    }else{
        vc = self.baseViewController;
    }
    
    return vc;
}

+ (BOOL)isExisted{
    TLOG(@"self.availableViewController -> %@ self -> %@",self.availableViewController, self);
    if ([self.availableViewController isKindOfClass:self]) return YES;
    return NO;
}

#pragma mark -

+ (void)presentWithDelegate:(id)delegate{
    
}

- (void)present{
    TLOG(@"%@", self.class);
    //if presented self already, don't present twice
    [self presentAnimated:YES];
}



- (void)presentAnimated:(BOOL)animated{
//    TLOG(@"self.availableViewController  -> %@ %@", self.class.availableViewController, self);
//    if (self.class.availableViewController isKindOfClass:[self class]]) return;
    [self.class.availableViewController presentViewController:self animated:animated completion:nil];
    
    [self retainInstance];  //in some situation, will be auto deallocated before presenting
}


- (void)retainInstance{
    if (!_singletonsAGPresentableViewController) {
        _singletonsAGPresentableViewController = [NSMutableDictionary dictionary];
    }
    
    NSString *key = NSStringFromClass([self class]);
    [_singletonsAGPresentableViewController setValue:self forKey:key];
    
    TLOG(@"_singletonsAGPresentableViewController -> %@", _singletonsAGPresentableViewController);
    
}

- (void)releaseInstance{
    NSString *key = NSStringFromClass([self class]);
    [_singletonsAGPresentableViewController removeObjectForKey:key];
    
    TLOG(@"_singletonsAGPresentableViewController -> %@", _singletonsAGPresentableViewController);
}


- (void)dismiss{
    TLOG(@"self -> %@",self);
    [self dismissAnimated:YES];
    [self releaseInstance];
}

- (void)dismissWithCompletion:(void(^)(void))completion{
    [self.class.availableViewController dismissViewControllerAnimated:YES completion:completion];
}

- (void)dismissAnimated:(BOOL)animated{
    [self.class.availableViewController dismissViewControllerAnimated:animated completion:nil];
}

@end
