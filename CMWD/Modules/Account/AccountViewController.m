//
//  AccountViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableViewCell.h"
#import "accountHeaderView.h"
@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource,accountHeaderViewDelegate>
@property(nonatomic,strong)UIButton*navRightbtn;
@property(nonatomic,strong)UITableView*WdTableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)accountHeaderView *HeaderView;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的";
    
     [self setNavigation];
    [self setTableViewHeadAndFoot];
    [self.view addSubview:self.WdTableView];
}

#pragma mark 设置导航
-(void)setNavigation{
    
      UIButton* navRightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    navRightbtn.frame=CGRectMake(0, 0, 80, 40);
        [navRightbtn setTitle:@"安全退出" forState:UIControlStateNormal];
       [navRightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       navRightbtn.titleLabel.font=[UIFont systemFontOfSize:15];
       [navRightbtn addTarget:self action:@selector(exitEventClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:navRightbtn];
    
}
#pragma mark tablViewHeadAndFoot
- (void)setTableViewHeadAndFoot
{
//    _CycleScrollView = [CMCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CMScreen_width(), f_i5real(140))delegate:self placeholderImage:nil];
//    _CycleScrollView.pageControlAliment=CMCycleScrollViewPageContolAlimentRight;
//    _CycleScrollView.autoScrollTimeInterval = 8.;// 自动滚动时间间
   self.HeaderView.delegate=self;
   [self.WdTableView setTableHeaderView:self.HeaderView];
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), f_i5real(150))];
    [self.WdTableView setTableFooterView:footView];
    
    
    
}
#pragma mark Lazy
-(UITableView*)WdTableView{
    if (!_WdTableView) {
        _WdTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _WdTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _WdTableView.backgroundColor=[UIColor WdMainBackgroundColor];
        _WdTableView.dataSource=self;
        _WdTableView.delegate=self;
        _WdTableView.showsVerticalScrollIndicator=NO;
        _WdTableView.estimatedSectionFooterHeight=0;
        _WdTableView.estimatedSectionHeaderHeight=0;
    }
    return _WdTableView;
}

-(NSArray*)dataSource{
    
    return @[@{@"titleImage":@"",@"title":@"我的投资"},@{@"titleImage":@"",@"title":@"我的资料"},@{@"titleImage":@"",@"title":@"安全认证"},@{@"titleImage":@"",@"title":@"风险测评"},@{@"titleImage":@"",@"title":@"更多"}];
}

-(accountHeaderView*)HeaderView{
    if (!_HeaderView) {
        _HeaderView=[accountHeaderView initByNibForClassName];
    }
    return _HeaderView;
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.dataSource.count-1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        AccountTableViewCell *introducrCell=[tableView dequeueReusableCellWithIdentifier:@"AccountTableViewCell"];
        if (!introducrCell) {
            introducrCell=[AccountTableViewCell initByNibForClassName];
        }
    if (indexPath.section==0) {
       introducrCell.dataDict=self.dataSource.firstObject;
        
    }else{
        
      introducrCell.dataDict=self.dataSource[indexPath.row+1];
    }
    
    return introducrCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor WdMainBackgroundColor];
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor WdMainBackgroundColor];
}
#pragma mark accountHeaderViewDelegate
-(void)enterAmountDetail{
}
-(void)rechargeOrWithdrawClick:(NSInteger)index{
    DLog(@"+++%ld",index);
    
    
}
#pragma mark 退出
-(void)exitEventClick{
    
    
    
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
