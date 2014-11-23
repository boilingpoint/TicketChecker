//
//  ETAboutViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-8.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETAboutViewController.h"
#import "ETColor.h"
#import "ETLabelHelper.h"
#import "ETAppInfo.h"

@interface ETAboutViewController ()

@end

@implementation ETAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [btnBack setTitle:NSLocalizedString(@"GoBack", nil) forState:UIControlStateNormal];
    [btnBack setTitleColor:[ETColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnBack setFont:[UIFont fontWithName:@"Heiti SC" size:12.0]];
    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnBack setBackgroundImage:[UIImage imageNamed:@"back_but.png"] forState:UIControlStateNormal];
    //UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 80, 30)];
    //lblTitle.text = NSLocalizedString(@"Mine_Mine", nil);
    //[lblTitle setFont:[UIFont fontWithName:@"Heiti SC" size:20.0]];
    //[lblTitle setTextColor:[ETColor colorWithHexString:@"#ffffff"]];
    
    UILabel *lblTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#ffffff"] WithFrame:CGRectMake(120, 10, 200, 30) WidhtText:NSLocalizedString(@"Mine_Mine", nil) WithFontSize:20.0 WithFontName:@"Heiti SC" WithAlignment:2];
    [ivHeadBar addSubview:btnBack];
    [ivHeadBar addSubview:lblTitle];
    /*
    UINavigationItem *back = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"Mine_Mine", <#comment#>)];
    //back.backBarButtonItem.title = NSLocalizedString(@"GoBack", @"");
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(goBack)];
    //nviMine.leftBarButtonItem = leftButton;
    back.leftBarButtonItem = leftButton;
    [nvAbout pushNavigationItem:back animated:YES];
     */
    
    NSString *language = NSLocalizedString(@"language", nil);
    //做线上自动更新关于我们的文字
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *oldLanguage = [userDefaults objectForKey:@"language"];
    NSString *aboutMe = [userDefaults objectForKey:@"aboutme"];
    ETAppInfo *appInfo = nil;
    
    if([language isEqualToString:oldLanguage])
    {
        [wbvIntro loadHTMLString:aboutMe baseURL:nil];
    }
    else
    {
        appInfo = [ETAppInfo alloc];
        [appInfo init];
        appInfo = [appInfo getAppInfoByLanguage:NSLocalizedString(@"language", nil)];
        if(appInfo != nil)
        {
            [wbvIntro loadHTMLString:[appInfo aboutMe] baseURL:nil];
            [userDefaults setObject:NSLocalizedString(@"language", nil) forKey:@"language"];
            [userDefaults setObject:[appInfo aboutMe] forKey:@"aboutme"];
        }
    }
    
    if(aboutMe == nil && appInfo == nil && [language isEqualToString:@"zh-CN"])
    {
        [wbvIntro loadHTMLString:@"TotalGDS将区域内所有旅游资源的产品和服务数字化通过移动网络发布，将所有线上和线下销售的网店、网络整体结合，以多种语言、多渠道、多媒介的方式，实现旅游品牌形象的传播、资源服务的推介、预定支付等电子交易的一体化。可以达到区域内国内游和入境游得无障碍消费，将目的地旅游整体推向托内客户群和其他主要客源地国家，达到通过旅游走向世界。<br/><br/>广州易徒乐商务服务有限公司<br/>地址：广东省广州市越秀区东风西路253号五楼501室<br/>电话/传真：020-83297083" baseURL:nil];
    }
    else if(aboutMe == nil && appInfo == nil && [language isEqualToString:@"en-US"])
    {
        [wbvIntro loadHTMLString:@"We built TotalGDS to give you complete control over your business and assist you in delivering the memorable experiences your customers deserve.<br/>Think of TotalGDS as the rock solid foundation for your business. Inventory Control, Product Control, Multimedia Displays, Price Management, Real-time Booking, Contract Management, Business Intelligence, Special Events - TotalGDS is your one-stop solution for the solid foundation of your successful business.<br/>Etour Activity International(Hong Kong)Inc.Ltd.<br/>Address:Unit 1,14/F.,Yue Xiu Building,160-174 Lockhart Road,Wanchai,Hong Kong<br/>Customer Service:service@etourer.com" baseURL:nil];
    }
    
}

-(void)viewDidLayoutSubviews
{
    float height = self.view.frame.size.height + 111;
    [wbvIntro setFrame:CGRectMake(wbvIntro.frame.origin.x,
                                      wbvIntro.frame.origin.y,
                                      wbvIntro.frame.size.width,
                                      height)];
}
-(void)goBack
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
