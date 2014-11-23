//
//  ETAboutViewController.h
//  TicketChecker
//
//  Created by admin on 13-11-8.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETAboutViewController : UIViewController
{
    IBOutlet UIImageView *ivHeadBar;
    
    __weak IBOutlet UIImageView *imgBackground;
    __weak IBOutlet UITextView *tvAbout;
    __weak IBOutlet UINavigationBar *nvAbout;
    __weak IBOutlet UIWebView *wbvIntro;
}
@end
