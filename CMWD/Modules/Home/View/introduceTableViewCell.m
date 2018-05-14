//
//  introduceTableViewCell.m
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "introduceTableViewCell.h"
#import "WDMainProductCell.h"
@interface introduceTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionViewFlowLayout  *PrFlowLayout;
@property(nonatomic,strong)UICollectionView *PrCollectionView;
@property(nonatomic,assign)float height;
@property(strong,nonatomic)NSArray *prTitleArr;
@property(nonatomic,strong)NSArray *PrAdArr;
@property(nonatomic,strong)NSArray *PrPicArr;

@end
@implementation introduceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _height=80;
        
        
        [self addSubview:self.PrCollectionView];
        
        [self.PrCollectionView registerClass:[WDMainProductCell class] forCellWithReuseIdentifier:@"WDMainProductCell"];
     
    }
    
    
    return self;
}

-(UICollectionViewFlowLayout*)PrFlowLayout{
    if (!_PrFlowLayout) {
        _PrFlowLayout=[[UICollectionViewFlowLayout alloc]init];
        _PrFlowLayout.itemSize = CGSizeMake(CMScreen_width()/2.0,_height);
        _PrFlowLayout.headerReferenceSize = CGSizeMake(0.0, 0.0);
        _PrFlowLayout.footerReferenceSize=CGSizeMake(0.0,0.0);
        _PrFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _PrFlowLayout.minimumLineSpacing = 0;
        _PrFlowLayout.minimumInteritemSpacing = 0;
        
    }
    return _PrFlowLayout;
}

-(UICollectionView*)PrCollectionView{
    
    if (!_PrCollectionView) {
        _PrCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), _height) collectionViewLayout:self.PrFlowLayout];
//        _PrCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
        _PrCollectionView.dataSource = self;
        _PrCollectionView.delegate = self;
        _PrCollectionView.showsVerticalScrollIndicator=NO;
        _PrCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _PrCollectionView;
}


//多少个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个区单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.prTitleArr.count;
}
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.prTitleArr.count;
}
//创建CEll
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    WDMainProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WDMainProductCell" forIndexPath:indexPath];
    
   long itemIndex=[self pageControlIndexWithCurrentCellIndex:indexPath.item];
    cell.topTitle.text=self.prTitleArr[itemIndex];
    cell.detailTitle.text=self.PrAdArr[itemIndex];
 
    cell.headIcon.image=[UIImage imageNamed:self.PrPicArr[itemIndex]];

   
    if (itemIndex==1 ) {
        [cell.verticalView removeFromSuperview];
    }
    
    
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    long itemIndex=[self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    DLog(@"+++%ld",itemIndex);
}

#pragma mark Source

-(NSArray*)prTitleArr{
    
    return @[@"关于我们",@"信息披露"];
}
-(NSArray*)PrAdArr{
    return @[@"诚信为本,价值为先",@"真实透明,运营规范"];
}
-(NSArray*)PrPicArr{
    
    return @[@"sy_xkzx_icon",@"sy_yqhy_icon"];
}
@end
