//
//  WDTabBarController.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDTabBarController.h"
#import "WDCustomTabBar.h"
@interface WDTabBarController ()<UITabBarControllerDelegate>

@end

@implementation WDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self addAllChildViewControllers];
      self.delegate=self;
    
    WDCustomTabBar *myTabBar = [[WDCustomTabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    /*
    if (viewController == [tabBarController.viewControllers objectAtIndex:3]) //assuming the index of uinavigationcontroller is 2
    {
        //if (CMIsLogin()) {
         // return YES;
       // } else {
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentTabBarIndex) name:@"loginWin" object:nil];
   
            return  YES;
        //}
    } else if (viewController == [tabBarController.viewControllers objectAtIndex:0]) {
       
        return YES;
    }
    
    else {
        return YES;
    }
  */
    return YES;
}
- (void)addAllChildViewControllers
{
    
    
    // 1,首页
    WDHomeViewController *home = [[WDHomeViewController alloc] init];
    [self addChildViewController:home title:@"首页" image:@"tabBar_home" selectedImage:@""];
    
    // 2,投资
    InvestViewController *licai = [[InvestViewController alloc] init];
    [self addChildViewController:licai title:@"投资" image:@"tabBar_activity" selectedImage:@"home_submenu_licai_red"];

    
    // 3,账户
    
    AccountViewController *account = [[AccountViewController alloc] init];
    [self addChildViewController:account title:@"我的" image:@"tabBar_mine" selectedImage:@"home_submenu_zhanghu_red"];
    
}

#pragma mark - 添加一个子控制器
- (void)addChildViewController:(UIViewController *)child title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置标题和图片
    child.tabBarItem.title = title;
    child.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selected = [UIImage imageNamed:selectedImage];
    
    // 不渲染选中的图片
    child.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   // [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} forState:UIControlStateNormal];//TabBarItem未选中时的字体大小
  
 [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor WdMainColor]} forState:UIControlStateSelected];
    // 包装一个导航控制器
    //child.title = title;
    //CMNavigationController *nav = [[CMNavigationController alloc] initWithRootViewController:child];
    WDNavigationController *nav = [[WDNavigationController alloc] initWithNavigationBarClass:[WDNavigationBar class] toolbarClass:nil];
    [[nav navigationBar] setTranslucent:NO];
    [nav setViewControllers:@[child]];
    // 成为tabbarController的子控制器
    [self addChildViewController:nav];
    
    
    
}

- (void) presentTabBarIndex {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    WDTabBarController *tab = (WDTabBarController *)window.rootViewController;
    tab.selectedIndex = 3;
}
@end
