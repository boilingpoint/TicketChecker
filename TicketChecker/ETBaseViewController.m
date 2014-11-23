//
//  ETCenterControllerViewController.m
//  TicketChecker
//
//  Created by admin on 13-12-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETBaseViewController.h"
#import "ETNetworkHelper.h"
#import "ETProgressHUD.h"

@interface ETBaseViewController ()

@end

@implementation ETBaseViewController

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
    [self isNetworkConnected];
        /*
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ShutNetworkTitle", nil) message:NSLocalizedString(@"ShutNetworkMessage", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Confirm", nil) otherButtonTitles:nil, nil];
         [alert show];
         */
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:ETProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:ETProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:ETProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:ETProgressHUDDidDisappearNotification
                                               object:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isNetworkConnected
{
    ETNetworkHelper *network = [[ETNetworkHelper alloc] init];
    if(![network connectedToNetwork])
    {
        [self dismissError:NSLocalizedString(@"ShutNetworkMessage", nil)];
        return false;
    }
    return true;
}
-(void)SetObject:(id)object ByKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}
-(id)GetObjectByKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

-(void)gotoView:(UIViewController *)viewController
{
    int flag = 0;
    
    for(UIViewController *controller in self.navigationController.viewControllers)
    {
        if([controller isKindOfClass:[viewController class]])
        {
            flag = 1;
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    if(flag == 0)
    {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


- (void)handleNotification:(NSNotification *)notif
{
    NSLog(@"Notification recieved: %@", notif.name);
    NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:ETProgressHUDStatusUserInfoKey]);
}

#pragma mark -
#pragma mark Show Methods Sample

- (void)show {
	[ETProgressHUD show];
}

- (void)showWithStatus:(NSString *)message {
    if(message == nil)
    {
        message = @"Doing Stuff";
    }
	[ETProgressHUD showWithStatus:message];
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [ETProgressHUD showProgress:0 status:@"Loading"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3];
}

- (void)increaseProgress:(NSString *)message {
    if(message == nil)
    {
        message = @"Loading!";
    }
    progress+=0.1f;
    [ETProgressHUD showProgress:progress status:message];
    
    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3];
    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}


#pragma mark -
#pragma mark Dismiss Methods Sample

- (void)dismiss {
	[ETProgressHUD dismiss];
}

- (void)dismissSuccess:(NSString *)message {
    if(message == nil)
    {
        message = @"Great Success!";
    }
	[ETProgressHUD showSuccessWithStatus:message];
}

- (void)dismissError:(NSString *)message {
    if(message == nil)
    {
        message = @"Failed with Error";
    }
	[ETProgressHUD showErrorWithStatus:message];
}
@end
