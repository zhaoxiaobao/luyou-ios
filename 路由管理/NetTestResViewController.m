//
//  NetTestResViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/11.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "NetTestResViewController.h"



@interface NetTestResViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
    UIButton *wifiLabel;
    int numOfstar;
    int numOfstar2;
    NSString *wifiName;
    NSString *dayName;
    NSString *scoreName;
    UILabel *label2;
    UILabel *label;
}


@end

@implementation NetTestResViewController

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
    navTitle.text=@"体检结果";
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
    [dic1 setObject:@"wifi密码强度" forKey:@"title"];
    [_dataSourceArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"管理员密码强度" forKey:@"title"];
    [_dataSourceArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"无线网络名" forKey:@"title"];
    [_dataSourceArray addObject:dic3];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"防火墙" forKey:@"title"];
    [_dataSourceArray addObject:dic4];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:@"外网登录限制" forKey:@"title"];
    [_dataSourceArray addObject:dic5];
    
}




#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 75)];
    view.backgroundColor = RGB(239, 239, 244);
    
    UILabel *labelSmall=[[UILabel alloc] init];
    labelSmall.text=@"上次体检得分";
    labelSmall.textColor=fontGray;
    [labelSmall setFont:[UIFont systemFontOfSize:14]];
    CGSize sizeLab =  [self sizeWithString:labelSmall.text font:labelSmall.font];
    labelSmall.frame=CGRectMake(15,20,sizeLab.width,sizeLab.height);
    [view addSubview:labelSmall];
    
    
    self.scoreLab=[[UILabel alloc] init];
    self.scoreLab.textColor=navigationBarColor;
    self.scoreLab.textAlignment=0;
    self.scoreLab.text=scoreName;
    [self.scoreLab setFont:[UIFont systemFontOfSize:24]];
    CGSize scoreLabS =  [self sizeWithString:self.scoreLab.text font:self.scoreLab.font];
    _scoreLab.frame=CGRectMake(15+sizeLab.width+5,22-scoreLabS.height+sizeLab.height,scoreLabS.width,scoreLabS.height);
    [view addSubview:self.scoreLab];
    
    UILabel *label1=[[UILabel alloc] init];
    label1.text=@"分";
    label1.textColor=fontGray;
    label1.textAlignment=0;
    [label1 setFont:[UIFont systemFontOfSize:14]];
    label1.frame=CGRectMake(15+sizeLab.width+10+scoreLabS.width,20,20,20);
    [view  addSubview:label1];
    
    UILabel *labelSmall22=[[UILabel alloc] init];
    labelSmall22.text=@"您已经";
    labelSmall22.textColor=fontGray;
    [labelSmall22 setFont:[UIFont systemFontOfSize:14]];
    CGSize sizeLab22 =  [self sizeWithString:labelSmall22.text font:labelSmall22.font];
    labelSmall22.frame=CGRectMake(15,60,sizeLab22.width,sizeLab22.height);
    [view addSubview:labelSmall22];
    
    
    self.dayLab=[[UILabel alloc] init];
    _dayLab.text=dayName;
    self.dayLab.textColor=navigationBarColor;
    [self.dayLab setFont:[UIFont systemFontOfSize:24]];
    CGSize size =  [self sizeWithString:_dayLab.text font:_dayLab.font];
    _dayLab.frame=CGRectMake(sizeLab22.width+20,50,size.width,size.height);
    [view addSubview:self.dayLab];
    

    
    
    UILabel *labelSmall2=[[UILabel alloc] initWithFrame:CGRectMake(sizeLab22.width+35,60,100,sizeLab22.height)];
    labelSmall2.text=@"天未体检了";
    labelSmall2.textColor=fontGray;
    [labelSmall2 setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:labelSmall2];
    return view;
    
}


- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
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
    cell.textLabel.text = [_dataSourceArray[indexPath.row] objectForKey:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if(indexPath.row==2){
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-200, 0, 180, 50)];
        lab.textAlignment=2;
        lab.textColor=fontGray;
        lab.font = [UIFont systemFontOfSize:18];
        lab.text = wifiName;
        [cell addSubview:lab];

        
    }else if (indexPath.row==4){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60, 0,60, 50)];
        [btn setTitle:@"禁止" forState:UIControlStateNormal];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [btn setTitleColor:fontBlue forState:UIControlStateNormal];
        [cell addSubview:btn];
        
    }else if (indexPath.row==0||indexPath.row==3){
        
        switch (numOfstar) {
            case 2:
                for (int i=0; i<3; i++) {
                    if (i>0) {
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_on"]];
                        [cell addSubview:img];
                    }else{
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_off"]];
                        [cell addSubview:img];
                    }
                    
                }
                
                
                break;
            case 1:
                for (int i=0; i<3; i++) {
                    if (i==2) {
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_on"]];
                        [cell addSubview:img];
                    }else{
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i,15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_off"]];
                        [cell addSubview:img];
                    }
                    
                }
                
                
                break;
            case 3:
                for (int i=0; i<3; i++) {
                    UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                    [img setImage:[ UIImage imageNamed:@"star_on"]];
                    [cell addSubview:img];
                    
                }
                
                
                break;
                
            default:
                break;
                
        }
        
        
        
        
    }else if (indexPath.row==1){
        switch (numOfstar2) {
            case 1:
                
                for (int i=0; i<3; i++) {
                    if (i==2) {
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_on"]];
                        [cell addSubview:img];
                    }else{
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_off"]];
                        [cell addSubview:img];
                    }
                    
                }
                
                
                
                break;
            case 2:
                for (int i=0; i<3; i++) {
                    if (i>0) {
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_on"]];
                        [cell addSubview:img];
                    }else{
                        UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                        [img setImage:[ UIImage imageNamed:@"star_off"]];
                        [cell addSubview:img];
                    }
                    
                }
                
                
                
                break;
            case 3:
                for (int i=0; i<3; i++) {
                    UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-25-20*i, 15,15, 15)];
                    [img setImage:[ UIImage imageNamed:@"star_on"]];
                    [cell addSubview:img];
                    
                }
                
                
                break;
                
            default:
                break;
                
        }
        
        
        
        
    }
    
    return cell;
}


-(void)setData:(testResultModel *)data{
    numOfstar=[data.wifiMark intValue];
    numOfstar2=[data.pwdMark intValue];
    wifiName=data.wifiName;
    dayName=data.timeMark;
    scoreName=data.score;
}


-(void)addStarView:(int) num{
    
    
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
