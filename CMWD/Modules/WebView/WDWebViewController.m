//
//  WDWebViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/14.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDWebViewController.h"
#import <WebKit/WebKit.h>

@interface WDWebViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *customWebView;
@property(nonatomic,strong)UIWebView *WDWebView;
@end

@implementation WDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.customWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.jiuzhouauto.com/api/newsOne?id=5ad1f4c1f7015f72ca1e8700&username=13828508939&unionid=(null)"]]];
//    [self.view addSubview:self.customWebView];
    [self showDefaultProgressHUD];
    [self.view addSubview:self.WDWebView];
}
#pragma mark Lazy
-(WKWebView*)customWebView{
    if (!_customWebView) {
    WKWebViewConfiguration *config=[[WKWebViewConfiguration  alloc ]init];
    config.userContentController = [[WKUserContentController alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"Share"];
      _customWebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
      _customWebView.navigationDelegate=self;
        
    }
    
    return _customWebView;
}

-(UIWebView*)WDWebView{
    if (!_WDWebView) {
      
        _WDWebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        
        _WDWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth ;
        _WDWebView.delegate = self;
        _WDWebView.scalesPageToFit=YES;
        _WDWebView.hidden=YES;
        _WDWebView.backgroundColor=[UIColor WdMainBackgroundColor];
        
    }
    return _WDWebView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_left" higlightedImage:nil target:self action:@selector(backBtnClick)];
self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    
    [self loadWebViewDataWithUrl:self.urlStr];
}


#pragma mark 导航返回事件
- (void)backBtnClick
{
    
    
    if ([self.WDWebView canGoBack]) {
        
       
        [self.WDWebView goBack];
        
    } else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)loadWebViewDataWithUrl:(NSString*)urlStr
{
    [self.WDWebView reload];
   
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
[self.WDWebView loadRequest:request];
   
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [self hiddenProgressHUD];
    _WDWebView.hidden=NO;
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(self.title.length>12){
        self.title=[NSString stringWithFormat:@"%@...",[self.title substringToIndex:11]];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;

    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
    
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
    NSURL *URL = request.URL.absoluteURL;
    NSString *scheme = [URL path];
    
    DLog(@"+++%@",scheme);
  
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"share()" completionHandler:^(id item, NSError * _Nullable error) {
        
    }];
    
    
    
  
    
    
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
  //  NSDictionary *bodyParam = (NSDictionary*)message.body;
    //NSString *func = [bodyParam objectForKey:@"function"];
    
  //  DLog(@"MessageHandler Name:%@", message.name);
    //DLog(@"MessageHandler Body:%@", message.body);
    //DLog(@"MessageHandler Function:%@",func);
}
@end
