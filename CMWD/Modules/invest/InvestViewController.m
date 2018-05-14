//
//  InvestViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "InvestViewController.h"
#import "HomeProductCell.h"
#import "HomeHeaderCell.h"
@interface InvestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*WdTableView;
@property(nonatomic,strong)NSArray *headerData;
@property(nonatomic,strong)NSArray *smartData;
@property(nonatomic,strong)NSArray *personData;

@end

@implementation InvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"投资";
    [self setTableViewHeadAndFoot];
    [self.view addSubview:self.WdTableView];
}
#pragma mark tablViewHeadAndFoot
- (void)setTableViewHeadAndFoot
{
   
    
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
    return 1+self.smartData.count+1+self.personData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (indexPath.row==0){
        
        HomeHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell"];
        if (!cell) {
            cell=[HomeHeaderCell initByNibForClassName];
        }
        if (self.smartData.count>0) {
            cell.dataDict=self.headerData.firstObject;
            
        }
        return cell;
        
    }else if (indexPath.row>0&&indexPath.row<self.smartData.count+1){
        HomeProductCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeProductCell"];
        if (!cell) {
            cell=[HomeProductCell initByNibForClassName];
        }
        if (indexPath.row==self.smartData.count) {
            cell.islastCell=YES;
        }else{
            cell.islastCell=NO;
        }
        
        return cell;
    }else if (indexPath.row==self.smartData.count+1){
        
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
    if (indexPath.row==0){
        if ( self.smartData.count>0) {
            return 40;
        }else{
            return 0.01;
        }
        
    }else if (indexPath.row>0&&indexPath.row<self.smartData.count+1){
        // return 180;
        if (indexPath.row==self.smartData.count+1) {
            return 170;
        }else{
            return 180;
        }
        
    }else if (indexPath.row==self.smartData.count+1){
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
