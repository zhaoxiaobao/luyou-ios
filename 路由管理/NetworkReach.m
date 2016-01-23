//
//  NetWorkReach.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/26.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "NetworkReach.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

#pragma mark 网络畅通测试地址
#define	kNetworkTestAddress						@"http://www.baidu.com"


@interface NetworkReach()<MBProgressHUDDelegate>
{
    NetworkStatus lastNetworkStatus;
}

//@property (nonatomic, strong) BBAlertView  *networkAlert;

- (void)updateInterfaceWithReachability:(Reachability *)curReach;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

/*********************************************************************/

@implementation NetworkReach

@synthesize isNetReachable = _isNetReachable;
@synthesize isHostReach = _isHostReach;

@synthesize hostReach = _hostReach;
//@synthesize networkAlert = _networkAlert;
@synthesize reachableCount = _reachableCount;

- (void)dealloc
{
//    进行内存释放
    
//    TT_RELEASE_SAFELY(_hostReach);
//    TT_RELEASE_SAFELY(_networkAlert);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark -
#pragma mark Reachability


- (void)initNetwork
{
    _isHostReach= NO;
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    
    
    _hostReach = [Reachability reachabilityWithHostName:kNetworkTestAddress];
    [_hostReach startNotifier];
    
}

- (void)reachabilityChanged: (NSNotification*)note
{
    
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)curReach
{
//    NSLog(@"\n ======Reachable === <%ld>=== \n",(long)_hostReach.currentReachabilityStatus);
    
    if((long)_hostReach.currentReachabilityStatus==0){
        _HUD = [self createHUD];
        _HUD.labelText = @"好像没有网络连接哦~";
        _HUD.userInteractionEnabled = NO;
        [_HUD hide:YES afterDelay:1];

    }
    
    
    
    
    
    
    _reachableCount++;
    
    if (1 == _reachableCount) {
        
        return;
    }
    
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self
    //                                             selector:@selector(showNetworkAlertMessage)
    //                                               object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(changeStatus)
                                               object:nil];
    
    if (NotReachable == _hostReach.currentReachabilityStatus)
    {
        
        //       if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        //       {
        //           [self performSelector:@selector(showNetworkAlertMessage) withObject:nil afterDelay:2];
        //       }
    }
    else
    {
        
//        if (AUTO_QUAILTY == [[Config currentConfig].imageQuailty intValue]) {
//            //提示网络切换
//            
//            [self performSelector:@selector(changeStatus) withObject:nil afterDelay:2];
//        }
    }
    
    
}

- (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}


- (void)changeStatus
{
//    UIView *contentView = APP_DELEGATE.tabBarViewController.view;
//    
//    if (_hostReach.currentReachabilityStatus != lastNetworkStatus)
//    {
//        if (ReachableViaWiFi == _hostReach.currentReachabilityStatus){
//            
//            [contentView showTipViewAtCenter:L(@"APPDelegate_ChangedToWifi")];
//            
//        }
//        else
//        {
//            [contentView showTipViewAtCenter:L(@"APPDelegate_ChangedToNormal")];
//        }
//        
//        lastNetworkStatus = _hostReach.currentReachabilityStatus;
//    }
}


-(BOOL)isNetReachable
{
    _isNetReachable = self.isHostReach;
    return _isNetReachable;
}


- (BOOL)isHostReach
{
    
    _isHostReach = [_hostReach currentReachabilityStatus] != NotReachable;
    
    return _isHostReach;
}

//- (BBAlertView *)networkAlert
//{
//    if (!_networkAlert) {
//        _networkAlert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
//                                                   message:L(@"NotReachable")
//                                                  delegate:nil
//                                         cancelButtonTitle:L(@"Ok")
//                                         otherButtonTitles:nil];
//        __weak NetworkReach *weakSelf = self;
//        [_networkAlert setCancelBlock:^{
//            [weakSelf setNetworkAlert:nil];
//        }];
//    }
//    return _networkAlert;
//}

- (void)showNetworkAlertMessage
{
    //modify by liukun at 2014/5/13, 不提示网络弹框
    return;
    //    if (![self.networkAlert isVisible]) {
    //        [self.networkAlert show];
    //    }
}

@end
