//
//  MoreViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/9.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "MoreViewController.h"
#import "SupportDevViewController.h"
#import "AboutViewController.h"
#import "HelpViewController.h"
#import "UpdateViewController.h"
#import "SetViewController.h"
#import "FeedBackViewController.h"

#import "KxMenu.h"
#import "QRCodeReaderViewController.h"

#import "UMSocial.h"

#import "MBProgressHUD.h"
#import "Utils.h"

#import "Config.h"

@interface MoreViewController ()<QRCodeReaderDelegate,UMSocialUIDelegate>{
    UIView *menuList;
    MBProgressHUD *HUD;

}

@end

@implementation MoreViewController

@synthesize isLogined = _isLogined;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        _isLogined = NO;
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    NSArray *usersInformation = [Config getUsersInformation];
    if ([usersInformation[0] isEqualToString:@"点击头像登录"]||usersInformation[0]==NULL) {
        _isLogined=NO;

        
        
    }else{
        _isLogined=YES;

    }
    

    
}


- (void)viewDidLoad {
    [UMSocialData setAppKey:@"5617b5f1e0f55af05300423f"];
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
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
    navTitle.text=@"更多";
    navTitle.textAlignment=1;
    navTitle.textColor=[UIColor whiteColor];
    navTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    [backView addSubview:navTitle];
    
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(screen_width-30, 30, 15, 25);
    [Btn setImage:[ UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(menuBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    Btn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:Btn];
    
    
}




- (void)initView{
    
    
    menuList=[[UIView alloc] initWithFrame:CGRectMake(screen_width-140, 69, 130, 80)];
    menuList.backgroundColor=[UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    NSArray *menuName=@[@"扫一扫",@"告诉朋友"];
    
    for (int i=0; i<2; i++) {
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


    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-2*screen_width/3-49, screen_width, 2*screen_width/3)];
    btnView.backgroundColor=[UIColor colorWithRed:0.937f green:0.937f blue:0.937f alpha:1.00f];
    [self.view addSubview:btnView];
    
    for (int i=0; i<6; i++) {
        int x,y;
        if (i<3) {
            x=i;y=0;
        }else{
            x=i-3;y=screen_width/3;
            
        }
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(x*screen_width/3, y, screen_width/3, screen_width/3)];
        [btn.layer setBorderWidth:0.5]; //边框宽度
        btn.layer.borderColor=[UIColor colorWithRed:0.898f green:0.898f blue:0.898f alpha:1.00f].CGColor;
        
        
        
        switch (i) {
            case 0:
            {
                [btn addTarget:self action:@selector(supportBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"支持设备";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"M1"]];
                [btn addSubview:img];
                
                
            }
                break;
            case 1:
            {
                                [btn addTarget:self action:@selector(aboutBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"关于我们";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"M2"]];
                [btn addSubview:img];
                
                
            }
                break;
                
            case 2:
            {
                [btn addTarget:self action:@selector(setBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"设置";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"M3"]];
                [btn addSubview:img];
                
                
            }
                break;
            case 3:
            {
                [btn addTarget:self action:@selector(helpBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"帮助";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"M4"]];
                [btn addSubview:img];
                
                
            }
                break;
                
            case 4:
            {
                [btn addTarget:self action:@selector(updateBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"其他";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"M5"]];
                [btn addSubview:img];
                
                
            }
                break;
                
            case 5:
            {
                [btn addTarget:self action:@selector(feedBackBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,screen_width/3-40,screen_width/3,30)];
                label.text=@"意见反馈";
                label.textColor=fontGray;
                label.textAlignment=1;
                [label setFont:[UIFont systemFontOfSize:16]];
                [btn addSubview:label];
                
                
                UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(33,18,screen_width/3-66,screen_width/3-66)];
                [img setImage:[ UIImage imageNamed:@"M6"]];
                [btn addSubview:img];
                
                
            }
                break;
                
            default:
                break;
        }
        
        [btnView addSubview:btn];
        
    }
    
}


- (void)initData{
    
}



//响应事件
-(void)menuBtnTap:(UIButton *)sender{
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
    
    __weak typeof (self) wSelf = self;
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [wSelf.navigationController popViewControllerAnimated:YES];
        [[[UIAlertView alloc] initWithTitle:@"" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
    }];
    
    //[self presentViewController:reader animated:YES completion:NULL];
    [self.navigationController pushViewController:reader animated:YES];
    
    
}

-(void)pushMenuItemShare{
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
//    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5617b5f1e0f55af05300423f"
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:nil
                                       delegate:self];
    
}


-(void)OnmenuBtn:(UIButton *)sender{
    
}


-(void)supportBtnTap:(UIButton *)sender{
    SupportDevViewController* VC  = [[SupportDevViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)setBtnTap:(UIButton *)sender{
    if (!_isLogined) {
        HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        HUD.labelText = @"还没有登录";
        [HUD hide:YES afterDelay:0.5];
        return;
    }
    
    SetViewController *VC  = [[SetViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)aboutBtnTap:(UIButton *)sender{
    AboutViewController *VC  = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)updateBtnTap:(UIButton *)sender{
//    HUD = [Utils createHUD];
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.labelText = @"已经是最新版本了~";
//    [HUD hide:YES afterDelay:0.5];
}

-(void)feedBackBtnTap:(UIButton *)sender{
    if (!_isLogined) {
        HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        HUD.labelText = @"还没有登录";
        [HUD hide:YES afterDelay:0.5];
        return;
    }
    FeedBackViewController *VC  = [[FeedBackViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)helpBtnTap:(UIButton *)sender{
    HelpViewController *VC  = [[HelpViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
