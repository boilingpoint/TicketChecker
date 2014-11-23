//
//  ETPushPopHelper.h
//  TicketChecker
//
//  Created by admin on 13-12-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETPushPopHelper : NSObject
+(void)gotoViewControllerFromList:(NSArray *)viewArray From:(NSString *)fromViewName To:(UIViewController *)toView;
@end
