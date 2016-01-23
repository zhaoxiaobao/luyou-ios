//
//  MineViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/9.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "MineViewController.h"
#import "TerminalViewController.h"
#import "NetSpeedViewController.h"
#import "RouterViewController.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "TFHpple.h"
#import "Config.h"
#import "LoginViewController.h"
#import "JHCustomMenu.h"

#import "UMSocial.h"

#import "KxMenu.h"




@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate,JHCustomMenuDelegate>
{
    NSMutableArray *_dataSourceArray;
    UIButton *btnLoginOut;
    UIImageView *userImage;
    UILabel *userNameLabel;
    MBProgressHUD *HUD;
    MBProgressHUD *_HUD;
    
}

@property (nonatomic, strong) JHCustomMenu *menu;



@end

@implementation MineViewController
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
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    [self initView];
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *usersInformation = [Config getUsersInformation];
    if ([usersInformation[0] isEqualToString:@"点击头像登录"]||usersInformation[0]==NULL) {
        _isLogined=NO;
        
        
    }else{
        _isLogined=YES;
    }
    
    
    [self.tableView reloadData];
    userNameLabel.text = usersInformation[0];
    [userImage setImage:[UIImage imageNamed:usersInformation[1]]];
}

-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, bar_height)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
}



-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, screen_width, screen_height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)initData{
    _dataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"查看终端设备" forKey:@"title"];
    [dic1 setObject:@"ic_app_center_extender" forKey:@"image"];
    [_dataSourceArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"我的路由器" forKey:@"title"];
    [dic2 setObject:@"ic_app_center_moca" forKey:@"image"];
    [_dataSourceArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"网速控制" forKey:@"title"];
    [dic3 setObject:@"ic_app_center_channel_choose" forKey:@"image"];
    [_dataSourceArray addObject:dic3];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"儿童锁" forKey:@"title"];
    [dic4 setObject:@"ic_app_center_children" forKey:@"image"];
    [_dataSourceArray addObject:dic4];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:@"文件分享" forKey:@"title"];
    [dic5 setObject:@"ic_device_model_default" forKey:@"image"];
    [_dataSourceArray addObject:dic5];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 95;
    }else{
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    footerView.backgroundColor = RGB(239, 239, 244);
    return footerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        NSArray *usersInformation = [Config getUsersInformation];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 95)];
        UIImageView  *imgIndex=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 95)];
        [imgIndex setImage:[ UIImage imageNamed:@"top_bg"]];
        [headerView addSubview:imgIndex];
        
        userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 55, 55)];
        userImage.layer.masksToBounds = YES;
        userImage.layer.cornerRadius = 27;
        [userImage setImage:[UIImage imageNamed:usersInformation[1]]];
        [headerView addSubview:userImage];
        
        if (!_isLogined) {
            UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            loginBtn.frame = CGRectMake(10, 30, 55, 55);
            [loginBtn addTarget:self action:@selector(loginBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:loginBtn];
        }
        
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+55+5, 35, 100, 30)];
        userNameLabel.font = [UIFont systemFontOfSize:13];
        [userNameLabel setTextColor:[UIColor  whiteColor]];
        userNameLabel.text = usersInformation[0];
        [headerView addSubview:userNameLabel];
        
        UIButton *logOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+55+5, 60+5, 100, 20)];
        logOutBtn.contentHorizontalAlignment=1;
        logOutBtn.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        
        [logOutBtn setTitleColor:white forState:UIControlStateNormal];
        if (_isLogined) {
            [logOutBtn setTitle:@"退出" forState:UIControlStateNormal];
            [logOutBtn addTarget:self action:@selector(loginOutBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            [logOutBtn setTitle:@"未登录" forState:UIControlStateNormal];
            [logOutBtn addTarget:self action:@selector(loginBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [headerView addSubview:logOutBtn];
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-10-24, 30, 12, 24)];
        [arrowImg setImage:[UIImage imageNamed:@"icon_mine_accountViewRightArrow"]];
        [headerView addSubview: arrowImg];
        
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-35, 50, 20, 20)];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"share_mine.png" ] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
        
        
        
        
        return headerView;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
        headerView.backgroundColor = RGB(239, 239, 244);
        return headerView;
    }
    
}


-(void)addBtnTap:(UIButton *)sender{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"分享二维码"
                     image:[UIImage imageNamed:@"分享二维码"]
                    target:self
                    action:@selector(pushMenuItemShare)],
      
      
      [KxMenuItem menuItem:@"换个图案"
                     image:[UIImage imageNamed:@"换个图案"]
                    target:self
                    action:@selector(pushMenuItemShare)],
      
      
      
      ];
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
    
    
    
}



-(void)pushMenuItemShare{
}

- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select: %ld", indexPath.row);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [_dataSourceArray[indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [_dataSourceArray[indexPath.row] objectForKey:@"image"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}

-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)loginBtnTap:(UIButton *)sender{
    
    if (_isLogined) {
    }else{
        LoginViewController* VC  = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
}

-(void)loginOutBtnTap:(UIButton *)sender{
    if(_isLogined){
        [Config deleteOwnAccount];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
            [cookieStorage deleteCookie:cookie];
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:nil forKey:@"account"];
        HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
        HUD.labelText = @"注销成功";
        [HUD hide:YES afterDelay:0.5];
    }
    LoginViewController*vc=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (!_isLogined) {
            HUD = [Utils createHUD];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            HUD.labelText = @"还没有登录";
            [HUD hide:YES afterDelay:0.5];
            return;
        }
        
        if(indexPath.row==0){
            TerminalViewController* VC  = [[TerminalViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row==1){
            RouterViewController* VC  = [[RouterViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row==2){
            _HUD = [Utils createHUD];
            _HUD.labelText = @"还在玩命开发中....";
            _HUD.userInteractionEnabled = NO;
            [_HUD hide:YES afterDelay:1];
            //            [Config deleteOwnAccount];
            
            //            NetSpeedViewController * VC  = [[NetSpeedViewController alloc] init];
            //            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
        if(indexPath.row==4){
            NSString *shareText = @"将其分享给好友";
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"5617b5f1e0f55af05300423f"
                                              shareText:shareText
                                             shareImage:nil
                                        shareToSnsNames:nil
                                               delegate:self];
            
        }
        
        
        if (indexPath.row==3) {
            NSString *strUrl=@"http://192.168.1.1/child_filtering.asp";
            NSURL *url=[NSURL URLWithString:strUrl];
            NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
            [request setHTTPMethod:@"GET"];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:queue
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                                       
                                       NSLog(@"data was returned.----%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                                       NSLog(@"error was returned.----%@",error);
                                       
                                       TFHpple *xpathparser = [[TFHpple  alloc]initWithHTMLData:data];
                                       NSArray *elements = [xpathparser  searchWithXPathQuery:@"html/body/div/form/text()"];
                                       
                                       
                                       if ([elements count] > 0)
                                       {
                                           
                                           
                                           
                                           
                                           
                                       }else{
                                           
                                       }
                                       
                                   }
             
             
             
             
             ];
            
            _HUD = [Utils createHUD];
            _HUD.labelText = @"正在执行....";
            _HUD.userInteractionEnabled = NO;
            [_HUD hide:YES afterDelay:1];
            
            
            
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
