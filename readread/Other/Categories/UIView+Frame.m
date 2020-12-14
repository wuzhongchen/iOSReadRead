//
//  UIView+Frame.m
//  readread
//
//  Created by hs on 2020/12/13.
//  Copyright © 2020 hs. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)readread_x{
    return self.frame.origin.x;
}

- (void)setReadread_x:(CGFloat)readread_x{
    CGRect rect = self.frame;
    rect.origin.x = readread_x;
    self.frame = rect;
}

- (CGFloat)readread_y{
    return self.frame.origin.y;
}

- (void)setReadread_y:(CGFloat)readread_y{
    CGRect rect = self.frame;
    rect.origin.y = readread_y;
    self.frame = rect;
}

- (CGFloat)readread_width{
    return self.frame.size.width;
}

- (void)setReadread_width:(CGFloat)readread_width{
    CGRect rect = self.frame;
    rect.size.width = readread_width;
    self.frame = rect;
}

- (CGFloat)readread_height{
    return self.frame.size.height;
}

- (void)setReadread_height:(CGFloat)readread_height{
    CGRect rect = self.frame;
    rect.size.height = readread_height;
    self.frame = rect;
}

- (void)setReadread_centerX:(CGFloat)readread_centerX{
    CGPoint center = self.center;
    center.x = readread_centerX;
    self.center = center;

}
- (void)setReadread_centerY:(CGFloat)readread_centerY{
    CGPoint center = self.center;
    center.y = readread_centerY;
    self.center = center;
}
- (CGFloat)readread_centerX{
    return self.center.x;

}
- (CGFloat)readread_centerY{
    return self.center.y;
}

@end
