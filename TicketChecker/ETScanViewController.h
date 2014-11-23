//
//  ETScanViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-4.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ETOrderInfo.h"
#import "ETBaseViewController.h"

@interface ETScanViewController : ETBaseViewController<ZBarReaderDelegate, UITabBarDelegate>{
    IBOutlet UIImageView *ivHeadBar;
    IBOutlet UITabBar *tabbFooter;
    IBOutlet UITabBarItem *tabiScan;
    IBOutlet UITabBarItem *tabiMine;
    IBOutlet UITabBarItem *tabiOrder;
    IBOutlet UILabel *lblResult;
    IBOutlet ZBarReaderView *readerView;
    
    IBOutlet UITextField *txtOrderCode;
    
    IBOutlet UIImageView *imgQrcode;
    __weak IBOutlet UIButton *btnScan;
    ZBarCameraSimulator *cameraSim;
    IBOutlet UIView *vContent;
    
    ETOrderInfo *order;
}
@property(nonatomic, weak)NSString *orderType;
@property(nonatomic, weak)NSString *orderCode;

- (IBAction)getBack:(id)sender;
@property (nonatomic, retain) UILabel *label;
//@property (retain, nonatomic) IBOutlet ZBarReaderView *readerView;
- (IBAction)scanCode:(id)sender;
- (IBAction)clickPhoto:(id)sender;
- (IBAction)txtOrderCodeChanged:(id)sender;

@end
