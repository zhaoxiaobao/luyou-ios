//
//  downTask.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/28.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "downTask.h"

@implementation downTask

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arySpeed=[[NSMutableArray alloc] init];
        self.totalReadPeriod=0;
        self.oldDate=[NSDate date];
        self.oldDatePeriod=[NSDate date];
        self.speed=0;
    }
    return self;
}

/**
 *  求当前速度
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */


-(double)getSpeedWithDate:(NSDate *)date{
    
    double time=[date timeIntervalSinceDate:self.oldDatePeriod];
    double speed=self.totalReadPeriod/time;
    [self.arySpeed addObject:[NSNumber numberWithDouble:speed]];
    
    self.totalReadPeriod=0;
    self.oldDatePeriod=[NSDate date];
    return speed/RATIO;

    
    
}
/**
 *  获取平均速度
 *
 *  @param date date
 *
 *  @return speed
 */
-(double)getAverageSpeed:(NSDate *)date{
    double speed=0;
    if (self.arySpeed.count>0) {
        for (int i=0; i<self.arySpeed.count; i++) {
            double currentSpeed=[self.arySpeed[i] doubleValue];
            speed+=currentSpeed;
        }
        speed/=self.arySpeed.count;
    }
    
    return speed;
    
    
}

/**
 *  求最大速度
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */


-(double)getMaxSpeed:(NSDate *)date{
    double maxSpeed=0;
    for (NSString *speed  in self.arySpeed) {

        if ([speed doubleValue]>maxSpeed) {
            maxSpeed=[speed doubleValue];
        }
        
    }
    
    return maxSpeed;

    
}

/**
 *  求最小速度
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */

-(double)getMinSpeed:(NSDate *)date{
    double minSpeed=0;
    for (NSString *speed  in self.arySpeed) {
        
        if ([speed doubleValue]<minSpeed) {
            minSpeed=[speed doubleValue];
        }
        
    }
    
    return minSpeed;
    
}

/**
 *  清除恢复原状
 */
- (void)resume{
    [self.arySpeed removeAllObjects];
    self.totalReadPeriod=0;
    self.oldDate=[NSDate date];
    self.oldDatePeriod=[NSDate date];
    self.speed=0;
    
}
/**
 *  网速转为KB或M
 *
 *  @param size <#size description#>
 *
 *  @return <#return value description#>
 */
- (NSString*)formatByteCount:(long long)size
{
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}
@end
