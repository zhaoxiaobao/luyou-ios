//
//  RouterInfoViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/15.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "RouterInfoViewController.h"
#import "Utils.h"

@interface RouterInfoViewController ()

@end

@implementation RouterInfoViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    [self initView];
    [self initData];
}

-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    //标题
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"路由详情";
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
    
    NSString *ipStr=[Utils deviceIPAdress];

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
    view.backgroundColor = RGB(239, 239, 244);
    
    UILabel *labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(20,20,screen_width-20,20)];
    labelSmall.text=@">设备型号：未知";
    labelSmall.textColor=fontGray;
    [labelSmall setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall];
    
    
    UILabel *labelSmall2=[[UILabel alloc] initWithFrame:CGRectMake(20,40,screen_width-20,20)];
    labelSmall2.text=@">生产厂商：未知";
    labelSmall2.textColor=fontGray;
    [labelSmall2 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall2];
    
    UILabel *labelSmall3=[[UILabel alloc] initWithFrame:CGRectMake(20,60,screen_width-20,20)];
    labelSmall3.text=@">硬件版本：WR742N 7.0 00000000";
    labelSmall3.textColor=fontGray;
    [labelSmall3 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall3];
    
    UILabel *labelSmall4=[[UILabel alloc] initWithFrame:CGRectMake(20,80,screen_width-20,20)];
    labelSmall4.text=@">软件版本：1.0.1 Build 150512 Rel.52192n ";
    labelSmall4.textColor=fontGray;
    [labelSmall4 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall4];
    
    UILabel *labelSmall5=[[UILabel alloc] initWithFrame:CGRectMake(20,100,screen_width-20,20)];
    labelSmall5.text=@">MAC地址：BC-46-99-04-34-B8";
    labelSmall5.textColor=fontGray;
    [labelSmall5 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall5];
    
    UILabel *labelSmall6=[[UILabel alloc] initWithFrame:CGRectMake(20,120,screen_width-20,20)];
    labelSmall6.text=@">内网IP：192.168.1.1";
    labelSmall6.textColor=fontGray;
    [labelSmall6 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall6];
    
    UILabel *labelSmall7=[[UILabel alloc] initWithFrame:CGRectMake(20,140,screen_width-20,20)];
    labelSmall7.text=[NSString stringWithFormat:@">外网IP：%@",ipStr];
    labelSmall7.textColor=fontGray;
    [labelSmall7 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:labelSmall7];
    [self.view addSubview:view];

    
}


- (void)initData{
    
}



//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
