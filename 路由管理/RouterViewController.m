//
//  routerViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "RouterViewController.h"
#import "NetSettingViewController.h"
#import "NetBetterViewController.h"
#import "RouterInfoViewController.h"
#import "NewPwdViewController.h"
#import "LoginViewController.h"

#import "Utils.h"

#import "MBProgressHUD.h"


#import "TFHpple.h"
#import "Config.h"



@interface RouterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
    MBProgressHUD *_HUD;
    
    
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITableView *tableView2;



@end

@implementation RouterViewController

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
    
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"我的路由器";
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


-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 290) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.separatorStyle=NO;
    
    
}

-(void)initData{
    
    /**
     
     无线路由基本信息显示
     入参：无
     出参：wifi名称，wifi登陆密码
     请求方式：post/get
     
     */
    
    
    _dataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"wifi设置" forKey:@"title"];
    [_dataSourceArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    
    NSString *name=[[Utils getWifiInfo:@"1" :@"1" :@"1" :@"1"] objectForKey:@"wifiName"];
    
    
    
    [dic2 setObject:[@"wifi名称：" stringByAppendingString:name] forKey:@"title"];
    [_dataSourceArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"wifi密码：******" forKey:@"title"];
    [_dataSourceArray addObject:dic3];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"修改管理员密码" forKey:@"title"];
    [_dataSourceArray addObject:dic4];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:@"无线路由详细信息" forKey:@"title"];
    [_dataSourceArray addObject:dic5];
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc] init];
    [dic6 setObject:@"安全体检" forKey:@"title"];
    [_dataSourceArray addObject:dic6];
    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc] init];
    [dic7 setObject:@"上网设置" forKey:@"title"];
    [_dataSourceArray addObject:dic7];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView==self.tableView) {
        return 3;
    }
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView==self.tableView) {
        if (section == 0) {
            return 0;
        }else if(section == 1){
            return 7;
        }else{
            return 2;
        }
    }
    
    if (tableView==self.tableView2) {
        return 6;
        
    }
    
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.tableView2) {
        return 35;
    }else{
        return 0.01;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }else{
        
        return 25;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        return 50;
    }else{
        return 40;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    footerView.backgroundColor = RGB(239, 239, 244);
    return footerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
    
    if (tableView==self.tableView2) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,0,100,35)];
        label.text=@"详细信息";
        label.textColor=fontGray;
        label.textAlignment=1;
        [label setFont:[UIFont systemFontOfSize:16]];
        [headerView  addSubview:label];
//    
//        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(135, 5, 25, 25)];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"hclose" ] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(addBtnTap) forControlEvents:UIControlEventTouchUpInside];
//        [headerView addSubview:btn];
        
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(addBtnTap)];
    [headerView  addGestureRecognizer:tapGesture];
    
    headerView.backgroundColor = RGB(239, 239, 244);
    return headerView;
    
}

-(void)addBtnTap{
    [_HUD hide:YES afterDelay:0];
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (tableView==self.tableView) {
        
        if (indexPath.section == 1) {
            if (indexPath.row==0) {
                UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-30, 15, 20, 20)];
                img.image = [UIImage imageNamed:@"home_btn_ic_wifi2"];
                [cell addSubview:img];
            }
            
            if (0<indexPath.row&&indexPath.row<=2) {
                cell.textLabel.textColor=[UIColor colorWithRed:0.549f green:0.553f blue:0.557f alpha:1.00f];
            }
            
            if (indexPath.row>2) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            
            cell.textLabel.text = [_dataSourceArray[indexPath.row] objectForKey:@"title"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }else if (indexPath.section == 0){
            cell.textLabel.text = @"登录状态:未登录";
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-105, 10, 90, 30)];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
            [btn setTitleColor:fontGray forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:7.0];
            [btn.layer setBorderWidth:0.5];
            btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
            btn.layer.borderColor=fontGray.CGColor;
            [btn addTarget:self action:@selector(loginBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }else if (indexPath.section == 2){
            cell.textLabel.text =@[ @"重启路由器", @"路由器配置备份和恢复"][indexPath.row];
            cell.textLabel.textAlignment=1;
            cell.textLabel.textColor=fontBlue;
            
        }
        
    }else if (tableView==self.tableView2){
        
        cell.textLabel.text =@[ @"设备型号：未知",
                                @"生产厂商：未知",
                                @"硬件版本：WR742N 7.0 00000000",
                                @"软件版本：1.0.1 Build 150512 Rel.52192n",
                                @"MAC地址：BC-46-99-04-34-B8",
                                [NSString stringWithFormat:@"外网IP：%@",[Utils deviceIPAdress]]][indexPath.row];
        
        cell.textLabel.font = [UIFont systemFontOfSize: 13.0];
        cell.textLabel.tintColor=fontGray;
        
        
        
        
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView2) {
        return;
    }
    
    
    if (indexPath.section == 1) {
        if (indexPath.row==3) {
            NewPwdViewController *VC = [[NewPwdViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
        
        if (indexPath.row==4) {
            _HUD = [Utils createHUD];
            _HUD.mode = MBProgressHUDModeCustomView;
            _HUD.color=[UIColor whiteColor];
            _HUD.userInteractionEnabled = NO;
            _HUD.customView=self.tableView2;
            [_HUD hide:YES afterDelay:2];            
            
        }
        
        if (indexPath.row==5) {
            NetBetterViewController *VC = [[NetBetterViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
        if (indexPath.row==6) {
            NetSettingViewController *VC = [[NetSettingViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
        
        
    }
    
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            NSString *strUrl=@"http://192.168.1.1/web_reboot.asp?t=2";
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
            [Config deleteOwnAccount];
            
            [self performSelector:@selector(loginView) withObject:self afterDelay:2];
            
            
        }
        if (indexPath.row==0) {
            _HUD = [Utils createHUD];
            _HUD.labelText = @"正在执行....";
            _HUD.userInteractionEnabled = NO;
            [_HUD hide:YES afterDelay:1];
        }
    }
    
}

-(void)loginView{
    LoginViewController*vc=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)loginBtnTap:(UIButton *)sender{
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
