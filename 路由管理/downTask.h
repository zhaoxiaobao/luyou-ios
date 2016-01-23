//
//  downTask.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/28.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  RATIO  1000.0
@interface downTask : NSObject

@property (nonatomic, strong)NSMutableArray  *arySpeed;
@property (nonatomic, assign)long  long totalReadPeriod;
@property (nonatomic, assign)long long totalRead;
@property (nonatomic, assign)long  long speed;
@property (nonatomic, strong)NSDate *oldDate;
@property (nonatomic, strong)NSDate *oldDatePeriod;


-(double)getSpeedWithDate:(NSDate *)date;
-(double)getAverageSpeed:(NSDate *)date;
-(double)getMaxSpeed:(NSDate *)date;
-(double)getMinSpeed:(NSDate *)date;

- (void)resume;



@end
