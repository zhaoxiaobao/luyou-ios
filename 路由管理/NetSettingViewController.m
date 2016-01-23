//
//  NetSettingViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/11.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "NetSettingViewController.h"
#import "Reachability.h"

#import "Utils.h"
#import "MBProgressHUD.h"

#import "AutoGetViewController.h"
#import "ADSLViewController.h"
#import "StaticIPViewController.h"

#import "WebViewController.h"




@interface NetSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
    MBProgressHUD *_HUD;
    
}

@end

@implementation NetSettingViewController

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
    navTitle.text=@"上网设置";
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
}

-(void)initData{
    _dataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"自动获取" forKey:@"title"];
    [_dataSourceArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"ADSL拨号" forKey:@"title"];
    [_dataSourceArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"静态IP" forKey:@"title"];
    [_dataSourceArray addObject:dic3];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==1){
        return 3;
        
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0||section==1) {
        return 0.01;
    }
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 130;
    }
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
        view.backgroundColor = RGB(239, 239, 244);
        
        UILabel *labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(20,20,screen_width-20,20)];
        labelSmall.text=@">请确定路由器WAN口已经连接好网线";
        labelSmall.textColor=fontGray;
        [labelSmall setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:labelSmall];
        
        
        UILabel *labelSmall2=[[UILabel alloc] initWithFrame:CGRectMake(20,40,screen_width-20,20)];
        labelSmall2.text=@">上网设置已恢复出厂设置";
        labelSmall2.textColor=fontGray;
        [labelSmall2 setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:labelSmall2];
        
        UILabel *labelSmall3=[[UILabel alloc] initWithFrame:CGRectMake(20,60,screen_width-20,20)];
        labelSmall3.text=@">此设置不能正常上网";
        labelSmall3.textColor=fontGray;
        [labelSmall3 setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:labelSmall3];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20,view.frame.size.height+20,screen_width-20,20)];
        label.text=@"请选择";
        label.textColor=fontGray;
        [label setFont:[UIFont systemFontOfSize:16]];
        [view addSubview:label];
        
        return view;
        
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    view.backgroundColor = RGB(239, 239, 244);
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
    headerView.backgroundColor = RGB(239, 239, 244);
    return headerView;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    if(indexPath.section==1){
        cell.textLabel.text = [_dataSourceArray[indexPath.row] objectForKey:@"title"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.section==0){
        cell.textLabel.text = @"上网方式";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.section==2){
        cell.textLabel.text = @"检测网络";
        cell.textLabel.textAlignment=1;
        cell.textLabel.textColor=fontBlue;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        
        WebViewController* VC  = [[WebViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
//        if (indexPath.row==0) {
//            AutoGetViewController* VC  = [[AutoGetViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
//        if (indexPath.row==1) {
//            ADSLViewController* VC  = [[ADSLViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
//        if (indexPath.row==2) {
//            StaticIPViewController* VC  = [[StaticIPViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
        
        
    }

    
    
    
    if(indexPath.section==2){
        Reachability *reachability=[Reachability reachabilityWithHostname:@"www.baidu.com"];
        
        if ([reachability isReachable]) {
            _HUD = [Utils createHUD];
            _HUD.labelText = @"wifi已连接....";
            _HUD.userInteractionEnabled = NO;
            [_HUD hide:YES afterDelay:1];
        }else{
            _HUD = [Utils createHUD];
            _HUD.labelText = @"没有网络....";
            _HUD.userInteractionEnabled = NO;
            [_HUD hide:YES afterDelay:1];
        }
        
    }
    
}



//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
