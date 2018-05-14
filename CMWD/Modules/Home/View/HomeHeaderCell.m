//
//  HomeHeaderCell.m
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "HomeHeaderCell.h"
@interface HomeHeaderCell ()
@property (weak, nonatomic)IBOutlet UIView *linView;
@property (weak, nonatomic)IBOutlet UILabel *TitleLab;
@property (weak, nonatomic)IBOutlet UILabel *detailLab;

@end
@implementation HomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataDict:(NSDictionary *)dataDict{
    self.TitleLab.text=dataDict[@"title"];
    self.detailLab.text=dataDict[@"detail"];
    
}
@end
