//
//  FindPswViewController.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "FindPswViewController.h"

@interface FindPswViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPswTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property(nonatomic,strong)dispatch_source_t timer;

@end

@implementation FindPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"重置密码";
   
    [_phoneTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    [_pswTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    [_codeTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    [_ConfirmPswTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    
}

#pragma mark 获取短信验证码
- (IBAction)getCodeEvent:(id)sender {
   
 

    
    __block int timeout=100; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _getCodeBtn.userInteractionEnabled = YES;
            });
        }else{

            //int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                _getCodeBtn.userInteractionEnabled = NO;

            });
            timeout--;

        }
    });
    dispatch_resume(_timer);
    
    
}
#pragma mark 重置密码
- (IBAction)submitBtnEvent:(id)sender {
   
    
}


-(void)textChange:(UITextField*)text{
   
 if(_phoneTextField.text.length>0&&_pswTextField.text.length>0&&_codeTextField.text.length>0&&_ConfirmPswTextField.text.length>0) {
        
        _submitBtn.userInteractionEnabled=YES;
        [_submitBtn setBackgroundColor:[UIColor WdRedClolor]];
    }else{
        
        _submitBtn.userInteractionEnabled=NO;
        [_submitBtn setBackgroundColor:[UIColor clmHex:0xcccccc]];
    }
    if ([_phoneTextField.text checkPhoneNumInput]) {
       
        _getCodeBtn.userInteractionEnabled=YES;
        if ([_getCodeBtn.titleLabel.text isEqualToString:@"获取验证码"]) {
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
        [_getCodeBtn setBackgroundColor:[UIColor WdRedClolor]];
    }else{
        if (_timer) {
            dispatch_cancel(_timer);
            _timer=nil;
        }
        _getCodeBtn.userInteractionEnabled=NO;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundColor:[UIColor WdGrayClolor]];
    }
    
    
    
}
//这侧之前验证数据的有效性
- (BOOL)checkDataValidity {

    if (![_pswTextField.text isEqualToString:_ConfirmPswTextField.text]) {
        [self showAutoHiddenHUDWithMessage:@"两次密码必须一致"];
        return NO;
    } else {
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
