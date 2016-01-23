//
//  terminal.m
//  路由管理
//
//  Created by zhaoyuan on 15/10/13.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "terminal.h"


@implementation terminal

-(instancetype)initWithName:(NSString *)name
                   ipNumber:(NSString *)ipNumber
                  phoneName:(NSString *)phoneName{
    if (self = [super init]) {
        self.name = name;
        self.ipNumber = ipNumber;
        self.phoneName = phoneName;
    }
    
    return self;
    
}

+(instancetype)initWithName:(NSString *)name
                   ipNumber:(NSString *)ipNumber
                  phoneName:(NSString *)phoneName{
    
    return [[terminal alloc] initWithName:name ipNumber:ipNumber phoneName:phoneName];
    
}

@end
