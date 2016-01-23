//
//  SJBBaseTreeListViewController.m
//  SJBTreeListTableView
//
//  Created by Buddy on 29/4/14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SJBBaseTreeListViewController.h"
#define kSectionHeaderHeight 50.0f
@interface SJBBaseTreeListViewController ()

@end

@implementation SJBBaseTreeListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.treeOpenArray = [NSMutableArray array];
        self.sectionListName = [NSString stringWithFormat:@"name"];
        self.rowListTitle = [NSString stringWithFormat:@"country"];
        self.rowListName = [NSString stringWithFormat:@"cityName"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ///下面是所需要的数据结构。
    NSMutableDictionary *cityDict1 = [NSMutableDictionary dictionary];
    [cityDict1 setObject:@"DIR_600A" forKey:self.rowListName];
    NSMutableDictionary *cityDict2 = [NSMutableDictionary dictionary];
    [cityDict2 setObject:@"DIR_500A" forKey:self.rowListName];
    NSMutableDictionary *cityDict3 = [NSMutableDictionary dictionary];
    [cityDict3 setObject:@"DIR_400A" forKey:self.rowListName];
    
    NSMutableArray *country1 = [NSMutableArray arrayWithObjects:cityDict1,cityDict2,cityDict3, nil];
    NSMutableDictionary *countryDict1 = [NSMutableDictionary dictionaryWithObject:country1 forKey:self.rowListTitle];
    [countryDict1 setObject:@"DLINK" forKey:self.sectionListName];
    
    
    NSMutableDictionary *cityDict21 = [NSMutableDictionary dictionary];
    [cityDict21 setObject:@"DIR_600A" forKey:self.rowListName];
    NSMutableDictionary *cityDict22 = [NSMutableDictionary dictionary];
    [cityDict22 setObject:@"DIR_600A" forKey:self.rowListName];
    NSMutableDictionary *cityDict23 = [NSMutableDictionary dictionary];
    [cityDict23 setObject:@"DIR_600A" forKey:self.rowListName];
    NSMutableDictionary *cityDict24 = [NSMutableDictionary dictionary];
    [cityDict24 setObject:@"DIR_600A" forKey:self.rowListName];
    NSMutableArray *country2 = [NSMutableArray arrayWithObjects:cityDict21,cityDict22,cityDict23,cityDict24, nil];
    NSMutableDictionary *countryDict2 = [NSMutableDictionary dictionaryWithObject:country2 forKey:self.rowListTitle];
    [countryDict2 setObject:@"FIR_150M" forKey:self.sectionListName];
    
    
    
    
    self.treeResultArray = [NSMutableArray arrayWithObjects:countryDict1,countryDict2, nil];
    
    ///原来下面几句都在viewDidLoad 里面，所以很卡。。。
    if (self.treeTableView==nil||self.treeTableView==NULL) {
        self.treeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
        self.treeTableView.delegate = self;
        self.treeTableView.dataSource = self;
//        self.treeTableView.backgroundColor = bgroundColor;
        self.treeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.treeTableView];
        if ([self.treeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.treeTableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
}

#pragma mark - =================自己写的tableView================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.treeResultArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int tempNum = (int)[[self.treeResultArray[section]objectForKey:self.rowListTitle] count];
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
    if ([self.treeOpenArray containsObject:tempSectionString]) {
        return tempNum;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tempV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    tempV.backgroundColor = [UIColor colorWithRed:(236)/255.0f green:(236)/255.0f blue:(236)/255.0f alpha:1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(16+30, 10, 200, 30)];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont fontWithName:@"Arial" size:20];
    label1.text = [self.treeResultArray[section] objectForKey:self.sectionListName];
    
    UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 20, 11)];
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
    if ([self.treeOpenArray containsObject:tempSectionString]) {
        tempImageV.image = [UIImage imageNamed:@"close"];
        
    }else{
        tempImageV.image = [UIImage imageNamed:@"open"];
    }
    ///给section加一条线。
    CALayer *_separatorL = [CALayer layer];
    _separatorL.frame = CGRectMake(0.0f, 49.0f, [UIScreen mainScreen].bounds.size.width, 1.0f);
    _separatorL.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    [tempV addSubview:label1];
    [tempV addSubview:tempImageV];
    [tempV.layer addSublayer:_separatorL];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(0, 0, 320, 50);
    [tempBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = section;
    [tempV addSubview:tempBtn];
    return tempV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSectionHeaderHeight;
}

-(void)tapAction:(UIButton *)sender{
    self.treeOpenString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([self.treeOpenArray containsObject:self.treeOpenString]) {
        [self.treeOpenArray removeObject:self.treeOpenString];
    }else{
        [self.treeOpenArray addObject:self.treeOpenString];
    }
    ///下面一句是用的时候刷新的。
    //    [self.treeTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
}

///这个都没有执行。。。
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ///下面这是类似section里面的就是国家。。。。
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [[[self.treeResultArray[indexPath.section]objectForKey:self.rowListTitle] objectAtIndex:indexPath.row] objectForKey:self.rowListName];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@"r1"];

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
