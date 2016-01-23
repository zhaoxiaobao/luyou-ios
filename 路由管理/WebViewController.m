//
//  WebViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/10/11.
//  Copyright © 2015年 赵远. All rights reserved.
//

#import "WebViewController.h"
#import "Utils.h"
#import "MBProgressHUD.h"

@interface WebViewController ()<UIWebViewDelegate>{
    MBProgressHUD *HUD;

}

@end

@implementation WebViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ] ;
    UIScrollView* scrollView = [ [UIScrollView alloc ] initWithFrame:bounds ];
    [ scrollView addSubview:self.view];
    [super viewDidLoad];
    self.view.backgroundColor=bgroundColor;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    [self initView];
}

-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    //标题
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"访问";
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

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.scrollView.bounces = NO;
    NSString *urlStr=@"http://192.168.1.1";
    NSURL *url=[NSURL URLWithString:urlStr];
    webView.delegate=self;
    [webView setScalesPageToFit:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    


    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //修改服务器页面的meta的值
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
    [HUD hide:YES afterDelay:0.5];

}

//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    HUD = [Utils createHUD];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"加载中...";
}

//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
