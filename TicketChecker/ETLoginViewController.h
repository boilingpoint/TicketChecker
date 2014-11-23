//
//  ETLoginViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-4.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBaseViewController.h"

@interface ETLoginViewController : ETBaseViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UINavigationControllerDelegate>
{
    
    //__weak IBOutlet UINavigationItem *nvPageTitle;
    __weak IBOutlet UILabel *lblUserName;
    __weak IBOutlet UILabel *lblPassword;
    __strong IBOutlet UITextField *txtUserName;
    __strong IBOutlet UITextField *txtPassword;
    __weak IBOutlet UIButton *btnLogin;
    __weak IBOutlet UIView *vLogin;
    __weak IBOutlet UITableView *tbvLogin;
    __weak IBOutlet UITableViewCell *tbcUserName;
    __weak IBOutlet UITableViewCell *tbcPassword;
    IBOutlet UIImageView *ivHeader;
    //IBOutlet UILabel *lblLoginMessage;
    //IBOutlet UIView *coverView;
}
- (IBAction)login:(id)sender;
-(IBAction)end:(id)sender;


- (IBAction)dismissError;
@end
