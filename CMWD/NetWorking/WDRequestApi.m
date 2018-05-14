//
//  WDRequestApi.m
//  CMWD
//
//  Created by WangWei on 2018/4/21.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDRequestApi.h"
#import "CMNoNetworkView.h"
@interface WDRequestApi ()
@property (strong, nonatomic) CMNoNetworkView *NoNetworkView;

@end
@implementation WDRequestApi
CMSingletonM(WDRequestApi)



#pragma mark 没有网络设置
-(CMNoNetworkView*)NoNetworkView{
    if (!_NoNetworkView) {
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        //CGRect rectNav = self.navigationController.navigationBar.frame;
        
        _NoNetworkView=[CMNoNetworkView  initByNibForClassName];
        _NoNetworkView.frame=CGRectMake(0, rectStatus.size.height+44, CMScreen_width(), 50);
    }
    return _NoNetworkView;
}
-(void)NoNetWorkSetting{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.NoNetworkView];
}
#pragma mark 检查网络

-(void)cheackNetWorking{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusNotReachable){
            
            [self NoNetWorkSetting];
        }else{
            [self.NoNetworkView removeFromSuperview];
            
        }
    }];
    
    
    [manager startMonitoring];
    
    
    
    
}
@end
