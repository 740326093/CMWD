//
//  CMCircleProgress.m
//
//  Created by Mac on 2016/12/23.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMCircleProgress.h"
#import"NSTimer+timerBlock.h"

//角度转换为弧度
#define CircleDegreeToRadian(d) ((d)*M_PI)/180.0
#define CircleSelfWidth self.frame.size.width
#define CircleSelfHeight self.frame.size.height

@implementation CMCircleProgress
{
    CGFloat fakeProgress;
    NSTimer *NewTimer;//定时器用作动画
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}


//初始化数据
- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    _pathBackColor = [UIColor WdMainBackgroundColor];
    _pathFillColor = [UIColor WdRedClolor];
    _strokeWidth = 5;//线宽默认为10
    _startAngle = CircleDegreeToRadian(-90);//圆起点位置
    _reduceValue = CircleDegreeToRadian(0);//整个圆缺少的角度
    _animationModel = CircleIncreaseByProgress;//根据进度来
    fakeProgress = 0.0;//用来逐渐增加直到等于progress的值
    _showProgressText = YES;//文字
}

#pragma Set
- (void)setStartAngle:(CGFloat)startAngle {
    if (_startAngle != CircleDegreeToRadian(startAngle)) {
        _startAngle = CircleDegreeToRadian(startAngle);
        [self setNeedsDisplay];
    }
}

- (void)setReduceValue:(CGFloat)reduceValue {
    if (_reduceValue != CircleDegreeToRadian(reduceValue)) {
        if (reduceValue>=360) {
            return;
        }
        _reduceValue = CircleDegreeToRadian(reduceValue);
        [self setNeedsDisplay];
    }
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    if (_strokeWidth != strokeWidth) {
        _strokeWidth = strokeWidth;
        [self setNeedsDisplay];
    }
}

- (void)setPathBackColor:(UIColor *)pathBackColor {
    if (_pathBackColor != pathBackColor) {
        _pathBackColor = pathBackColor;
        [self setNeedsDisplay];
    }
}

- (void)setPathFillColor:(UIColor *)pathFillColor {
    if (_pathFillColor != pathFillColor) {
        _pathFillColor = pathFillColor;
        [self setNeedsDisplay];
    }
}


-(void)setShowProgressText:(BOOL)showProgressText {
    if (_showProgressText != showProgressText) {
        _showProgressText = showProgressText;
        [self setNeedsDisplay];
    }
}


//画背景线、填充线、小圆点、文字
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置中心点 半径 起点及终点
    CGFloat maxWidth = self.frame.size.width<self.frame.size.height?self.frame.size.width:self.frame.size.height;
    CGPoint center = CGPointMake(maxWidth/2.0, maxWidth/2.0);
    CGFloat radius = maxWidth/2.0-_strokeWidth/2.0-1;//留出一像素，防止与边界相切的地方被切平
    CGFloat endA = _startAngle + (CircleDegreeToRadian(360) - _reduceValue);//圆终点位置
    CGFloat valueEndA = _startAngle + (CircleDegreeToRadian(360)-_reduceValue)*fakeProgress;  //数值终点位置
    //背景线
    UIBezierPath *basePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:endA clockwise:YES];
    //线条宽度
    CGContextSetLineWidth(ctx, _strokeWidth);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //线条颜色
    [_pathBackColor setStroke];
    //把路径添加到上下文
    CGContextAddPath(ctx, basePath.CGPath);
    //渲染背景线
    CGContextStrokePath(ctx);
    
    //路径线
    UIBezierPath *valuePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:valueEndA clockwise:YES];
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //线条颜色
    [_pathFillColor setStroke];
    //把路径添加到上下文
    CGContextAddPath(ctx, valuePath.CGPath);
    //渲染数值线
    CGContextStrokePath(ctx);
    
    if (_showProgressText) {
        //画文字
        NSString *currentText = [NSString stringWithFormat:@"%d%%",(int)(fakeProgress*100)];
    
        //段落格式
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment = NSTextAlignmentCenter;//水平居中
        //字体
        UIFont *font = [UIFont systemFontOfSize:13.0];
        //构建属性集合
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor WdRedClolor]};
        //获得size
        CGSize stringSize = [currentText sizeWithAttributes:attributes];
        //垂直居中
        CGRect r = CGRectMake((CircleSelfWidth-stringSize.width)/2.0, (CircleSelfHeight - stringSize.height)/2.0,stringSize.width, stringSize.height);
        [currentText drawInRect:r withAttributes:attributes];
    }
    
}

//设置进度
- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    fakeProgress = 0.0;
    
    if (NewTimer) {
        [NewTimer invalidate];
        NewTimer = nil;
    }
    
    //如果为0则直接刷新
    if (_progress == 0.0) {
        [self setNeedsDisplay];
        return;
    }
    
    
    __weak typeof(self) weakSelf = self;
   NewTimer= [NSTimer scheduledTimerWithTimeInterval:0.005 block:^{
       
     
       if (fakeProgress >= _progress || fakeProgress >= 1.0f) {
           //最后一次赋准确值
           fakeProgress = _progress;
           [weakSelf setNeedsDisplay];
           
           if (NewTimer) {
               [NewTimer invalidate];
               NewTimer = nil;
           }
           return;
       } else {
           //进度条动画
           [weakSelf setNeedsDisplay];
       }
       //数值增加
       if (_animationModel == CircleIncreaseSameTime) {
           fakeProgress += 0.01*(_progress);//不同进度动画时间基本相同
       } else {
           fakeProgress += 0.01;//进度越大动画时间越长。
//           if (fakeProgress==progress) {
//               return ;
//           }
       }
       

   } repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:NewTimer forMode:NSRunLoopCommonModes];
    
}
@end
