//
//  HomeTableFootView.m
//  CMWD
//
//  Created by WangWei on 2018/4/18.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "HomeTableFootView.h"

@implementation HomeTableFootView



- (IBAction)introductWDDetailEvent:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    self.introductBlock(btn.tag);
    
    
}



@end
