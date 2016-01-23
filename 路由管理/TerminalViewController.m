//
//  terminalViewController.m
//  路由管理
//
//  Created by zhaoyuan on 15/9/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "TerminalViewController.h"
#import "Config.h"
#import "Utils.h"
#import "TFHpple.h"
#import "terminal.h"




@interface TerminalViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>{
    NSString *msg;
}
@property (nonatomic, retain) NSMutableArray *allDataArray;
@property (nonatomic, retain) NSMutableArray *searchResultDataArray;
@property (nonatomic, retain) UISearchController *searchController;
@property (nonatomic, retain) UITableViewController *searchTVC;

@end

@implementation TerminalViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=navigationBarColor;
    [self initNav];
    [self initView];
    [self initData];
}

-(void)initNav{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 20)];
    header.backgroundColor=navigationBarColor;
    [self.view addSubview:header];
}

-(void)searchBtnTap:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    self.searchTVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [_searchTVC.tableView setFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _searchTVC.tableView.dataSource = self;
    _searchTVC.tableView.delegate = self;
    _searchTVC.view.backgroundColor=[UIColor whiteColor];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_searchTVC];
    
    // 搜索框检测代理
    //（这个需要遵守的协议是 <UISearchResultsUpdating> ，这个协议中只有一个方法，当搜索框中的值发生变化的时候，代理方法就会被调用）
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.placeholder = @"iPhone";
    _searchController.searchBar.prompt = @"输入要搜索设备的名称";
    
    // 因为搜索是控制器，所以要使用模态推出（必须是模态，不可是push）
    [self presentViewController:_searchController animated:YES completion:nil];
}


#pragma mark - UISearchResultsUpdating Method
#pragma mark 监听者搜索框中的值的变化
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    // 1. 获取输入的值
    NSString *conditionStr = searchController.searchBar.text;
    
    // 2. 创建谓词，准备进行判断的工具
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.phoneName CONTAINS [CD] %@ ", conditionStr, conditionStr, conditionStr];
    
    // 3. 使用工具获取匹配出的结果
    self.searchResultDataArray = [NSMutableArray arrayWithArray:[_allDataArray filteredArrayUsingPredicate:predicate]];
    
    // 4. 刷新页面，将结果显示出来
    [_searchTVC.tableView reloadData];
}






-(void)initView{
    
    
}


-(void)connection{
    self.allDataArray = [[NSMutableArray alloc] init];

    
    NSString *strUrl=[NSString stringWithFormat:@"http://192.168.1.1/wl_hostset.asp?t=1446601784677"];
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
                               NSArray *elements = [xpathparser  searchWithXPathQuery:@"//*[@id='underline']/text()"];
                               
                               
                               if ([elements count] > 0)
                               {
                                   for(int  i=0;i<[elements count];i++){
                                       TFHppleElement *element = [elements objectAtIndex:i];
                                       msg = [element content];
                                       
                                       dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                           
                                           // 添加测试数据
                                           terminal *ter = [[terminal alloc] initWithName:@"Mac地址" ipNumber:msg phoneName:[NSString stringWithFormat:@"序号%d",i] ];
                                           
                                           [_allDataArray addObject:ter];
                                           __weak TerminalViewController *weakSelf = self;
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               // 刷新数据
                                               [weakSelf.tableView reloadData];
                                           });
                                       });
                                       
                                       [_tableView reloadData];
                                   }

                                   
                                   
                               }
                               
                               
                               NSLog(@"%@",msg);
                               
                           }];
    
    [_tableView reloadData];

    
}




-(void)initData{
    
    /**
     
     实现终端设备查找
     入参：无
     出参：ip，设备名称，设备昵称
     请求方式：post/get
     
     
     
     */
    
    [self connection];
    
    
    
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return (tableView == self.tableView ? _allDataArray.count : _searchResultDataArray.count);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 175;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 95)];
    UIImageView  *imgIndex=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 95)];
    [imgIndex setImage:[ UIImage imageNamed:@"top_bg"]];
    [header addSubview:imgIndex];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [header addSubview:backView];
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30-rectStatus.size.height, 200, 25);
    navTitle.text=@"查看终端设备";
    navTitle.textAlignment=1;
    navTitle.textColor=[UIColor whiteColor];
    navTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    [backView addSubview:navTitle];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20-rectStatus.size.height, 54, 44);
    UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,13,23)];
    [img setImage:[ UIImage imageNamed:@"icon_back"]];
    [backBtn addSubview:img];
    [backBtn addTarget:self action:@selector(backBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:backBtn];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(screen_width-30, 20-rectStatus.size.height, 54, 44);
    UIImageView  *img2=[[UIImageView alloc] initWithFrame:CGRectMake(5,10,23,23)];
    [img2 setImage:[ UIImage imageNamed:@"search"]];
    [Btn addSubview:img2];
    [Btn addTarget:self action:@selector(searchBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    Btn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:Btn];
    
    
    NSArray *usersInformation = [Config getUsersInformation];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64-rectStatus.size.height, screen_width, 80)];
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 55, 55)];
    userImage.layer.masksToBounds = YES;
    userImage.layer.cornerRadius = 27;
    [userImage setImage:[UIImage imageNamed:usersInformation[1]]];
    headerView.backgroundColor = navigationBarColor;
    [headerView addSubview:userImage];
    //用户名
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+55+5, 15, 100, 30)];
    userNameLabel.font = [UIFont systemFontOfSize:13];
    [userNameLabel setTextColor:[UIColor  whiteColor]];
    userNameLabel.text = usersInformation[0];
    [headerView addSubview:userNameLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+55+5, 40, 100, 20)];
    [btn setTitle:[Utils deviceIPAdress] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment=1;
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    
    [btn setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [headerView addSubview:btn];
    [backView addSubview:headerView];
    
    UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 128, 200, 30)];
    allLabel.font = [UIFont systemFontOfSize:11];
    NSInteger  num=tableView == self.tableView ? _allDataArray.count : _searchResultDataArray.count;
    allLabel.text = [@"使用设备 " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)num]];
    [backView addSubview:allLabel];
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //声明重用标示符
    static NSString *cellIndentifier = @"mineCell";
    //到复用队列中查找
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        //没有找到则创建cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    terminal *ter = (tableView == self.tableView ? _allDataArray[indexPath.row] : _searchResultDataArray[indexPath.row]);
    
    NSString *imgStr = @"devicelist_ic_phone";
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 100, 20)];
    lab3.font = [UIFont systemFontOfSize:19];
    lab3.text = ter.name;
    lab3.textColor=fontGray;
    [cell addSubview:lab3];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 150, 20)];
    lab2.font = [UIFont systemFontOfSize:13];
    lab2.text = ter.ipNumber;
    lab2.textColor=fontGray;
    [cell addSubview:lab2];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-200, 15, 180, 30)];
    lab.textAlignment=2;
    lab.textColor=fontGray;
    lab.font = [UIFont systemFontOfSize:20];
    lab.text = ter.phoneName;
    [cell addSubview:lab];
    
    cell.imageView.image = [UIImage imageNamed:imgStr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
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
