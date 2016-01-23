//
//  NetTestResViewController.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/11.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "testResultModel.h"


@interface NetTestResViewController : UIViewController{
}

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UILabel *dayLab;
@property(nonatomic, strong) UILabel *scoreLab;
@property(nonatomic, strong) UIButton *wifiBtn;

-(void)setData:(testResultModel *)data;

@end
