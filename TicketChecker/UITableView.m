//
//  UITableView.m
//  TicketChecker
//
//  Created by admin on 13-11-20.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "UITableView.h"

@implementation UITableView (UITableViewCategory)
UIImageView *backgroundView;
-(void) setBackgroundImage:(UIImage *)image
{
    if(image == nil)
    {
        [backgroundView removeFromSuperview];
    }
    else
    {
        backgroundView = [[UIImageView alloc] initWithImage:image];
        backgroundView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self setBackgroundView:backgroundView];
    }
}

@end
