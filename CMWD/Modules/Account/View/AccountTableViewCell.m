//
//  AccountTableViewCell.m
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "AccountTableViewCell.h"
@interface AccountTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end
@implementation AccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataDict:(NSDictionary *)dataDict{
    
    //_headImageView.image=dataDict[@"titleImage"];
  _titlelab.text=dataDict[@"title"];
}
@end
