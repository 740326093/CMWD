//
//  WDLoginViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDLoginViewController.h"

@interface WDLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *PSWTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UILabel *errorLab;

@end

@implementation WDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"登录";
        UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
            [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
          [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
           self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    
}
-(void)leftBarBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _errorLab.text=@"";
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(_phoneTextField.text.length>0&&_PSWTextField.text.length>0) {
        
        _loginBtn.userInteractionEnabled=YES;
        [_loginBtn setBackgroundColor:[UIColor WdMainColor]];
    }else{
         _loginBtn.userInteractionEnabled=NO;
        [_loginBtn setBackgroundColor:[UIColor clmHex:0xcccccc]];
    }
    
}
#pragma mark 登录

- (IBAction)loginBtnEvent:(id)sender {
    if(![_phoneTextField.text checkPhoneNumInput]){
        _errorLab.text=@"手机号格式错误！";
        return;
    }else{
        _errorLab.text=@"";
    }
    
}

- (IBAction)registBtnEvent:(id)sender {
    WDRegistViewController *reg=[[WDRegistViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
    
    
}
- (IBAction)resetBtnEvent:(id)sender {
    
    FindPswViewController*find=[[FindPswViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//请求前，检查数据的有效性
- (BOOL)checkDataValidity {
    if (_phoneTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"账号不能为空"];
        return NO;
    } else if (_PSWTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"密码不能为空"];
        return NO;
    } else {
        return YES;
    }
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
