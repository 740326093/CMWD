//
//  BaseSendTextView.m
//  vodSeal
//
//  Created by wangwei on 2017/88/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "CMShareTextView.h"
#import "CMSendBtnView.h"


#define BTN_WIDTH           60//按钮宽度

#define BTN_FRAME_X         10.0//按钮x开始坐标(距父视图左边距)
#define BTN_MINI_SPACE      5.0//按钮之间最小间距

@interface CMShareTextView()

@property (nonatomic, assign, readwrite) NSInteger      columnNum;/**< 按钮列数 */
@property (nonatomic, assign, readwrite) CGFloat        animateTime;
@property (nonatomic, assign)  CGSize       btnViewSize;/**< 按钮视图大小 */
@property (nonatomic, assign)  CGFloat      btnFrameX;//按钮起始X坐标（以此为准）
@property (nonatomic, assign)  CGFloat      btnFrameY;//按钮起始Y坐标
@property (nonatomic, assign)  CGFloat      btnItemSpace;//按钮间距（与btnFrameX相同）
@property (nonatomic, assign)  NSInteger    btnRowNum;//按钮行数


@property (nonatomic, strong)  NSMutableArray<CMSendBtnView *>    *btnViewArray;



@end

@implementation CMShareTextView

- (NSMutableArray<CMSendBtnView *> *)btnViewArray{
    if (!_btnViewArray) {
        self.btnViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnViewArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.animateTime = 0.7;

  NSArray *titleAndImages=@[@"QQ好友",@"QQ空间",@"微信好友",@"微信朋友圈",@"新浪微博"];
  NSInteger columnMaxNum = ((frame.size.width - BTN_FRAME_X * 2.0 - BTN_MINI_SPACE * 2.0) / BTN_WIDTH);
     self.columnNum = (3 <= columnMaxNum)?3:columnMaxNum;
        _btnViewSize = CGSizeMake(BTN_WIDTH, BTN_WIDTH + 30.0);
        
        _btnRowNum = (titleAndImages.count + self.columnNum - 1) / self.columnNum;
        _btnFrameX = (frame.size.width - BTN_WIDTH * self.columnNum) / (self.columnNum + 1);
        _btnFrameY = frame.size.height / 2.0 + _btnViewSize.height * _btnRowNum / 2.0-_btnViewSize.height;
        _btnItemSpace = _btnFrameX;
 
        if([[UIDevice currentDevice].systemVersion floatValue]>=8.0){
            
           
                UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
                effe.frame = self.bounds;
                effe.alpha = 0.8;
               [self addSubview:effe];
               UIView *bgView=[[UIView alloc]initWithFrame:self.bounds];
                bgView.backgroundColor=[UIColor whiteColor];
            
                    [effe.contentView addSubview:bgView];

       
        for (int i = 0; i < titleAndImages.count; i++) {
    
                CMSendBtnView *btnView = [[CMSendBtnView alloc]initWithFrame:CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height)];

                btnView.btnImageView.image = [UIImage imageNamed:titleAndImages[i]];
                btnView.btnTitleLabel.text = titleAndImages[i];
                btnView.sendViewButton.tag = i;
                
                [btnView.sendViewButton addTarget:self action:@selector(sendViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:btnView];
          
            
                [self.btnViewArray addObject:btnView];
            }
         
            
        }else{
            UIView *bgView=[[UIView alloc]initWithFrame:self.frame];
            bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
            for (int i = 0; i < titleAndImages.count; i++) {
                
                CMSendBtnView *btnView = [[CMSendBtnView alloc]initWithFrame:CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height)];
                
                btnView.btnImageView.image = [UIImage imageNamed:titleAndImages[i]];
                btnView.btnTitleLabel.text = titleAndImages[i];
                btnView.sendViewButton.tag = i;
                
                [btnView.sendViewButton addTarget:self action:@selector(sendViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:btnView];
              
                [self.btnViewArray addObject:btnView];
            }
            

            
            
        }
   
        UIImage *image=[UIImage imageNamed:@"D_Cn_Order_Delete"];
        UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [CancleBtn setBackgroundImage:image forState:UIControlStateNormal];
        [CancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:CancleBtn];
        
        [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(image.size.height/2.0);
            make.width.mas_equalTo(image.size.width/2.0);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
        
    }
    return self;
}



- (void)sendViewButtonClicked:(UIButton *)sender{
   
        CMSendBtnView *btnView = (CMSendBtnView *)sender.superview;
    
    
    
        
        switch (btnView.sendViewButton.tag) {
            case 0:
                [self shareDetail:SSDKPlatformSubTypeQQFriend];
              
                break;
            case 1:
                [self shareDetail:SSDKPlatformSubTypeQZone];
            
                break;
            case 2:
                [self shareDetail:SSDKPlatformSubTypeWechatSession];
                
                break;
            case 3:
                [self shareDetail:SSDKPlatformSubTypeWechatTimeline];
              
                break;
            case 4:
                [self shareDetail:SSDKPlatformTypeSinaWeibo];
                
                break;
                
            default:
                break;
        }
    
        [self hiddenSendTextView];

    
    
    

    
}



-(void)cancleBtnClick{
   
    [self hiddenSendTextView];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hiddenSendTextView];
}

- (void)showSendTextView{
   
    CGFloat delyTime = 0.08;
    for (int i = 0; i < self.btnViewArray.count; i++) {
        __strong CMSendBtnView *btnView = [self.btnViewArray objectAtIndex:i];
        if (i == self.btnViewArray.count - 1) {
            [UIView animateWithDuration:self.animateTime delay:delyTime * i usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{

                        btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), _btnFrameY + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);

            } completion:^(BOOL finished) {
                
            }];
        }else{
            [UIView animateWithDuration:self.animateTime delay:delyTime * i usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
             
                    
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), _btnFrameY + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    
    [window addSubview:self];
}

- (void)hiddenSendTextView{
    CGFloat delyTime = 0.08;
    for (int i = 0; i < self.btnViewArray.count; i++) {
        __strong CMSendBtnView *btnView = [self.btnViewArray objectAtIndex:i];
        if (i == self.btnViewArray.count - 1) {
            
            [UIView animateWithDuration:self.animateTime delay:delyTime * (self.btnViewArray.count - i - 1) usingSpringWithDamping:0.7 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
             
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), self.frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
              
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                
            }];
        }else{
            [UIView animateWithDuration:self.animateTime delay:delyTime * (self.btnViewArray.count - i - 1) usingSpringWithDamping:0.7 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), self.frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
           
                    
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}



-(void)shareDetail:(SSDKPlatformType)PlatformType{
    
    
    NSURL *url = [NSURL URLWithString:self.contentUrl];
    
    if (self.ShareImageName) {
        
        NSString *content;
        if (PlatformType==SSDKPlatformTypeSinaWeibo) {
            if ([self.contentStr isEqualToString:@""]) {
                content=[NSString stringWithFormat:@"%@%@",self.titleConten,self.contentUrl];
            }else{
            content=[NSString stringWithFormat:@"%@%@",self.contentStr,self.contentUrl];
            }
        }else{
            content=self.contentStr;
        }
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                         images:self.ShareImageName
                                        url:url
                                          title:self.titleConten
                                           type:SSDKContentTypeAuto];
        [ShareSDK share:PlatformType parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     RAlertView *alert = [[RAlertView alloc] initWithStyle:ConfirmAlert];
                     alert.headerTitleLabel.text = @"";
                     alert.contentTextLabel.attributedText = [TextHelper attributedStringForString:@"分享成功" lineSpacing:5];
                     alert.contentTextLabel.textAlignment=NSTextAlignmentCenter;
                     [alert.confirmButton setTitle:@"OK" forState:UIControlStateNormal];
                     alert.theme=[UIColor WdRedClolor];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     
                     
                     RAlertView *alert = [[RAlertView alloc] initWithStyle:ConfirmAlert];
                     alert.headerTitleLabel.text = @"分享失败";
                     alert.contentTextLabel.attributedText = [TextHelper attributedStringForString:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"error_message"]] lineSpacing:5];
                     alert.contentTextLabel.textAlignment=NSTextAlignmentCenter;
                     [alert.confirmButton setTitle:@"OK" forState:UIControlStateNormal];
                     alert.theme=[UIColor WdRedClolor];

                     break;
                 }
                 default:
                     break;
             }
             
             
             
             
         }];
        
        
        
    }
    
    
    
    
}


@end
