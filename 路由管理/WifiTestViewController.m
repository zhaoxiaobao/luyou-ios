//
//  WifiTestViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "WifiTestViewController.h"
#import "WMGaugeView.h"
#import "AFNetworking.h"
#import "downTask.h"


@interface WifiTestViewController ()<UIGestureRecognizerDelegate>{
    WMGaugeView *_gaugeView2;
    UILabel *label;
    UILabel *label2;
}
@property(nonatomic) double     netSpeed;
@property (nonatomic, strong) downTask    *downTask;
@end

@implementation WifiTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.937f green:0.937f blue:0.937f alpha:1.00f];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self initNav];
    [self initView];
    [self initData];
    [self testSpeed];
    
    
}

-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2+50)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"Wi-Fi测速";
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
    
}

- (void)initView{
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 60, screen_width, screen_width-20)];
    view2.backgroundColor=bgroundColor;
    [self.view addSubview:view2];
    
    _gaugeView2 = [[WMGaugeView alloc] initWithFrame:CGRectMake(20, 60, screen_width-40, screen_width-40)];
    _gaugeView2.backgroundColor=bgroundColor;
    [self.view addSubview:_gaugeView2];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height/2+50, screen_width, screen_height/2-99)];
    [self.view addSubview:btnView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    view.backgroundColor=white;
    [btnView addSubview:view];
    label=[[UILabel alloc] initWithFrame:CGRectMake(0,10,screen_width/5,30)];
    label.text=@"0";
    label.textColor=fontBlue;
    label.textAlignment=2;
    [label setFont:[UIFont systemFontOfSize:18]];
    [view addSubview:label];
    
    UILabel *labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(screen_width/5+5,10,3*screen_width/5-40,30)];
    labelSmall.text=@"mb/s平均速度，相当于";
    labelSmall.textColor=fontGray;
    [labelSmall setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall];
    
    label2=[[UILabel alloc] initWithFrame:CGRectMake(3*screen_width/5+16,10,screen_width/5,30)];
    label2.text=@"0M";
    label2.textColor=fontBlue;
    [label2 setFont:[UIFont systemFontOfSize:18]];
    [view addSubview:label2];
    
    UILabel *labelSmall2=[[UILabel alloc] initWithFrame:CGRectMake(3*screen_width/5+65,10,screen_width/5,30)];
    labelSmall2.text=@"宽带";
    labelSmall2.textColor=fontGray;
    [labelSmall2 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall2];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(16, screen_width/3, screen_width - 32, 44)];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = navigationBarColor;
    [btn setTitle:@"重新测速" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    btn.tag=10001;
    [btn addTarget:self action:@selector(testSpeed) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn];
    
    _gaugeView2.maxValue = 100.0;
    _gaugeView2.scaleDivisions = 10;
    _gaugeView2.scaleSubdivisions = 10;
    _gaugeView2.scaleStartAngle = 30;
    _gaugeView2.scaleEndAngle = 280;
    _gaugeView2.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat;
    _gaugeView2.showScaleShadow = NO;
    _gaugeView2.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    _gaugeView2.scalesubdivisionsaligment = WMGaugeViewSubdivisionsAlignmentCenter;
    _gaugeView2.scaleSubdivisionsWidth = 0.002;
    _gaugeView2.scaleSubdivisionsLength = 0.04;
    _gaugeView2.scaleDivisionsWidth = 0.007;
    _gaugeView2.scaleDivisionsLength = 0.07;
    _gaugeView2.needleStyle = WMGaugeViewNeedleStyleFlatThin;
    _gaugeView2.needleWidth = 0.012;
    _gaugeView2.needleHeight = 0.4;
    _gaugeView2.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain;
    _gaugeView2.needleScrewRadius = 0.05;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(gaugeUpdateTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)gaugeUpdateTimer:(NSTimer *)timer{
    //    NSLog(@"speed（kb/s）：%f",     _gaugeView2.value);
}

-(void)testSpeed{
    
    NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/QQ7.6.exe"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:@"http://dldir1.qq.com/qqfile/qq/QQ7.6/15742/QQ7.6.exe" parameters:@{@"userid":@"123123"} error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    _downTask=[[downTask alloc] init];
    __weak typeof(self) weakSelf = self;
    
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        weakSelf.downTask.totalReadPeriod+=totalBytesRead;
        weakSelf.downTask.totalRead+=totalBytesRead;
        NSDate *currentDate = [NSDate date];
        if ([currentDate timeIntervalSinceDate:weakSelf.downTask.oldDatePeriod] >1) {
            double speed=[weakSelf.downTask getSpeedWithDate:currentDate];
            _gaugeView2.value=speed/1024/1024;
            label.text=[NSString stringWithFormat:@"%0.1f", speed/1024/1024/8];
            label2.text=[NSString stringWithFormat:@"%0.01fM", speed/1024/1024];
            
        }
        
        
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
    [operation start];
}




- (void)initData{
    
}
//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)reTestBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
