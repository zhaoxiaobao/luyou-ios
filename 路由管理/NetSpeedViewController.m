//
//  netSpeedViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "NetSpeedViewController.h"

@interface NetSpeedViewController ()

@end

@implementation NetSpeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.933f green:0.937f blue:0.941f alpha:1.00f];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    [self initView];
    [self initData];
}

-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"网速控制";
    navTitle.textAlignment=1;
    navTitle.textColor=[UIColor whiteColor];
    navTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    [backView addSubview:navTitle];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 54, 44);
    UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,13,23)];
    [img setImage:[ UIImage imageNamed:@"icon_back"]];
    [backBtn addSubview:img];
    [backBtn addTarget:self action:@selector(backBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:backBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(screen_width-50, 30, 43, 23);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:rightBtn];

}


- (void)initView{
    UILabel *labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(20,90,screen_width-20,20)];
    labelSmall.text=@"当前无控制对象";
    labelSmall.textColor=fontGray;
    [labelSmall setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:labelSmall];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 90, screen_width, 375)];
    view.backgroundColor = fontWhite;
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"上网方式",@"控制模式",@"网速（kpbs）",nil];
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    [segmentedControl setTintColor:navigationBarColor];
    segmentedControl.frame = CGRectMake(10.0, 10.0,screen_width-20, 37.0);
    [view addSubview:segmentedControl];
    [self.view addSubview:view];
        
}


- (void)initData{
    
}



//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)rightBtnTap:(UIButton *)sender{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
