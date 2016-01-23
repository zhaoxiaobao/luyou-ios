//
//  Config.h
//  课堂助手
//
//  Created by zhaoyuan on 15/9/23.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Config : NSObject

+ (NSArray *)getUsersInformation;
+ (UIImage *)getPortrait;
+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password;
+(void)deleteOwnAccount;

+ (void)saveQueAnswer:(NSString *)question andAnswer:(NSString *)answer;
+ (NSArray *)getQuestionAnswer;

@end
