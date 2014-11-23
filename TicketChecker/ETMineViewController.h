//
//  ETMineViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-8.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBaseViewController.h"

@interface ETMineViewController : ETBaseViewController<UITableViewDelegate, UITableViewDataSource, UITabBarDelegate>
{
    IBOutlet UIImageView *ivHeadBar;
    IBOutlet UITabBar *tabbFooter;
    IBOutlet UITabBarItem *tabiScan;
    IBOutlet UITabBarItem *tabiMine;
    IBOutlet UITabBarItem *tabiOrder;

    __weak IBOutlet UITableView *tbvMine;
    __weak IBOutlet UINavigationBar *nvMine;
    __weak IBOutlet UINavigationItem *nviMine;
    IBOutlet UIButton *btnExit;
    
    int updateFlag;
}
@property(nonatomic, weak)NSString *orderType;

-(void)gotoAbout;
- (IBAction)btnExit:(id)sender;
-(void)goBack;

@end
