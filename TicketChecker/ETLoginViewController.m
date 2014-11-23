//
//  ETLoginViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-4.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETLoginViewController.h"
#import "ETIndexViewController.h"

#import "ETOrderInfo.h"
#import "ETColor.h"
#import "ETAuthorization.h"
#import "ETLabelHelper.h"

@implementation ETLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"token"];
    if(token != nil)
    {
        //[self performSegueWithIdentifier:@"indexPage" sender:self];
        [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"indexPage"]];
    }
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //lblUserName.text = NSLocalizedString(@"Login_UserName", @"");
    //lblPassword.text = NSLocalizedString(@"Login_Password", @"");
    [btnLogin setTitle:NSLocalizedString(@"Login_Login", @"") forState:UIControlStateNormal];
       
    tbvLogin.layer.cornerRadius = 6;
    tbvLogin.layer.masksToBounds = YES;
    

    [txtUserName addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [txtPassword addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    [self.view setBackgroundColor:[ETColor colorWithHexString:@"#e1e1e1"]];
    /*
    if(coverView == nil)
    {
        coverView = [[UIView alloc] init];
    }
    [self.view addSubview:coverView];
     */
}


-(void)viewDidLayoutSubviews
{
    //[nvPageTitle setTitle:NSLocalizedString(@"Login_Account", @"")];
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 100, 30)];
    lblTitle.text = NSLocalizedString(@"Login_Account", @"");
    [lblTitle setFont:[UIFont fontWithName:@"Heiti SC" size:20.0]];
    [lblTitle setTextColor:[ETColor colorWithHexString:@"#000000"]];
    
    [ivHeader addSubview:lblTitle];
    
    [self.navigationController  setNavigationBarHidden:YES animated:YES];
    /*
    [coverView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [coverView setBackgroundColor:[ETColor colorWithHexString:@"#000000"]];
    [coverView setHidden:true];
    [coverView setAlpha:0.2];
    lblLoginMessage = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#00ff00"] WithFrame:CGRectMake((self.view.frame.size.width/2) - 60, (self.view.frame.size.height/2) - 40, 250, 100) WidhtText:NSLocalizedString(@"Login_Message", nil) WithFontSize:14 WithFontName:nil WithAlignment:2];

    [coverView addSubview:lblLoginMessage];
    */
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tbvLogin dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.contentView.contentMode = UIViewContentModeRight;
    NSUInteger row = [indexPath row];
    if(row == 0) {
        UIImage *image = [ETColor scaleImage:[UIImage imageNamed:@"login_user_icon.png"] scaledToSize:CGSizeMake(24, 24)];
        txtUserName = [[UITextField alloc]initWithFrame:CGRectMake(50.0f, 5.0f, 190.0f, 40.0f)];
        txtUserName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        txtUserName.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtUserName.returnKeyType = UIReturnKeyNext;
        txtUserName.delegate = self;
        cell.imageView.image = image;
        [cell.contentView addSubview:txtUserName];
    } else {
        UIImage *image = [ETColor scaleImage:[UIImage imageNamed:@"login_pw_icon.png"] scaledToSize:CGSizeMake(24, 24)];
        cell.imageView.image = image;
        txtPassword = [[UITextField alloc]initWithFrame:CGRectMake(50.0f, 5.0f, 190.0f, 40.0f)];
        txtPassword.secureTextEntry = YES;
        txtPassword.returnKeyType = UIReturnKeyDone;
        txtPassword.delegate = self;
        //txtPassword addTarget:self action:@selector(login:) forControlEvents:UIControl
     
        
        [cell.contentView addSubview:txtPassword];
    }
    
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField returnKeyType] == UIReturnKeyNext)
    {
        [txtPassword becomeFirstResponder];
    }
    else if([textField returnKeyType] == UIReturnKeyDone)
    {
        [self login:btnLogin];
    }
    return true;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (IBAction)login:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login_ErrorTitle", nil) message:NSLocalizedString(@"Login_ErrorMessage", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    BOOL isAlert = false;
    if([txtUserName.text isEqualToString:@""])
    {
        [alert setMessage:NSLocalizedString(@"Login_NoUserName", nil)];
        isAlert = true;
    }
    else if([txtPassword.text isEqualToString:@""])
    {
        [alert setMessage:NSLocalizedString(@"Login_NoPassword", nil)];
        isAlert = true;
    }
    if(isAlert)
    {
        [alert show];
        return;
    }
    //[coverView setHidden:false];
    [super showWithStatus:NSLocalizedString(@"Login_Message", nil)];
    const char *queueName = [[[NSDate date] description] UTF8String];
    dispatch_queue_t myQueue = dispatch_queue_create(queueName, NULL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(myQueue, ^{
        ETUserInfo *user = [ETUserInfo alloc];
        [user init];
        user = [user getUserByUserName:txtUserName.text Password:[ETAuthorization sha1:txtPassword.text]];
        dispatch_async(mainQueue, ^{
            //[coverView setHidden:true];
            [super dismiss];
            if(user == nil || user.error != nil)
            {
                [alert show];
                
            }
            /*else if(user.error != nil)
            {
                alert.message = user.error;
                [alert show];
            }*/
            else
            {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:user.access_token forKey:@"token"];
                [userDefaults setObject:user.merchant_code forKey:@"merchant"];
                [userDefaults setObject:txtUserName.text forKey:@"user_name"];
                [userDefaults setObject:user.expire_in forKey:@"expired"];
                //[self performSegueWithIdentifier:@"indexPage" sender:self];
                
                
                [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"indexPage"]];
                //ETIndexViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"indexPage"];
                //[self.navigationController pushViewController:ctrl animated:YES];
               
            }
        });
    });
    
    //ETOrderInfo *order = [ETOrderInfo alloc];
    //[order init];
    //NSArray *orderList = [order getOrderListByStartTime:@"" AndEndTime:@""];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [self login:nil];
        return NO;
    }
    
    return YES;
}

-(IBAction)end:(id)sender
{
    [txtUserName resignFirstResponder];
    [txtPassword resignFirstResponder];
}
-(void)resumeView
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    float Y = 20.0f;
    CGRect rect = CGRectMake(0.0f, Y, width, height);
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(void)hideKeyboard
{
    [txtUserName resignFirstResponder];
    [txtPassword resignFirstResponder];
    [self resumeView];
}

-(IBAction)nextOnKeyboard:(UITextField *)sender
{
    if(sender == txtUserName)
    {
        [txtPassword becomeFirstResponder];
    }
    else if(sender == txtPassword)
    {
        [self hideKeyboard];
    }
}


@end
