//
//  WDNavigationBar.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDNavigationBar.h"
#import <QuartzCore/QuartzCore.h>
@interface WDNavigationBar ()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end
@implementation WDNavigationBar

static CGFloat const kDefaultOpacity = 0.5f;

- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors
{
    // create the gradient layer
    if (self.gradientLayer == nil) {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.opacity = self.translucent ? kDefaultOpacity : 1.0f;
    }
    
    NSMutableArray * colors = nil;
    if (barTintGradientColors != nil)
    {
        colors = [NSMutableArray arrayWithCapacity:[barTintGradientColors count]];
        
        // determine elements in the array are colours
        // and add them to the colors array
        [barTintGradientColors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIColor class]])
            {
                // UIColor class
                [colors addObject:(id)[obj CGColor]];
            }
            else if ( CFGetTypeID( (__bridge void *)obj ) == CGColorGetTypeID() )
            {
                // CGColorRef
                [colors addObject:obj];
            }
            else
            {
                // obj is not a supported type
                @throw [NSException exceptionWithName:@"BarTintGraidentColorsError" reason:@"object in barTintGradientColors array is not a UIColor or CGColorRef" userInfo:nil];
            }
        }];
        self.gradientLayer.locations = @[@0, @0.8,@1.5];
        // 颜色渐变的起点和终点，范围为 (0~1.0, 0~1.0)
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1.0, 0);
      
        self.barTintColor = [UIColor clearColor];
      
    self.gradientLayer.colors = colors;
}
}
#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
 
    if ( self.gradientLayer != nil )
    {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        self.gradientLayer.frame = CGRectMake(0, 0 - statusBarHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight);
   
        [self.layer insertSublayer:self.gradientLayer atIndex:1];
    }
}

@end
