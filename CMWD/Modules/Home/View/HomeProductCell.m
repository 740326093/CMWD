//
//  HomeProductCell.m
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "HomeProductCell.h"
@interface HomeProductCell ()
@property (weak, nonatomic) IBOutlet UILabel *prTitle;
@property (weak, nonatomic) IBOutlet UILabel *prPeopel;
@property (weak, nonatomic) IBOutlet UILabel *prMaxEarnings;
@property (weak, nonatomic) IBOutlet UILabel *prMinEarnings;
@property (weak, nonatomic) IBOutlet UILabel *prEarningsUnits;
@property (weak, nonatomic) IBOutlet UILabel *prEndMonth;
@property (weak, nonatomic) IBOutlet UILabel *prbeginAmount;
@property (weak, nonatomic) IBOutlet CMCircleProgress *progressView;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewheight;

@end
@implementation HomeProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _enterBtn.layer.cornerRadius=5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)enterBtnEvent:(id)sender {
}
-(void)setIslastCell:(BOOL)islastCell{
    if (islastCell==YES) {
        _bottomViewheight.constant=0.01;
        
    }else{
        
         _bottomViewheight.constant=10;
    }
    
}
@end
