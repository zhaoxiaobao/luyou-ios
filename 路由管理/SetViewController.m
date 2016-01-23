//
//  SetViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "SetViewController.h"
#import "SecurityProViewController.h"
#import "WebViewController.h"

#import "CLLockVC.h"
#import "Config.h"


@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_dataSourceArray;
    UITextField  *_inputIp;
    UITextField  *_inputPort;
    
    UISwitch* swMsg;
    UISwitch* swMsgHall;
    UISwitch* swMsgActivity;
    
    UISwitch* swAutoLogin;
    
    UISwitch* swLock;
    UISwitch* swLockPic;
    UISwitch* swLockPro;
    
}

@end

@implementation SetViewController

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
    navTitle.text=@"设置";
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
    /**
     *
     
     实现推送：
     入参：是否推送（bool），活动广场是否开启（bool），消息大厅（bool）
     出参：请求是否成功（bool）
     方式：post
     
     实现是否自动登陆：
     入参：是否自动登陆（int），ip地址（string），登陆端口（int）
     出参：标示符（bool）
     方式：post
     
     实现文件存储：入参：是否推送（bool）
     出参：请求是否成功（bool）
     方式：post
     
     *
     */
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.5];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-100);
    [UIView commitAnimations];
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64+100);

    //设置动画结束
    [UIView commitAnimations];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section <3) {
        return 3;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 40;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 45)];
        view.backgroundColor = RGB(239, 239, 244);
        
        UILabel *labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(20,20,screen_width-20,20)];
        labelSmall.text=@"仅适合于ap模式等dhcp关闭，登录地址更改的场景";
        labelSmall.textColor=fontGray;
        //    labelSmall.textAlignment=1;
        [labelSmall setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:labelSmall];
        
        return view;
        
        
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    footerView.backgroundColor = RGB(239, 239, 244);
    return footerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
    headerView.backgroundColor = RGB(239, 239, 244);
    return headerView;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIndentifier =  [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    //cell 重用导致创建多个视图
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @[@"新消息提示", @"消息大厅", @"活动广场"][indexPath.row];
        if(indexPath.row==0){
            swMsg = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swMsg setTintColor:navigationBarColor];
            [swMsg setOnTintColor:navigationBarColor];
            [swMsg addTarget:self action:@selector(btnOpenMsg:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwMsgMode"] boolValue];
            [swMsg setOn:on];
            [cell addSubview:swMsg];
            
            
        }
        
        if(indexPath.row==1){
            swMsgHall = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swMsgHall setTintColor:navigationBarColor];
            [swMsgHall setOnTintColor:navigationBarColor];
            [swMsgHall addTarget:self action:@selector(btnOpenMsgHall:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwMsgHallMode"] boolValue];
            [swMsgHall setOn:on];
            [cell addSubview:swMsgHall];
            
            
        }
        if(indexPath.row==2){
            swMsgActivity = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swMsgActivity setTintColor:navigationBarColor];
            [swMsgActivity setOnTintColor:navigationBarColor];
            [swMsgActivity addTarget:self action:@selector(btnOpenActivity:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwMsgActivityMode"] boolValue];
            [swMsgActivity setOn:on];
            [cell addSubview:swMsgActivity];
            
            
        }
        
        if (indexPath.row>0) {
            cell.textLabel.font= [UIFont systemFontOfSize:14];
            cell.textLabel.textColor=fontGray;
        }
        
        
        
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else if(indexPath.section == 1) {
        cell.textLabel.text = @[@"自动登录", @"登录地址", @"登录端口"][indexPath.row];
        if(indexPath.row==0){
            swAutoLogin = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swAutoLogin setTintColor:navigationBarColor];
            [swAutoLogin setOnTintColor:navigationBarColor];
            [swAutoLogin addTarget:self action:@selector(btnOpenAutoLogin:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwAutoLoginMode"] boolValue];
            [swAutoLogin setOn:on];
            [cell addSubview:swAutoLogin];
            
            
            
        }
        
        if(indexPath.row==1){
            
            UITextField *input = [[UITextField alloc] initWithFrame:CGRectMake(105, 0, cell.frame.size.width - 105, 44)];
            input.placeholder = @"输入登录地址";
            input.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            input.clearButtonMode= UITextFieldViewModeWhileEditing;
            input.font = [UIFont systemFontOfSize:14];
            input.returnKeyType=UIReturnKeyNext;
            input.enablesReturnKeyAutomatically = YES;
            input.delegate=self;
            _inputIp=input;
            [cell addSubview:input];
            cell.textLabel.font= [UIFont systemFontOfSize:14];
            cell.textLabel.textColor=fontGray;
            
            
        }
        
        if(indexPath.row==2){
            
            UITextField *input = [[UITextField alloc] initWithFrame:CGRectMake(105, 0, cell.frame.size.width - 105, 44)];
            input.placeholder = @"输入登录端口";
            input.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            input.clearButtonMode= UITextFieldViewModeWhileEditing;
            input.font = [UIFont systemFontOfSize:14];
            input.returnKeyType=UIReturnKeyDone;
            input.enablesReturnKeyAutomatically = YES;
            input.delegate=self;
            _inputPort=input;
            [cell addSubview:input];
            cell.textLabel.font= [UIFont systemFontOfSize:14];
            cell.textLabel.textColor=fontGray;
            
        }
        
        
    }else if(indexPath.section == 2) {
        cell.textLabel.text = @[@"使用程序锁", @"绘制程序锁", @"设置安全问题"][indexPath.row];
        if(indexPath.row==0){
            swLock = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swLock setTintColor:navigationBarColor];
            [swLock setOnTintColor:navigationBarColor];
            [swLock addTarget:self action:@selector(btnOpenLock:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockMode"] boolValue];
            [swLock setOn:on];
            [cell addSubview:swLock];
            
        }
        if(indexPath.row==1){
            swLockPic = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swLockPic setTintColor:navigationBarColor];
            [swLockPic setOnTintColor:navigationBarColor];
            [swLockPic addTarget:self action:@selector(btnOpenLockPic:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockPicMode"] boolValue];
            [swLockPic setOn:on];
            [cell addSubview:swLockPic];
            
        }
        if(indexPath.row==2){
            swLockPro = [[UISwitch alloc] initWithFrame:CGRectMake(screen_width - 60, 5, screen_width - 50, 34)];
            [swLockPro setTintColor:navigationBarColor];
            [swLockPro setOnTintColor:navigationBarColor];
            [swLockPro addTarget:self action:@selector(btnOpenLockPro:) forControlEvents:UIControlEventValueChanged];
            BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockProMode"] boolValue];
            [swLockPro setOn:on];
            [cell addSubview:swLockPro];
            
        }
        
        if (indexPath.row>0) {
            cell.textLabel.font= [UIFont systemFontOfSize:14];
            cell.textLabel.textColor=fontGray;
        }
        
        
    }else if(indexPath.section == 3) {
        cell.textLabel.text = @"文件存储";
        
    }else if(indexPath.section == 4) {
        cell.textLabel.text = @"访问网页";
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _inputIp)
    {
        [_inputIp resignFirstResponder];
        [_inputPort becomeFirstResponder];
    }
    else
    {
        [_inputPort resignFirstResponder];
        //然后调用你的登录函数
    }
    
    return YES;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==2){
        if (indexPath.row==2) {
            SecurityProViewController *VC = [[SecurityProViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
        
        if (indexPath.row==1) {
            
            
            
            
            
            
        }
        
    }
    
    
    if (indexPath.section==4) {
        WebViewController *VC = [[WebViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
}




//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)btnOpenMsg:(id)sender{
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwMsgMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (btn.on==true) {
        [swMsgHall setOn:true];
        [swMsgActivity setOn:true];
    }else{
        [swMsgHall setOn:NO];
        [swMsgActivity setOn:NO];
    }
    
    
}

-(void)btnOpenMsgHall:(id)sender{
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwMsgHallMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BOOL SwMsgActivityMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwMsgActivityMode"] boolValue];
    if (btn.on==true) {
        [swMsg setOn:true];
    }else{
        if (SwMsgActivityMode) {
            [swMsg setOn:NO];
        }
        
    }
    
}

-(void)btnOpenActivity:(id)sender{
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwMsgActivityMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BOOL SwMsgHallMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwMsgHallMode"] boolValue];
    if (btn.on==true) {
        [swMsg setOn:true];
    }else{
        if (SwMsgHallMode) {
            [swMsg setOn:NO];
        }
        
    }
}

-(void)btnOpenAutoLogin:(id)sender{
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwAutoLoginMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)btnOpenLock:(id)sender{
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwLockMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (btn.on==true) {
        [swLockPic setOn:true];
        [swLockPro setOn:true];
    }else{
        [swLockPic setOn:NO];
        [swLockPro setOn:NO];
    }
}

-(void)btnOpenLockPic:(id)sender{
    
    BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockPicMode"] boolValue];
    
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    
    if(!hasPwd&&!on){
        
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            NSLog(@"密码设置成功");
            [lockVC dismiss:1.0f];
            
        }];
        
        
        
    }
    
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwLockPicMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BOOL SwLockProMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockProMode"] boolValue];
    if (btn.on==true) {
        [swLock setOn:true];
    }else{
        if (SwLockProMode) {
            [swLock setOn:NO];
        }
        
    }
}



-(void)btnOpenLockPro:(id)sender{
    UISwitch* btn = (UISwitch*)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:btn.on] forKey:@"SwLockProMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BOOL SwLockPicMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SwLockPicMode"] boolValue];
    if (btn.on==true) {
        [swLock setOn:true];
    }else{
        if (SwLockPicMode) {
            [swLock setOn:NO];
        }
        
    }
}


-(void)btnOpenWifi:(UIButton *)sender{
    
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
