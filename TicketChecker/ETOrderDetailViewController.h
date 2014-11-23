//
//  ETOrderDetailViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETOrderInfo.h"
#import "ETBaseViewController.h"

@interface ETOrderDetailViewController : ETBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *ivHeadBar;
    IBOutlet UITableView *tbvOrderDetail;
    IBOutlet UIImageView *ivFootBar;
    IBOutlet UIButton *btnCheckIn;
    IBOutlet UIButton *btnNoshow;
    IBOutlet UILabel *lblOrderStateTitle;
    IBOutlet UILabel *lblOrderCodeTitle;
    IBOutlet UIButton *btnCheckAll;
    IBOutlet UILabel *lblCheckAll;
    
    IBOutlet UILabel *lblOrderState;
    
    IBOutlet UILabel *lblOrderCode;
    int checkedCount;
}

@property(nonatomic, weak)NSString *orderCode;
@property(nonatomic, retain)ETOrderInfo *orderInfo;
@property(nonatomic, retain)NSMutableArray *guestButtonArray;
@property(nonatomic, retain)NSMutableArray *guestLabelArray;
@property(nonatomic, retain)NSMutableArray *guestCheckArray;
-(void)checkGuestByAction:(NSString *)action;
@end
