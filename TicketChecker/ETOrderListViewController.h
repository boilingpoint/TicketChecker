//
//  ETOrderListViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETRefreshTableHeaderView.h"
#import "ETBaseViewController.h"

@interface ETOrderListViewController : ETBaseViewController<UITableViewDelegate,UITableViewDataSource, UITabBarDelegate,ETRefreshTableHeaderDelegate> {
    ETRefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    IBOutlet UIImageView *ivHeadBar;
    IBOutlet UITableView *tbvOrderList;
    IBOutlet UITabBar *tabbFooter;
    IBOutlet UITabBarItem *tabiScan;
    IBOutlet UITabBarItem *tabiMine;
    IBOutlet UITabBarItem *tabiOrder;
    __weak IBOutlet UINavigationBar *nvOrderList;
    
    IBOutlet UIActivityIndicatorView *progress;
}

@property(nonatomic, weak)NSString *orderType;
@property(nonatomic, weak)NSString *currentDate;
@property(nonatomic, weak)NSString *currentTitle;

@property(nonatomic, retain)NSString *orderCode;
@property(nonatomic, retain) NSArray *orderList;
@property int pageCount;
@property int orderCount;
@property int currentPage;
@property int pageSize;

-(void)goBack;
-(void)showDetail;

@end
