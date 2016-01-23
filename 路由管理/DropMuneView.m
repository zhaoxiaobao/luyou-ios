
//
//  DropMuneView.m
//  WSDropMenuView
//
//  Created by zhaoyuan on 15/10/10.
//  Copyright © 2015年 Senro Wong. All rights reserved.
//

#import "DropMuneView.h"

#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width [[UIScreen mainScreen] bounds].size.width

#define KTopButtonHeight 40

/**
 *  后续添加的代码
 */

@interface DropMuneView()<UITableViewDataSource,UITableViewDelegate>///声明

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UIButton *mainButton;
@property (nonatomic,strong) UIButton *bgButton;
@property (nonatomic,strong) NSString *question;


@end

static NSString *cellIdent = @"cellIdent";


@implementation DropMuneView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

//Initializes and returns a newly allocated view object with the specified frame rectangle.

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _question=@"点击选择的问题";
        [self _setButton];
        [self _initialize];
        [self _setSubViews];
    }
    return self;
}

- (void)_setButton{
    self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mainButton.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.3];
    self.mainButton.frame = CGRectMake(0, 0, Main_Screen_Width, 40);
    [self.mainButton setTitle:@"点击选择的问题" forState:UIControlStateNormal];
    [self.mainButton setTitleColor:[UIColor colorWithWhite:0.004 alpha:1.000] forState:UIControlStateNormal];
//    self.mainButton.titleLabel.textAlignment=0;
    self.mainButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.mainButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mainButton];
    
}

- (void)_initialize{
}


- (void)_setSubViews{
    [self addSubview:self.bgButton];
    [self.bgButton addSubview:self.leftTableView];
    
    
}
#pragma mark -- getter --
- (UITableView *)leftTableView{
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
//        Registers a class for use in creating new table cells.
//            The class of a cell that you want to use in the table.
//        区别在于之前的写法取出重用cell的时候可能是空的
//        而后来的写法如果取出空的那就自动创建一个新的 register就是告诉它创建个什么样的
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView.frame = CGRectMake(0, 0, self.bgButton.frame.size.width, 0);
        _leftTableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _leftTableView;
}
/**
 *  绘制背景按钮
 *
 *  @return <#return value description#>
 */
- (UIButton *)bgButton{
    
    if (!_bgButton) {
        
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 40);
        [_bgButton addTarget:self action:@selector(bgAction:) forControlEvents:UIControlEventTouchUpInside];
        //        A Boolean value that determines whether subviews are confined to the bounds of the view.
        //        view添加view，并剪边(UIView属性clipsTobounds的应用)
        //
        //        如题，有两个view： view1,view2
        //        view1添加view2到其中，如果view2大于view1，或者view2的坐标不在view1的范围内，view2是盖着view1的，意思就是超出的部份也会画出来
        _bgButton.clipsToBounds = YES;
        
    }
    
    return _bgButton;
}

#pragma mark -- tableViews Change -
- (void)_hiddenLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, 0);
}

- (void)_showLeftTableViews{
    
//    CGFloat height = MIN(200, 600);
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, 140);
}

- (void)buttonAction:(UIButton *)sender{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, Main_Screen_Height);
    self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, self.bounds.size.height - KTopButtonHeight);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        

            [self _showLeftTableViews];
        
    } completion:^(BOOL finished) {
        
    }];

}

- (void)_changeTopButton:(NSString *)sender{
    [self.mainButton setTitle:sender forState:UIControlStateNormal];
    [self bgAction:nil];

    
}

- (void)bgAction:(UIButton *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        
        
        [self _hiddenLeftTableViews];
        
    } completion:^(BOOL finished) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, KTopButtonHeight);
        self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, 0);
        
    }];
    

    
}

#pragma mark -- DataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.004 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    //    [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    cell.textLabel.text = @[@"你父亲的姓名是?",@"你的生日是?",@"你的爱最的东西是?"][indexPath.row];
    
    return cell;
    
}

#pragma mark - tableView delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _question=cell.textLabel.text;

    
    [self _changeTopButton:cell.textLabel.text ];
    

    
}


- (NSString *)getAnswer{
    
    return _mainButton.titleLabel.text ;
    
    
}



@end


