//
//  NetViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/9.
//  Copyright (c) 2015年 赵远. All rights reserved.
//
#import "NetViewController.h"
#import "NetBetterViewController.h"
#import "NetTestViewController.h"
#import "WifiTestViewController.h"
#import "LoginViewController.h"
#import "GuestViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "Config.h"
#import "CLLockVC.h"
#import "KxMenu.h"
#import "QRCodeReaderViewController.h"
#import "AFNetworking.h"
#import "downTask.h"

#import "Utils.h"

#import "UMSocial.h"

#import "LocalAuthentication/LAContext.h"

@interface NetViewController () <MBProgressHUDDelegate,QRCodeReaderDelegate,UMSocialUIDelegate> {
    MBProgressHUD *HUD;
    UIView *menuList;
    UIView *mainView;
    UIButton *loginBtn;
    UILabel *rigLab;
    UILabel *midLab;
    UILabel *leftLab2;
    
}
@property (nonatomic, strong) downTask    *downTask;
@end

@implementation NetViewController
@synthesize isLogined = _isLogined;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        _isLogined = NO;
        
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
    

    
    
    
    if ([_isIn isEqualToString:@"ok"]) {
        return;
    }
    
    BOOL hasPwd = [CLLockVC hasPwd];
    if(!hasPwd){
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            NSLog(@"密码设置成功");
            [lockVC dismiss:1.0f];
            
        }];
    }
    
    
    BOOL lockOn = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockPicMode"] boolValue];
    if(lockOn){
        
        
        if(hasPwd){
            
            [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
                NSLog(@"忘记密码");
            } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                NSLog(@"密码正确");
                LAContext *myContext = [[LAContext alloc] init];
                NSError *authError = nil;
                NSString *myLocalizedReasonString = @"请输入指纹";
                
                if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
                    [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                              localizedReason:myLocalizedReasonString
                                        reply:^(BOOL success, NSError *error) {
                                            if (success) {
                                                return ;
                                                // User authenticated successfully, take appropriate action
                                            } else {
                                                // User did not authenticate successfully, look at error and take appropriate action
                                            }
                                        }];
                } else {
                    // Could not evaluate policy; look at authError and present an appropriate message to user
                }

                [lockVC dismiss:1.0f];
            }];
        }
        
        
        
    }
    
    
}

-(void)initNav{
    UIImageView  *imgIndex=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2+50)];
    [imgIndex setImage:[ UIImage imageNamed:@"index_bg"]];
    [self.view addSubview:imgIndex];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2+50)];
    [self.view addSubview:backView];
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(screen_width/2-screen_height/6, screen_height/6, screen_height/3, screen_height/3);
    [loginBtn setTitle:@"未登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize: 22.0];
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn.layer setCornerRadius:screen_height/6]; //设置矩形四个圆角半径
    [loginBtn.layer setBorderWidth:4]; //边框宽度
    loginBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:loginBtn];
    
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 154, 44)];
    leftLab.font = [UIFont systemFontOfSize:18];
    [leftLab setTextColor:[UIColor  whiteColor]];
    leftLab.text = @"路由管理";
    [backView addSubview:leftLab];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(screen_width-40, 30, 25, 25);
    [Btn setImage:[ UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(rightBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    Btn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:Btn];
    
}

- (void)initView{
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, screen_width, screen_height/2+10)];
    [self.view addSubview:mainView];
    
    UIImageView* line1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 22, screen_width-10, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [mainView addSubview:line1];
    
    leftLab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 154, 44)];
    leftLab2.font = [UIFont systemFontOfSize:12];
    [leftLab2 setTextColor:[UIColor  whiteColor]];
    leftLab2.text = [@"路由器正常工作" stringByAppendingString:[Utils compareCurrentTime:[Utils dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"installDate"]]]];
    [mainView addSubview:leftLab2];
    
    rigLab = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-164, 16, 154, 44)];
    rigLab.textAlignment=2;
    rigLab.font = [UIFont systemFontOfSize:12];
    [rigLab setTextColor:[UIColor  whiteColor]];
    NSString *str = [NSString stringWithFormat:@"%lld",[Utils getInterfaceBytes]/1024/1024/8];
    rigLab.text = [[@"上网流量" stringByAppendingString:str] stringByAppendingString:@"M"];
    [mainView addSubview:rigLab];
    
    UIImageView* line2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 55, screen_width-10, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [mainView addSubview:line2];
    
    midLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 106, screen_width, 84)];
    midLab.textAlignment=1;
    midLab.font = [UIFont systemFontOfSize:55];
    [midLab setTextColor:[UIColor  whiteColor]];
    midLab.text = @"0.0kb/s";
    [mainView addSubview:midLab];
    
    UILabel *botLab = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-154/2, 186, 154, 44)];
    botLab.textAlignment=1;
    botLab.font = [UIFont systemFontOfSize:15];
    [botLab setTextColor:[UIColor  whiteColor]];
    botLab.text = @"当前网速(kb/s)";
    [mainView addSubview:botLab];
    mainView.hidden=YES;
    
    menuList=[[UIView alloc] initWithFrame:CGRectMake(screen_width-140, 69, 130, 80)];
    menuList.backgroundColor=[UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    NSArray *menuName=@[@"扫一扫",@"告诉朋友"];
    
    for (int i=0; i<2; i++) {
        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(10,i*40+5, 28, 28)];
        [img setImage:[ UIImage imageNamed:@"about.png"]];
        [menuList addSubview:img];
        UIButton *menuListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuListBtn.frame = CGRectMake( 40,i*40-5, 90, 50);
        menuListBtn.tag = 100+i;
        menuListBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        [menuListBtn setTitle:menuName[i] forState:UIControlStateNormal];
        [menuListBtn setTitleColor:[UIColor colorWithRed:0.212f green:0.196f blue:0.204f alpha:1.00f] forState:UIControlStateNormal];
        [menuListBtn setTitleColor:[UIColor colorWithRed:0.212f green:0.196f blue:0.204f alpha:1.00f] forState:UIControlStateSelected];
        [menuListBtn addTarget:self action:@selector(OnmenuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menuList addSubview:menuListBtn];
    }
    
    for (int i=0; i<2; i++) {
        UILabel *menuListLine = [[UILabel alloc] init];
        menuListLine.frame = CGRectMake( 0,i*40+41, 130, 0.5);
        menuListLine.backgroundColor=[UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
        [menuList addSubview:menuListLine];
    }
    menuList.hidden = YES;
    [self.view addSubview:menuList];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height/2+50, screen_width, screen_height/2-99)];
    [self.view addSubview:btnView];
    for (int i=0; i<3; i++) {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(i*screen_width/3, 0, screen_width/3, screen_width/3)];
        [btn.layer setBorderWidth:0.5];
        btn.layer.borderColor=[UIColor colorWithRed:0.898f green:0.898f blue:0.898f alpha:1.00f].CGColor;
        
        switch (i) {
            case 0:
            {
                [btn addTarget:self action:@selector(wifiTestBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"Wi-Fi测速";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"home_btn_ic_wifi"]];
                [btn addSubview:img];
            }
                break;
            case 1:
            {
                [btn addTarget:self action:@selector(netBetterBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"网络优化";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"icon_home_net-examine"]];
                [btn addSubview:img];
            }
                break;
                
            case 2:
            {
                [btn addTarget:self action:@selector(netTestBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"网络诊断";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"icon_home_smart"]];
                [btn addSubview:img];
            }
                break;
                
            default:
                break;
                
                
        }
        
        [btnView addSubview:btn];
        
    }
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/3-5, screen_width/3+20, screen_width/3+10, 35)];
    [btn setTitle:@"访客上网" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btn setTitleColor:fontGray forState:UIControlStateNormal];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:7.0];
    [btn.layer setBorderWidth:0.5];
    btn.layer.borderColor=fontGray.CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn addTarget:self action:@selector(guestBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn];
    
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
            midLab.text=[NSString stringWithFormat:@"%0.1f", speed/1024/8];
        }
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}



- (void)viewWillAppear:(BOOL)animated{
    NSArray *usersInformation = [Config getUsersInformation];
    if ([usersInformation[0] isEqualToString:@"点击头像登录"]||usersInformation[0]==NULL) {
        _isLogined=NO;
        loginBtn.hidden=NO;
        mainView.hidden=YES;
        
        
    }else{
        _isLogined=YES;
        loginBtn.hidden=YES;
        mainView.hidden=NO;
    }
    
    NSString *str = [NSString stringWithFormat:@"%lld",[Utils getInterfaceBytes]/1024/1024/8];
    rigLab.text = [[@"wifi流量" stringByAppendingString:str] stringByAppendingString:@"M"];
    
    leftLab2.text = [@"路由器正常工作" stringByAppendingString:[Utils compareCurrentTime:[Utils dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"installDate"]]]];
    
    
    
    
}

- (void)initData{
    /**
     *  数据部分：1.app运行时间，2.上网流量统计，3，网速
     */
    [self testSpeed];
    
    
    [NSTimer scheduledTimerWithTimeInterval:12.0
                                     target:self
                                   selector:@selector(testSpeed)
                                   userInfo:nil
                                    repeats:YES];
    
    
    
}

-(void)rightBtnTap:(UIButton *)sender{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"扫一扫"
                     image:[UIImage imageNamed:@"scan_icon"]
                    target:self
                    action:@selector(pushMenuItemScan)],
      
      [KxMenuItem menuItem:@"告诉朋友"
                     image:[UIImage imageNamed:@"tell_icon"]
                    target:self
                    action:@selector(pushMenuItemShare)],
      
      
      ];
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
    
    
    
}

- (void) pushMenuItemScan{
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
//    __weak typeof (self) wSelf = self;
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]]; 
        
        
//        [wSelf.navigationController popViewControllerAnimated:YES];
//        
//        
//        [[[UIAlertView alloc] initWithTitle:@"扫描结果" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
//        
        
    }];
    
    //[self presentViewController:reader animated:YES completion:NULL];
    
    
}


-(void)pushMenuItemShare{
    NSString *shareText = @"将其分享给好友";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5617b5f1e0f55af05300423f"
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:nil
                                       delegate:self];
    
}

-(void)OnmenuBtn:(UIButton *)sender{
    
    
}



-(void)loginBtnTap:(UIButton *)sender{
    LoginViewController* VC  = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)guestBtnTap:(UIButton *)sender{
    
    
    
    GuestViewController* VC  = [[GuestViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

-(void)netTestBtnTap:(UIButton *)sender{
    
    if (_isLogined) {
        NetTestViewController* VC  = [[NetTestViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        LoginViewController* VC  = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
}

-(void)wifiTestBtnTap:(UIButton *)sender{
    if (_isLogined) {
        WifiTestViewController* VC  = [[WifiTestViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        LoginViewController* VC  = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}
-(void)netBetterBtnTap:(UIButton *)sender{
    
    if (_isLogined) {
        NetBetterViewController* VC  = [[NetBetterViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        LoginViewController* VC  = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
