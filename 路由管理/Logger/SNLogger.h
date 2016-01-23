//
//  SNLogger.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/26.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(UInt8, SNLogLevel) {
    SNLogLevelDEBUG         = 1,
    SNLogLevelINFO          = 2,
    SNLogLevelWARN          = 3,
    SNLogLevelERROR         = 4,
    SNLogLevelOFF           = 5,
};

#define SN_LOG_MACRO(level, fmt, ...)     [[SNLogger sharedInstance] logLevel:level format:(fmt), ##__VA_ARGS__]
#define SN_LOG_PRETTY(level, fmt, ...)    \
do {SN_LOG_MACRO(level, @"%s #%d " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);} while(0)

#define SNLogError(frmt, ...)   SN_LOG_PRETTY(SNLogLevelERROR, frmt, ##__VA_ARGS__)
#define SNLogWarn(frmt, ...)    SN_LOG_PRETTY(SNLogLevelWARN,  frmt, ##__VA_ARGS__)
#define SNLogInfo(frmt, ...)    SN_LOG_PRETTY(SNLogLevelINFO,  frmt, ##__VA_ARGS__)
#define SNLogDebug(frmt, ...)   SN_LOG_PRETTY(SNLogLevelDEBUG, frmt, ##__VA_ARGS__)
#define DLog(frmt, ...) SN_LOG_PRETTY(SNLogLevelDEBUG, frmt, ##__VA_ARGS__)

@interface SNLogger : NSObject

@property (nonatomic, assign) SNLogLevel logLevel;

+ (instancetype)sharedInstance;
+ (void)startWithLogLevel:(SNLogLevel)logLevel;

- (void)logLevel:(SNLogLevel)level format:(NSString *)format, ...;
- (void)logLevel:(SNLogLevel)level message:(NSString *)message;


@end
