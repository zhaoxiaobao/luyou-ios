//
//  NetTestViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "NetTestViewController.h"

@interface NetTestViewController (){
    UIImageView  *imgBig;
    UILabel *labelSmall;
    UILabel *labelScore;
    UILabel *label;
    NSTimer* _timer;
    NSTimer* _timer2;
    float currentIndex;
    UIButton *btn;
    
    UILabel *label1;
    
}

@end

@implementation NetTestViewController

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
    //标题
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"网络诊断";
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
    
    // Initialization code
    currentIndex  = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/32.0f target:self
                                            selector:@selector(updateSpotlight) userInfo:nil repeats:YES];
    
    UIImageView  *imgbg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 80, screen_width-80, screen_width-80)];
    [imgbg setImage:[ UIImage imageNamed:@"scan_channel_circle_bg"]];
    [self.view addSubview:imgbg];

    
    imgBig=[[UIImageView alloc] initWithFrame:CGRectMake(40, 80, screen_width-80, screen_width-80)];
    [imgBig setImage:[ UIImage imageNamed:@"scan_chnnel_circle_sector"]];
    [self.view addSubview:imgBig];
    
    labelScore=[[UILabel alloc] initWithFrame:CGRectMake(0, 80+imgbg.frame.size.height/2-42, screen_width, 84)];
    labelScore.textAlignment=1;
    labelScore.font = [UIFont systemFontOfSize:58];
    [labelScore setTextColor:[UIColor  whiteColor]];
    labelScore.text = @"";
    labelScore.hidden=YES;
    [self.view addSubview:labelScore];
    
    

    CGSize size =  [self sizeWithString:@"98" font:[UIFont systemFontOfSize:58]];

    label1=[[UILabel alloc] initWithFrame:CGRectMake(46+size.width/2, 80+imgbg.frame.size.height/2-42+10, screen_width-(40+size.width/2), 84)];
    label1.text=@"分";
    label1.textColor=[UIColor  whiteColor];
    label1.textAlignment=1;
    label1.hidden=YES;

    [label1 setFont:[UIFont systemFontOfSize:18]];
    [self.view  addSubview:label1];
    

    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height/2+50, screen_width, screen_height/2-99)];
    [self.view addSubview:btnView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 90)];
    view.backgroundColor=white;
    [btnView addSubview:view];
    label=[[UILabel alloc] initWithFrame:CGRectMake(screen_width/4,10,screen_width/2,30)];
    label.text=@"正在检测本机WiFi开关...";
    label.textAlignment=1;
    [label setFont:[UIFont systemFontOfSize:16]];
    [view addSubview:label];
    
    labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(screen_width/4,40,screen_width/2,10)];
    labelSmall.text=@"正在检测ip...";
    labelSmall.textColor=fontGray;
    labelSmall.textAlignment=1;
    [labelSmall setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:labelSmall];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(16, screen_width/3, screen_width - 32, 44)];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = navigationBarColor;
    [btn setTitle:@"正在诊断" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn setEnabled:NO];

    [btn addTarget:self action:@selector(reTestBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn];
    
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self
                                             selector:@selector(changeText) userInfo:nil repeats:YES];
    
    
    
    
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}



-(void)updateSpotlight
{
    
    currentIndex+= 0.01;
    float runAngle = M_PI*currentIndex;
    imgBig.transform = CGAffineTransformMakeRotation(runAngle);

}

-(void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

- (void)changeText{
    int x =  (arc4random() % 51) + 50;


    NSString *ValueString = [NSString stringWithFormat:@"%d", x];

    labelScore.text = [ValueString stringByAppendingString:@"分"];
    labelScore.text =ValueString;
    label1.hidden=NO;

    labelScore.hidden=NO;
    label.text=@"本机WiFi开关检测完毕";
    labelSmall.text=@"ip检测完毕";
    [btn setTitle:@"重新诊断" forState:UIControlStateNormal];
    [btn setEnabled:YES];

    [_timer invalidate];
    _timer = nil;
    [_timer2 invalidate];
    _timer2 = nil;
}


- (void)initData{
    
}

-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)reTestBtnTap:(UIButton *)sender{
    [self viewDidLoad];
    
}



@end
