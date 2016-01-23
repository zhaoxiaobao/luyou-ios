//
//  SecurityProViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "SecurityProViewController.h"

#import "DropMuneView.h"

#import "MBProgressHUD.h"
#import "Utils.h"
#import "Config.h"

@interface SecurityProViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_dataSourceArray;
    UITextField *input;
    NSString *question;
}

@property (nonatomic,strong) UITableView *rightTableView;


@end

static NSString *cellIdent = @"cellIdent";

@implementation SecurityProViewController

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
    navTitle.text=@"设置安全问题";
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    DropMuneView  *dropMenuView = [[DropMuneView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 40)];
    dropMenuView.backgroundColor=white;
    question=[dropMenuView getAnswer];
    
    [self.view addSubview:dropMenuView];
    
}

-(void)initData{
    
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
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
    static NSString *cellIndentifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if(indexPath.section == 0) {
        cell.textLabel.text = @"答案";
        
        
        
        input = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, cell.frame.size.width - 55, 44)];
        input.placeholder = @"不少于十个字";
        input.keyboardType=UIKeyboardTypeDefault;
        input.delegate=self;
        input.clearButtonMode= UITextFieldViewModeWhileEditing;
        input.font = [UIFont systemFontOfSize:14];
        input.returnKeyType=UIReturnKeyGo;
        [cell addSubview:input];
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"确定";
        cell.textLabel.textAlignment=1;
        cell.textLabel.textColor=fontBlue;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)_showRightTableView{
    
    CGFloat height = 100;
    
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, height);
}

- (void)_HiddenRightTableView{
    
    
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, 0);
}


- (UITableView *)rightTableView{
    
    if (!_rightTableView) {
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _rightTableView.frame = CGRectMake(0, 0 , 200, 0);
        
        
    }
    
    return _rightTableView;
    
    
}

-(void)submit{
    
    [Config saveQueAnswer:question andAnswer:input.text];
    
    
    
    MBProgressHUD *HUD = [Utils createHUD];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
    HUD.labelText = @"提交成功";
    [HUD hide:YES afterDelay:0.5];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == input){
        [input becomeFirstResponder];
        [self submit];
    }

    
    return YES;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        [self submit];



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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
