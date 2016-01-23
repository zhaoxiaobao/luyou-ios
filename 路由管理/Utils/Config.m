//
//  Config.m
//  课堂助手
//
//  Created by zhaoyuan on 15/9/23.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "Config.h"
NSString * const kAccount = @"account";
NSString * const kPassword = @"password";

NSString * const kquestion = @"question";
NSString * const kanswer = @"kanswer";

NSString * const kPortrait = @"portrait";

NSString * const SwMsgMode = @"swMsg";


@implementation Config

//初始化用户信息
+ (NSArray *)getUsersInformation
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:kAccount];
    if (userName) {
        return @[userName,@"head_boy"];
    }
    return @[@"点击头像登录",@"icon_mine_default_portrait"];
    
}


//初始化头像
+ (UIImage *)getPortrait
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIImage *portrait = [UIImage imageWithData:[userDefaults objectForKey:kPortrait]];
    
    return portrait;
}


+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:kAccount];
    [userDefaults setObject:password forKey:kPassword];
    [userDefaults synchronize];
    
}
+ (void)deleteOwnAccount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kAccount];
    [userDefaults removeObjectForKey:kPassword];
    
    [userDefaults synchronize];
    
}

+ (void)saveQueAnswer:(NSString *)question andAnswer:(NSString *)answer{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:answer forKey:kanswer];
    [userDefaults setObject:question forKey:kquestion];
    [userDefaults synchronize];
    
    
}

+ (NSArray *)getQuestionAnswer
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *question = [userDefaults objectForKey:kquestion];
    NSString *answer = [userDefaults objectForKey:kanswer];
    if (question) {
        return @[question,answer];
    }
    return @[@"还没有设置安全问题"];
    
}



@end
