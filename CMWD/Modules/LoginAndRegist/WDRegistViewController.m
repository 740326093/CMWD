//
//  WDRegistViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDRegistViewController.h"

@interface WDRegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *PSWTextField;

@property (weak, nonatomic) IBOutlet UITextField *ConfirmTextField;
@property (weak, nonatomic) IBOutlet UITextField *smsTextField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *serverBtn;

@end

@implementation WDRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册";
    _registBtn.layer.cornerRadius=5.0;
    [_phoneTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    [_PSWTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    [_ConfirmTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    [_smsTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    
    
}


#pragma mark 去登陆
- (IBAction)goLoginEvent:(id)sender {
    
     [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 获取短信验证码
- (IBAction)getSmsCodeEvent:(id)sender {
    
}
#pragma mark 注册
- (IBAction)registBtnEvent:(id)sender {
   
}

-(void)textChange:(UITextField*)text{
    
    if(_phoneTextField.text.length>0&&_PSWTextField.text.length>0&&_ConfirmTextField.text.length>0&&_smsTextField.text.length>0&&_serverBtn.selected) {
        
        _registBtn.userInteractionEnabled=YES;
        [_registBtn setBackgroundColor:[UIColor WdMainColor]];
    }else{
        
        _registBtn.userInteractionEnabled=NO;
        [_registBtn setBackgroundColor:[UIColor clmHex:0xcccccc]];
    }
    
}
- (IBAction)agreeServerBtnEvent:(id)sender {
    UIButton *btnSender=(UIButton*)sender;
    btnSender.selected =!btnSender.selected;
    [_serverBtn setBackgroundImage:[UIImage imageNamed:@"btnUnselected"] forState:UIControlStateNormal];
    [_serverBtn setBackgroundImage:[UIImage imageNamed:@"btnSelected"] forState:UIControlStateSelected];
    if (([_phoneTextField.text length] > 0 && [_PSWTextField.text length] > 0) && ([_ConfirmTextField.text length] > 0 && [_smsTextField.text length] > 0)&&btnSender.isSelected) {
        _registBtn.userInteractionEnabled = YES;
        [_registBtn setBackgroundColor:[UIColor WdMainColor]];
        
    } else {
        _registBtn.userInteractionEnabled = NO;
        [_registBtn setBackgroundColor:[UIColor WdGrayClolor]];
        
    }
}
- (IBAction)serverAgreementEvent:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
