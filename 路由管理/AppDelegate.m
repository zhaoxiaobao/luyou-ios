//
//  AppDelegate.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/9.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "AppDelegate.h"
#import "NetViewController.h"
#import "MoreViewController.h"
#import "MineViewController.h"
#import "MBProgressHUD.h"
#import "NetworkReach.h"
#import "downTask.h"
#import "UMSocial.h"

#import "Utils.h"


@interface AppDelegate () <MBProgressHUDDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate> {
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) downTask    *downTask;
@end

@implementation AppDelegate
@synthesize netReach = netReach_;

- (NetworkReach *)netReach{
    if (!netReach_) {
        netReach_ = [[NetworkReach alloc] init];
    }
    return netReach_;
}

- (void)initRootVc{
    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NetViewController *Vc1=[[NetViewController alloc] init];
    UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:Vc1];
    MineViewController *Vc2=[[MineViewController alloc] init];
    UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:Vc2];
    MoreViewController *Vc3=[[MoreViewController alloc] init];
    UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:Vc3];
    Vc1.title=@"网络";
    Vc2.title=@"我的设备";
    Vc3.title=@"更多";
    NSArray *navs=@[nav1,nav2,nav3];
    self.rootTabCtr=[[UITabBarController alloc] init];
    [self.rootTabCtr setViewControllers:navs animated:YES];
    self.window.rootViewController=self.rootTabCtr;
    UITabBar *tabbar=self.rootTabCtr.tabBar;
    UITabBarItem *item1=[tabbar.items objectAtIndex:0];
    UITabBarItem *item2=[tabbar.items objectAtIndex:1];
    UITabBarItem *item3=[tabbar.items objectAtIndex:2];
    
    item1.selectedImage = [[UIImage imageNamed:@"12"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"9"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"13"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"10"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"14"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"11"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(121, 31,211),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


-(void)testNotification{
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
    
}


-(void)firstLoad{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSDate *installDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:[Utils stringFromDate:installDate] forKey:@"installDate"];
        
        
        
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    
    
}


#pragma mark custom methods
- (BOOL)isNetReachable{
    return self.netReach.isNetReachable;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.netReach initNetwork];
    [UMSocialData setAppKey:@"5617b5f1e0f55af05300423f"];
    [self firstLoad];
    [self initRootVc];
    [self testNotification];
    return YES;
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

#pragma mark - 私有方法
#pragma mark 添加本地通知
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
