//
//  downloadTest.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/28.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "downloadTest.h"
#import "downTask.h"
#import "AFNetworking.h"
@interface downloadTest()
{
    downTask *downTask;
}

@end;


@implementation downloadTest



/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        
        //测算速度
        //计算一秒中的速度
//        downTask.totalRead += bytesRead; 
//
//        //获取当前时间
//        NSDate *currentDate = [NSDate date];
//        
//        //当前时间和上一秒时间做对比，大于等于一秒就去计算
//        if ([currentDate timeIntervalSinceDate:downTask.date] >= 1) {
//            //时间差
//            double time = [currentDate timeIntervalSinceDate:downTask.date];
//            
//            //计算速度
//            long long speed = downTask.total/time;
//            
//            //把速度转成KB或M
//            downTask.speed = [downTask formatByteCount:speed];
//            
//            //维护变量，将计算过的清零
//            downTask.totalRead = 0.0;
//            
//            //维护变量，记录这次计算的时间
//            
//            downTask.date = currentDate;
        
        
        
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
//        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
//        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}

@end
