//
//  Utils.m
//  课堂助手
//
//  Created by zhaoyuan on 15/9/23.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "Utils.h"
#import "MBProgressHUD.h"

#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>


#import "Reachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation Utils

+ (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    [HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    return HUD;
}

+(NSString *) compareCurrentTime:(NSDate*) compareDate

{
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@""];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟",temp];
        
    }
    
    
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时",temp];
        
    }
    
    
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天",temp];
        
    }
    
    
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld个月",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年",temp];
        
    }
    
    
    
    return  result;
    
}

+(NSString*)stringFromDate:(NSDate*)date

{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateString=[dateFormatter stringFromDate:date];
    return currentDateString;
    
}

+(NSDate*)dateFromString:(NSString*)string

{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:string];
    return date;
    
}

+ (NSArray *)getDataCounters
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    NSString *name=[[NSString alloc]init];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
//            NSLog(@"ifa_name %s == %@\n", cursor->ifa_name,name);
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    NSLog(@"WiFiSent %d ==%d",WiFiSent,networkStatisc->ifi_obytes);
                    NSLog(@"WiFiReceived %d ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
                }
                if ([name hasPrefix:@"pdp_ip"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                    NSLog(@"WWANSent %d ==%d",WWANSent,networkStatisc->ifi_obytes);
                    NSLog(@"WWANReceived %d ==%d",WWANReceived,networkStatisc->ifi_ibytes);
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent],
            [NSNumber numberWithInt:WiFiReceived],
            [NSNumber numberWithInt:WWANSent],
            [NSNumber numberWithInt:WWANReceived], nil];
}



//Wifi流量统计

+ (long long int)getInterfaceBytes {
    
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1) {
        
        return 0;
        
    }
    
    uint32_t iBytes = 0;
    
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
//            NSLog(@"%s :iBytes is %d, oBytes is %d", ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    return iBytes+oBytes;
    
}

+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);  
    
    return address;
}

+ (NSDictionary *)getWifiInfo:(NSString *)wifiMark :(NSString *)pwdMark :(NSString *)score :(NSString *)timeMark{
    bool isExistenceNetwork;
    NSString *ssid;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    switch([reachability currentReachabilityStatus]) {
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
        default:
            isExistenceNetwork = NO;
    }
    
    if (isExistenceNetwork) {
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        id info = nil;
        BOOL infoCheck = NO;
        for (NSString *ifnam in ifs) {
            info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge_retained CFStringRef)ifnam);
            if (info && [info count]) {
                infoCheck = YES;
                break;
            }
        }
        
        if (infoCheck){
            ssid = [info objectForKey:@"SSID"];
            
        }
        
    }else{
        ssid=@"未连接";
    }
    
    if (ssid==nil) {
        ssid=@"未连接";
    }
    
    NSDictionary *dict = @{
                           @"wifiMark" : wifiMark,
                           @"wifiName" :ssid,
                           @"pwdMark" : pwdMark,
                           @"score" : score,
                           @"timeMark" : timeMark,
                           
                           };
    
    return dict;
    
}

+(NSData *) gb2312toutf8:(NSData *) data{
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    NSData* nsData = [retStr dataUsingEncoding:NSUTF8StringEncoding];
    
    return nsData;
}







@end
