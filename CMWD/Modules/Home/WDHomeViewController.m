//
//  WDHomeViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDHomeViewController.h"
#import "HomeTableFootView.h"
#import "introduceTableViewCell.h"
#import "HomeProductCell.h"
#import "HomeHeaderCell.h"
@interface WDHomeViewController ()<UITableViewDelegate,UITableViewDataSource,CMCycleScrollViewDelegate>
@property(nonatomic,strong)UIButton*navRightbtn;
@property(nonatomic,strong)UITableView*WdTableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSArray *headerData;
@property(nonatomic,strong)NSArray *smartData;
@property(nonatomic,strong)NSArray *personData;
@property(nonatomic,strong)CMCycleScrollView *CycleScrollView;
@end

@implementation WDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    [self setNavigation];
    [self setTableViewHeadAndFoot];
    [self.view addSubview:self.WdTableView];
 
    
}
#pragma mark 设置导航
-(void)setNavigation{
    
    UIImage *image= [[UIImage imageNamed:@"home_top_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _navRightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navRightbtn.frame=CGRectMake(0, 0, 60, 20);
    [_navRightbtn setTitle:@"登录" forState:UIControlStateNormal];
    [_navRightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _navRightbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_navRightbtn addTarget:self action:@selector(loginEventClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem=left;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_navRightbtn];
    
}

#pragma mark tablViewHeadAndFoot
- (void)setTableViewHeadAndFoot
{
    _CycleScrollView = [CMCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CMScreen_width(), f_i5real(140))delegate:self placeholderImage:nil];
    _CycleScrollView.pageControlAliment=CMCycleScrollViewPageContolAlimentRight;
    _CycleScrollView.autoScrollTimeInterval = 8.;// 自动滚动时间间
    [self.WdTableView setTableHeaderView:_CycleScrollView];

    HomeTableFootView *footView=[HomeTableFootView initByNibForClassName];
    footView.introductBlock = ^(NSInteger index) {
        WDWebViewController *webView=[[WDWebViewController alloc]init];
        if (index==10) {
            webView.urlStr=@"";
        } else if (index==11){
            webView.urlStr=@"";
        }else{
            webView.urlStr=@"";
            
        }
        [self.navigationController  pushViewController:webView animated:YES];
        
        
    };
  //  [footback addSubview:footView];
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
    if (!_dataSource) {
        _dataSource=[NSArray array];
    }
    return _dataSource;
}
-(NSArray*)headerData{
    
    return @[@{@"title":@"智投+",@"detail":@"智慧投标,轻松投资"},@{@"title":@"自投+",@"detail":@"自选投资,尽在掌握"}];
}
-(NSArray*)smartData{

    return @[@{@"title":@"智投+",@"detail":@"智慧投标,轻松投资"},@{@"title":@"自投+",@"detail":@"自选投资,尽在掌握"}];
}

-(NSArray*)personData{

    return @[@{@"title":@"智投+",@"detail":@"智慧投标,轻松投资"},@{@"title":@"自投+",@"detail":@"自选投资,尽在掌握"},@{@"title":@"自投+",@"detail":@"自选投资,尽在掌握"}];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1+1+self.smartData.count+1+self.personData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        introduceTableViewCell *introducrCell=[tableView dequeueReusableCellWithIdentifier:@"introduceTableViewCell"];
        if (!introducrCell) {
            introducrCell=[[introduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"introduceTableViewCell"];
        }
        
        return introducrCell;
        
    }else if (indexPath.row==1){
        
        HomeHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell"];
        if (!cell) {
            cell=[HomeHeaderCell initByNibForClassName];
        }
        if (self.smartData.count>0) {
        cell.dataDict=self.headerData.firstObject;
            
        }
        return cell;
        
    }else if (indexPath.row>1&&indexPath.row<self.smartData.count+2){
    HomeProductCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeProductCell"];
    if (!cell) {
        cell=[HomeProductCell initByNibForClassName];
    }
        if (indexPath.row==self.smartData.count+1) {
            cell.islastCell=YES;
        }else{
            cell.islastCell=NO;
        }
    
    return cell;
    }else if (indexPath.row==self.smartData.count+2){
        
        HomeHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell"];
        if (!cell) {
            cell=[HomeHeaderCell initByNibForClassName];
            
            
        }
        if (self.personData.count>0)
    { cell.dataDict=self.headerData.lastObject;
        }
        return cell;
    }else{
        HomeProductCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeProductCell"];
        if (!cell) {
            cell=[HomeProductCell initByNibForClassName];
            
            
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 80;
    }else if (indexPath.row==1){
        if ( self.smartData.count>0) {
            return 40;
        }else{
           return 0.01;
        }
     
    }else if (indexPath.row>1&&indexPath.row<self.smartData.count+2){
       // return 180;
        if (indexPath.row==self.smartData.count+1) {
        return 170;
        }else{
        return 180;
        }
        
    }else if (indexPath.row==self.smartData.count+2){
        if ( self.personData.count>0) {
            return 40;
        }else{
            return 0.01;
        }
        
    }else{
        return 180;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
}

#pragma mark CMSCycleScrollViewDelegate
-(void)cycleScrollView:(CMCycleScrollView *)cycleScrollView didScrollToUrl:(NSString *)url{
    
    
    
}

-(void)loginEventClick{
    [self EnterLoginWithController:self];

//WDWebViewController *loginVC=[[WDWebViewController alloc]init];
  //  loginVC.urlStr=@"https://m.58cm.com";
   //[self.navigationController pushViewController:loginVC animated:YES];
   // CMShareTextView   *shareView=[[CMShareTextView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    
  //  [shareView showSendTextView];
  
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
