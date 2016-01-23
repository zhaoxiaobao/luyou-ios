//
//  feedBookViewController.m
//
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "FeedBackViewController.h"

#import "MBProgressHUD.h"
#import "Utils.h"

@interface FeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate,UITextFieldDelegate>{
    UITextField * tf_LinkWay;
    UITextView * tv_FeedBackContent;
    
}


@end

@implementation FeedBackViewController

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
    navTitle.text=@"反馈";
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
    [self addLabel:CGRectMake(10, 85, 260, 16) view:self.view font:16 text:@"联系方式（Email或者QQ)" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
    
    tf_LinkWay = [self addTextField:CGRectMake(10, 115, screen_width-20, 45) withPlaceholder:nil withview:self.view withtag:21110];
    tf_LinkWay.delegate=self;
    [self.view addSubview:tf_LinkWay];
    
    [self addLabel:CGRectMake(10, 175, 260, 16) view:self.view font:16 text:@"反馈内容" backgroudcolor:[UIColor clearColor] textcolor:[UIColor blackColor]];
    
    tv_FeedBackContent = [self addTextView:CGRectMake(10, 205, screen_width-20, 120) view:self.view];
    tv_FeedBackContent.delegate=self;
    [self.view addSubview:tv_FeedBackContent];

    UIButton * submitFeedBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitFeedBack setFrame:CGRectMake(10, 335, 93, 34)];
    submitFeedBack.backgroundColor=navigationBarColor;
    [submitFeedBack setTitle:@"提交反馈" forState:UIControlStateNormal];
    [submitFeedBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitFeedBack.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitFeedBack addTarget:self action:@selector(submitFeedBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitFeedBack];
    
    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-80, 330, 70, 34)];
    tishiLabel.font = [UIFont systemFontOfSize:15];
    tishiLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
    tishiLabel.text = @"限200字";
    [self.view addSubview:tishiLabel];

    
}


- (UILabel *)addLabel:(CGRect)frame view:(UIView*)view font:(CGFloat)font text:(NSString *)text backgroudcolor:(UIColor *)bcolor textcolor:(UIColor*)tcolor
{
    UILabel * lb = [[UILabel alloc]initWithFrame:frame];
    [lb setFont:[UIFont systemFontOfSize:font]];
    [lb setTextColor:tcolor];
    [lb setText:text];
    [lb setBackgroundColor:bcolor];
    [view addSubview:lb];
    return lb;
}

- (UITextField*)addTextField:(CGRect)frame withPlaceholder:(NSString*)aText withview:(UIView *)vw withtag:(NSInteger)tg
{

    
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.delegate = self;
    [field setBackgroundColor:[UIColor clearColor]];
    field.clearsOnBeginEditing = NO;
    field.returnKeyType = UIReturnKeyDefault;
    field.textColor = [UIColor colorWithRed:0.282 green:0.341 blue:0.455 alpha:1];
    field.layer.cornerRadius = 1;
    field.layer.masksToBounds = YES;
    field.layer.borderWidth = 1;
    field.layer.borderColor = [[UIColor grayColor] CGColor];
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.font = [UIFont boldSystemFontOfSize:18.0];
    field.placeholder = aText;
    [vw setUserInteractionEnabled:YES];
    field.tag = tg;
    return field;
}

- (UITextView*)addTextView:(CGRect)frame view:(UIView *)view{
    UITextView * textView = [[UITextView alloc] initWithFrame:frame]; //初始化大小并自动释放
    textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    textView.font = [UIFont fontWithName:@"Arial"size:16.0];//设置字体名字和字体大小
    textView.delegate = self;//设置它的委托方法
    textView.backgroundColor = [UIColor clearColor];//设置它的背景颜色
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.scrollEnabled = YES;//是否可以拖动
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    textView.userInteractionEnabled=YES;
    //给UITextView加上边框，用时记得加<QuartzCore/QuartzCore.h>
    textView.layer.cornerRadius = 1;
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
    //    self.view.layer.contents = (id)[UIImage imageNamed:@"31"].CGImage; //给图层添加背景图片
    // [view addSubview: textView];//加入到整个页面中
    return textView;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == tf_LinkWay)
    {
        [tf_LinkWay resignFirstResponder];
        [tv_FeedBackContent becomeFirstResponder];
    }
    else
    {
        [tv_FeedBackContent resignFirstResponder];
    }
    
    return YES;
}



- (void)initData{
    
}



//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)submitFeedBack:(UIButton *)sender{
    MBProgressHUD *HUD = [Utils createHUD];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
    HUD.labelText = @"提交成功";
    [HUD hide:YES afterDelay:0.5];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
