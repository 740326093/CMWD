//
//  BsaeViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDBaseViewController.h"

@interface WDBaseViewController ()

@end

@implementation WDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    NSArray *arr = self.navigationController.viewControllers;
//    if (arr.count >1) {
//        UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
//        [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
//        [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
//        self.navigationItem.leftBarButtonItem = btnItem;
//    }
    self.view.backgroundColor=[UIColor WdMainBackgroundColor];
}

- (void)leftBarBtnClick {
   
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)EnterLoginWithController:(UIViewController*)controller{
    
    WDLoginViewController *loginVC=[[WDLoginViewController alloc]init];
    WDNavigationController *nav = [[WDNavigationController alloc] initWithNavigationBarClass:[WDNavigationBar class] toolbarClass:nil];
    [[nav navigationBar] setTranslucent:NO];
    [nav setViewControllers:@[loginVC]];
    [controller presentViewController:nav animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTabBarViewControllerType:(NSInteger)tabIndex {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    WDTabBarController *tab = (WDTabBarController *)window.rootViewController;
    tab.selectedIndex = tabIndex;
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
