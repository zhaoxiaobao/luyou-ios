//
//  NetSettingViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/11.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "NewPwdViewController.h"
#import "LoginViewController.h"
#import "TFHpple.h"
#import "Config.h"
#import "Utils.h"
#import "MBProgressHUD.h"




@interface NewPwdViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
    
    UITextField *txtPwd;
    UITextField *txtUser;
    
    MBProgressHUD *_HUD;

}

@end

@implementation NewPwdViewController

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
    navTitle.text=@"修改管理员密码";
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

    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0){
        return 0;
        
    }
    
    if (section==1){
        return 2;
        
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0){
        
        return 50;
        
        
    }
    
    if (section==1) {
        return 0.01;
    }
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 50;
    }
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 0.01;
    }
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
        view.backgroundColor = RGB(239, 239, 244);
        
        UILabel *labelSmall=[[UILabel alloc] initWithFrame:CGRectMake(20,20,screen_width-20,20)];
        labelSmall.text=@">此密码用于路由器登录后台密码，而非wifi接入密码";
        labelSmall.textColor=fontGray;
        //    labelSmall.textAlignment=1;
        [labelSmall setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:labelSmall];
        
        return view;
        
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    view.backgroundColor = RGB(239, 239, 244);
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 75)];
    headerView.backgroundColor = white;
    if (section==0){
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen_width-100, 50)];
    label.text=@"登录状态：未登录";
    label.textColor=fontGray;
    label.textAlignment=0;
    [label setFont:[UIFont systemFontOfSize:16]];
    [headerView  addSubview:label];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-100, 10, 80, 30)];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btn setTitleColor:fontGray forState:UIControlStateNormal];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:7.0];
    [btn.layer setBorderWidth:0.5];
    btn.layer.borderColor=fontGray.CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn addTarget:self action:@selector(addBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
        
        
    }
    
    return headerView;
    
}

-(void)addBtnTap:(UIButton *)sender{
    
    LoginViewController* VC  = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
   
    if(indexPath.section==1){
        
        if(indexPath.row==0){

            
            txtUser = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, cell.frame.size.width - 15, 44)];
            txtUser.placeholder = @"输入新用户名";
            txtUser.keyboardType = UIKeyboardTypeEmailAddress;
            txtUser.clearButtonMode= UITextFieldViewModeWhileEditing;
            txtUser.font = [UIFont systemFontOfSize:14];
            [cell addSubview:txtUser];
            
            
        }
        
        if(indexPath.row==1){
            
            
            txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, cell.frame.size.width - 15, 44)];
            txtPwd.placeholder = @"输入新密码";
            txtPwd.keyboardType=UIKeyboardTypeEmailAddress;
            txtPwd.clearButtonMode= UITextFieldViewModeWhileEditing;
            txtPwd.font = [UIFont systemFontOfSize:14];
            txtPwd.secureTextEntry = YES;

            [cell addSubview:txtPwd];
            
            
        }
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        
        
        
        
    }
    if(indexPath.section==2){
        cell.textLabel.text = @"确认提交";
        cell.textLabel.textAlignment=1;
        cell.textLabel.textColor=fontBlue;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        [self connection];
    }
}

-(void)connection{
    
    NSString *strUrl=[NSString stringWithFormat:@"http://192.168.1.1/goform/setSysAdm"];
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    NSData* originData = [txtPwd.text dataUsingEncoding:NSASCIIStringEncoding];
    NSString* pwd = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"encodeResult:%@",pwd);
    
    NSString *param=[NSString stringWithFormat:@"admuser=%@&admpass=%@admpass2nd=%@",txtUser.text,pwd,pwd];
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];

    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               NSLog(@"data was returned.----%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                               NSLog(@"error was returned.----%@",error);
                               TFHpple *xpathparser = [[TFHpple  alloc]initWithHTMLData:data];
                               NSArray *elements = [xpathparser  searchWithXPathQuery:@"//*[@id='mb7']/text()"];
                               if ([elements count] > 0)
                               {
//                                   TFHppleElement *element = [elements objectAtIndex:0];
                               }

                           }];
    
    _HUD = [Utils createHUD];
    _HUD.labelText = @"正在执行....";
    _HUD.userInteractionEnabled = NO;
    [_HUD hide:YES afterDelay:1];
    
    [self performSelector:@selector(backBtnTap2) withObject:self afterDelay:2];

    
    
}

//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)backBtnTap2{
    _HUD = [Utils createHUD];
    _HUD.labelText = @"修改完成....";
    _HUD.userInteractionEnabled = NO;
    [_HUD hide:YES afterDelay:0.5];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loginBtnTap:(UIButton *)sender{
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
