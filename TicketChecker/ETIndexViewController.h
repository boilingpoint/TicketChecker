//
//  ETIndexViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ETRefreshTableHeaderView.h"
#import "ETBaseViewController.h"

@interface ETIndexViewController :  ETBaseViewController<UITableViewDelegate, UITableViewDataSource, UITabBarDelegate,ETRefreshTableHeaderDelegate>
{
    ETRefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSString *currentDate;
    NSDictionary *orderOverview;
    IBOutlet UILabel *lblTitle;
    
    UILabel *lblOrderNum;
    UILabel *lblOrderUserNum;
    UILabel *lblNoshowNum;
    UILabel *lblNoshowUserNum;
    
    __weak IBOutlet UIToolbar *tbIndex;
    __weak IBOutlet UIButton *btnCurrentOrders;
    __weak IBOutlet UIButton *btnNoShow;
    __weak IBOutlet UIButton *btnScan;
    IBOutlet UILabel *txtName;
    __weak IBOutlet UINavigationBar *nvbIndex;
    __strong IBOutlet UITabBarItem *tabiOrderList;
    __strong IBOutlet UITabBarItem *tabiScan;
    __strong IBOutlet UITabBarItem *tabiMine;
    __strong IBOutlet UITableView *tbvIndex;
    IBOutlet UITabBar *tabbIndex;
    IBOutlet UIImageView *imgBackground;
    IBOutlet UIView *vIndexSplit;
}

-(void)goCurrentOrders;
-(void)goMine;
-(void)goScan;
@end
