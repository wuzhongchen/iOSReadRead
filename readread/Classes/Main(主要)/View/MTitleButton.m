//
//  MTitleButton.m
//  readread
//
//  Created by hs on 2020/12/13.
//  Copyright © 2020 hs. All rights reserved.
//

#import "MTitleButton.h"

@implementation MTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
