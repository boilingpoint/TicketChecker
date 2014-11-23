//
//  ETCenterControllerViewController.h
//  TicketChecker
//
//  Created by admin on 13-12-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNetworkHelper.h"

@interface ETBaseViewController : UIViewController
- (IBAction)goto:(id)sender;

-(void)SetObject:(id)object ByKey:(NSString *)key;
-(id)GetObjectByKey:(NSString *)key;
-(void)gotoView:(UIViewController *)viewController;


- (IBAction)show;
- (IBAction)showWithStatus:(NSString *)message;

- (IBAction)dismiss;
- (IBAction)dismissSuccess:(NSString *)message;
- (IBAction)dismissError:(NSString *)message;

-(bool)isNetworkConnected;
@end
