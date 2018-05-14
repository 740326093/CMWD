//
//  BaseSendTextView.h


//  Created by wangwei on 2017/8/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CMShareTextView : UIView

@property (nonatomic,copy) NSString *contentUrl; //分享链接
@property (nonatomic,copy) NSString *titleConten; //标题
@property (nonatomic,copy) NSString *contentStr; //n内容
@property (nonatomic,strong) NSArray *ShareImageName; //n内容

- (void)showSendTextView;



@end
