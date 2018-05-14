//
//  accountHeaderView.h
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface accountHeaderView : UIView
@property(nonatomic,weak)id delegate;
@end
@protocol accountHeaderViewDelegate <NSObject>
-(void)enterAmountDetail;
-(void)rechargeOrWithdrawClick:(NSInteger)index;
@end
