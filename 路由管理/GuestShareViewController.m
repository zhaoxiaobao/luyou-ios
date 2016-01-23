
//
//  guestShareViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "GuestShareViewController.h"
#import "KxMenu.h"

@interface GuestShareViewController (){
    UIImageView *image;
}

@end

@implementation GuestShareViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
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
    navTitle.text=@"分享二维码";
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
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    rightBtn.frame = CGRectMake(screen_width-40, 30, 23, 23);
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    rightBtn.titleLabel.textColor = [UIColor whiteColor];
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnTap:) forControlEvents:UIControlEventTouchUpInside];
//    rightBtn.adjustsImageWhenHighlighted = NO;
//    [backView addSubview:rightBtn];
    
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(screen_width-40, 30, 25, 25);
    [Btn setImage:[ UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(rightBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    Btn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:Btn];
    
//    UIControl *m_control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, screen_width, 210)];
//    [m_control addTarget:self action:@selector(rightBtnTap:)
//        forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:m_control];


}


-(void)rightBtnTap:(UIButton *)sender{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"发给QQ好友"
                     image:[UIImage imageNamed:@"qq"]
                    target:self
                    action:@selector(pushMenuItemShare)],
      
      [KxMenuItem menuItem:@"发送给微信好友"
                     image:[UIImage imageNamed:@"微信"]
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


- (void)initView{
    
    image = [[UIImageView alloc] initWithFrame:CGRectMake(23, 140, screen_width - 46, screen_width-46)];
    //    [image setImage:[UIImage imageNamed:@"icon_mine_default_portrait"]];
    image.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:image];
    
    
    
    
}


- (void)initData{
    
   image.image = [[self class] maker:@"admin" size:250];
    
}



//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}



+(UIImage*)maker:(NSString*)string size:(CGFloat)width{
    CIImage *cimage = [self createQRForString:string];
    if(cimage){
        return [self createNonInterpolatedUIImageFormCIImage:cimage withSize:width];
    }else{
        return nil;
    }
    
}

+ (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [[qrString description] dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *QRFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [QRFilter setValue:stringData forKey:@"inputMessage"];
    [QRFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return QRFilter.outputImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(cs);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *reusult = [UIImage imageWithCGImage:scaledImage];
    CGContextRelease(bitmapRef);
    CGImageRelease(scaledImage);
    CGImageRelease(bitmapImage);
    return reusult;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
