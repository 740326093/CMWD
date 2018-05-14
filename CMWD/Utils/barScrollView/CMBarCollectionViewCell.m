//
//  CMBarCollectionViewCell.m

//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//




#import "CMBarCollectionViewCell.h"

@implementation CMBarCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}




-(UIImageView*)imageView{
    if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
     _imageView.frame = self.bounds;
    }
    return _imageView;
}

@end
