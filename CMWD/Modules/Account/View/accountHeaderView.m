//
//  accountHeaderView.m
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "accountHeaderView.h"
@interface  accountHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLab;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *addAmoutLab;
@property (weak, nonatomic) IBOutlet UILabel *usableAmoutlab;
@property (weak, nonatomic) IBOutlet UILabel *todayAmoutLab;
@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;

@end
@implementation accountHeaderView
-(void)awakeFromNib{
    [super awakeFromNib];

 
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame = _topBackgroundView.bounds;
    
    //设置渐变颜色方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //UIColor *firstColor =[UIColor clmHex:0x00c6fb ];
   // UIColor *secondColor = [UIColor clmHex:0x038BFC];
    //设定颜色组
    //gradientLayer.colors = @[(__bridge id)firstColor.CGColor, (__bridge id)secondColor.CGColor];
gradientLayer.colors=  @[
      (__bridge id)[UIColor colorWithRed:78 / 255.0 green:143 / 255.0 blue:1.0 alpha:1.0].CGColor,
      (__bridge id)[UIColor colorWithRed:39 / 255.0 green:196 / 255.0 blue:254 / 255.0 alpha:1.0].CGColor,
      (__bridge id)[UIColor colorWithRed:60 / 255.0 green:143 / 255.0 blue:1.0 alpha:1.0].CGColor,
      ];
    
    //设定颜色分割点
    gradientLayer.locations = @[@(0.0f),@(0.8f) ,@(1.5f)];
    [_topBackgroundView.layer insertSublayer:gradientLayer atIndex:0];
    
}
#pragma mark 进入资金详情
- (IBAction)enterAmountDetail:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(enterAmountDetail)]) {
        [self.delegate enterAmountDetail];
    }
}
#pragma mark 充值或者提现
- (IBAction)rechargeOrWithdrawEvent:(id)sender {
    UIButton *senderbtn=(UIButton*)sender;
    
    if ([self.delegate respondsToSelector:@selector(rechargeOrWithdrawClick:)]) {
        [self.delegate rechargeOrWithdrawClick:senderbtn.tag];
    }
}


@end
