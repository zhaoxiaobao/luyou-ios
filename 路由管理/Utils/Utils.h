//
//  Utils.h
//  课堂助手
//
//  Created by zhaoyuan on 15/9/23.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;
@interface Utils : NSObject
+ (MBProgressHUD *)createHUD;


+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(NSString*)stringFromDate:(NSDate*)date;
+(NSDate*)dateFromString:(NSString*)string;

+ (NSArray *)getDataCounters;

+ (NSDictionary *)getWifiInfo:(NSString *)wifiMark :(NSString *)pwdMark :(NSString *)score :(NSString *)timeMark;

+ (long long int)getInterfaceBytes;
+ (NSString *)deviceIPAdress;


+(NSData *) gb2312toutf8:(NSData *) data;
@end
