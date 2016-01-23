//
//  AppDelegate.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/9.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkReach.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
@private
    NetworkReach *netReach_;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController  *rootTabCtr;
@property (nonatomic, readonly, strong) NetworkReach *netReach;


//网络是否连接
- (BOOL)isNetReachable;

@end

