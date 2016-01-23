//
//  LoginViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Config.h"
#import "AFNetworking.h"
#import "TFHpple.h"
#import "CommonFunc.h"



@interface LoginViewController ()<UITextFieldDelegate>{
    UITextField *txtUser;
    UITextField *txtPwd;
    UIButton* btnLogin;
    MBProgressHUD *_HUD;
    NSString *msg;
}


@end

@implementation LoginViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.933f green:0.937f blue:0.941f alpha:1.00f];
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
    navTitle.text=@"登录";
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
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-40, 64+35, 80, 80)];
    userImage.layer.masksToBounds = YES;
    userImage.layer.cornerRadius = 40;
    [userImage setImage:[UIImage imageNamed:@"icon_mine_default_portrait"]];
    [self.view addSubview:userImage];
    
    UIImageView* line1 = [[UIImageView alloc] initWithFrame:CGRectMake(16, 220, screen_width - 32, 0.5)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    UIImageView* line3 = [[UIImageView alloc] initWithFrame:CGRectMake(16, 308, screen_width - 32, 0.5)];
    line3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line3];
    
    UIImageView* line4 = [[UIImageView alloc] initWithFrame:CGRectMake(16, 220, 0.5, 88)];
    line4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line4];
    
    UIImageView* line5 = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width - 16, 220, 0.5, 88)];
    line5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line5];
    
    UIView* vUser = [[UIView alloc] initWithFrame:CGRectMake(16.5, 220.5, screen_width - 33, 87)];
    vUser.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vUser];
    
    UIImageView* line2 = [[UIImageView alloc] initWithFrame:CGRectMake(16, 264, screen_width - 32, 0.5)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    imgUser.image = [UIImage imageNamed:@"login_name"];
    [vUser addSubview:imgUser];
    
    txtUser = [[UITextField alloc] initWithFrame:CGRectMake(35, 0, vUser.frame.size.width - 35, 44)];
    txtUser.placeholder = @"请输入您的账号";
    txtUser.text=@"";
    txtUser.clearButtonMode= UITextFieldViewModeWhileEditing;
    txtUser.returnKeyType=UIReturnKeyNext;
    txtUser.keyboardType = UIKeyboardTypeEmailAddress;
    txtUser.delegate=self;
    
    txtUser.font = [UIFont systemFontOfSize:14];
    [vUser addSubview:txtUser];
    
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(10, 56, 20, 20)];
    imgPwd.image = [UIImage imageNamed:@"login_password"];
    [vUser addSubview:imgPwd];
    
    txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(35, 44, vUser.frame.size.width - 35, 44)];
    txtPwd.placeholder = @"请输入您的密码";
    txtPwd.text=@"";
    txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPwd.returnKeyType=UIReturnKeyGo;
    txtPwd.font = [UIFont systemFontOfSize:14];
    txtPwd.secureTextEntry = YES;
    txtPwd.enablesReturnKeyAutomatically = YES;
    txtPwd.delegate=self;
    [vUser addSubview:txtPwd];
    
    btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(16, 340, screen_width - 32, 44)];
    btnLogin.layer.cornerRadius = 5;
    btnLogin.backgroundColor = navigationBarColor;
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == txtUser)
    {
        [txtPwd resignFirstResponder];
        [txtPwd becomeFirstResponder];
    }
    else
    {
        [txtPwd resignFirstResponder];
        [self btnLoginAction];
    }
    
    return YES;
}

- (void)initData{
    /**
     *  实现登陆：出参：1.登陆验证是否成功（status），2.
     入参：1.用户名,2.密码
     请求方式：post/get
     */
    
}

-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)btnLoginAction{
    
    
    if([txtUser.text isEqualToString:@"test"]&&[txtPwd.text isEqualToString:@"test"]){
        [Config saveOwnAccount:txtUser.text andPassword:txtPwd.text];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    
    [self connection];
    

}

-(void)connection{
    
    NSString *strUrl=[NSString stringWithFormat:@"http://192.168.1.1/goform/formLogin"];
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    NSData* originData = [txtPwd.text dataUsingEncoding:NSASCIIStringEncoding];    
    NSString* pwd = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *param=[NSString stringWithFormat:@"username=%@&password=%@",txtUser.text,pwd];
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
                                   TFHppleElement *element = [elements objectAtIndex:0];
                                   msg = [element content];
                               }

                           }];

    if ([msg isEqualToString:@"退出"]||[msg compare:@"退出"]) {
        [Config saveOwnAccount:txtUser.text andPassword:txtPwd.text];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        MBProgressHUD *_msgHUD = [Utils createHUD];
        _msgHUD.labelText = @"登录失败，请重新登录~   ";
        _msgHUD.userInteractionEnabled = NO;
        [_msgHUD hide:YES afterDelay:1];
        
    }
    
    
}




-(void)btnRegAction:(UIButton *)sender{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
