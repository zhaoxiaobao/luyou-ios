//
//  terminal.h
//  路由管理
//
//  Created by zhaoyuan on 15/10/13.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface terminal : NSObject

#pragma mark - 声明属性
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ipNumber;
@property (nonatomic, copy) NSString *phoneName;

#pragma  初始化方法
-(instancetype)initWithName:(NSString *)name
                   ipNumber:(NSString *)ipNumber
                  phoneName:(NSString *)phoneName;

#pragma mark 便利构造器
+(instancetype)initWithName:(NSString *)name
                   ipNumber:(NSString *)ipNumber
                  phoneName:(NSString *)phoneName;




@end
