//
//  SupportDevViewController.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SJBBaseTreeListViewController.h"


@interface SupportDevViewController : SJBBaseTreeListViewController

///创建自己的tableView和resultArray
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *myResultArray;

@end
