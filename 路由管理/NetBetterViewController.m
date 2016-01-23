//
//  netBetterViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "NetBetterViewController.h"
#import "NetTestResViewController.h"
#import "testResultModel.h"
#import "MJExtension.h"

#import "Utils.h"
#import "AppDelegate.h"




@interface NetBetterViewController ()<UIGestureRecognizerDelegate>{
    UIImageView  *img1;
    UIImageView  *img2;
    UIImageView  *img3;
    NSTimer* _timer;
    NSTimer* _timer2;
    float currentIndex;
    UIButton *btn;
    UILabel *label;
    UILabel *labelSmall;
    testResultModel *resultMod;
    
}

@end

@implementation NetBetterViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.937f green:0.937f blue:0.937f alpha:1.00f];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    [self initView];
    [self initData];
}

-(void)initNav{
    UIImageView  *imgIndex=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2+50)];
    [imgIndex setImage:[ UIImage imageNamed:@"index_bg"]];
    [self.view addSubview:imgIndex];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2+50)];
    [self.view addSubview:backView];

    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"安全体检";
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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
    
}

- (void)initView{
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height/2+50, screen_width, screen_height/2-99)];
    [self.view addSubview:btnView];
    
    img1=[[UIImageView alloc] initWithFrame:CGRectMake(40, 75, screen_width-80, screen_width-80)];
    [img1 setImage:[ UIImage imageNamed:@"safe_ring01"]];
    [self.view addSubview:img1];
    
    img3=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/3+8, 1.35*screen_width/3, screen_width/3-16, screen_width/3)];
    [img3 setImage:[ UIImage imageNamed:@"safe_shield01"]];
    [self.view addSubview:img3];
    
    currentIndex  = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/32.0f target:self
                                            selector:@selector(updateSpotlight) userInfo:nil repeats:YES];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 90)];
    view.backgroundColor=white;
    [btnView addSubview:view];
    label=[[UILabel alloc] initWithFrame:CGRectMake(screen_width/4,10,screen_width/2,30)];
    label.text=@"正在检测WiFi密码强度...";
    label.textAlignment=1;
    [label setFont:[UIFont systemFontOfSize:16]];
    [view addSubview:label];
    
    labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(screen_width/4,40,screen_width/2,10)];
    labelSmall.text=@"正在检测管理员密码强度...";
    labelSmall.textColor=fontGray;
    labelSmall.textAlignment=1;
    [labelSmall setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:labelSmall];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(16, screen_width/3, screen_width - 32, 44)];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = navigationBarColor;
    [btn setTitle:@"正在体检..." forState:UIControlStateNormal];
    [btn setEnabled:NO];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn addTarget:self action:@selector(reTestBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn];
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self
                                             selector:@selector(changeText) userInfo:nil repeats:YES];
    
}

-(void)updateSpotlight{
    currentIndex+= 0.01;
    float runAngle = M_PI*currentIndex;
    img1.transform = CGAffineTransformMakeRotation(runAngle);
}

-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

- (void)changeText{
    label.text=@"WiFi密码强度一般...";
    labelSmall.text=@"WiFi密码强度较高..";
    [btn setTitle:@"查看体检结果" forState:UIControlStateNormal];
    [btn setEnabled:YES];
    [_timer invalidate];
    _timer = nil;
}




- (void)initData{
    
    /**
     *  实现无线网络环境检测：入参：无
     出参：1.wifi名（string） 2.网速（float） 3.天数（date）4.体检分数（float）
     *
     *  @return <#return value description#>
     */
    int x =  (arc4random() % 51) + 50;
    
    
    NSString *ValueString = [NSString stringWithFormat:@"%d", x];
    
    NSArray *info=@[@"1",@"2",ValueString,@"5"];
  
    resultMod= [testResultModel  mj_objectWithKeyValues:[Utils getWifiInfo:info[0] :info[1] :info[2] :info[3]]];
    
}

-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)reTestBtnTap:(UIButton *)sender{
    NetTestResViewController *VC = [[NetTestResViewController alloc] init];
    [VC setData:resultMod];
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
