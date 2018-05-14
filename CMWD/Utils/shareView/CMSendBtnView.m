//
//  BaseSendBtnView.m

//
//  Created by wangwei on 2017/88/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "CMSendBtnView.h"

@implementation CMSendBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = NO;
        

        [self addSubview:self.btnImageView];
       
        [self addSubview:self.btnTitleLabel];
        
        
        [self addSubview:self.sendViewButton];
        
        [self.btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
  
            make.height.equalTo(self.btnImageView.mas_width);
        }];
        
        [self.btnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnImageView.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [self.sendViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

-(UIImageView*)btnImageView{
    if (!_btnImageView) {
        _btnImageView=[[UIImageView alloc]init];
    }
    return _btnImageView;
    
}
-(UILabel*)btnTitleLabel{
    if (!_btnTitleLabel) {
        _btnTitleLabel = [[UILabel alloc]init];
        _btnTitleLabel.textColor = [UIColor clmHex:0x777777];
        _btnTitleLabel.textAlignment = NSTextAlignmentCenter;
        _btnTitleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _btnTitleLabel;
}
-(UIButton*)sendViewButton{
    if (!_sendViewButton) {
        _sendViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _sendViewButton;
}
@end
