//
//  NetWorkReach.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/26.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import <Foundation/Foundation.h>
//一种是通过#import方式引入；另一种是通过@class引入；
//
//
//
//这两种的方式的区别在于：
//
//
//
//1、#import方式会包含被引用类的所有信息，包括被引用类的变量和方法；@class方式只是告诉编译器在A.h文件中 B *b 只是类的声明，具体这个类里有什么信息，这里不需要知道，等实现文件中真正要用到时，才会真正去查看B类中信息；
//
//
//
//2、使用@class方式由于只需要只要被引用类（B类）的名称就可以了，而在实现类由于要用到被引用类中的实体变量和方法，所以需要使用#importl来包含被引用类的头文件；
//
//
//
//3、通过上面2点也很容易知道在编译效率上，如果有上百个头文件都#import了同一 个文件，或者这些文件依次被#improt（A->B, B->C,C->D…）,一旦最开始的头文件稍有改动，后面引用到这个文件的所有类都需要重新编译一遍，这样的效率也是可想而知的，而相对来 讲，使用@class方式就不会出现这种问题了；
@class Reachability;


@interface NetworkReach : NSObject
@property (nonatomic, readonly) BOOL isNetReachable;
@property (nonatomic, readonly) BOOL isHostReach;
@property (nonatomic, readonly) NSInteger reachableCount;
@property (strong,nonatomic)Reachability *hostReach;
//@property (nonatomic)   NSInteger reachableOfSN;//0:没有连接：1：wifi 2：非wifi连接


-(void)initNetwork;

-(void)showNetworkAlertMessage;

@end
