//
//  ETMineViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-8.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETMineViewController.h"
#import "ETAboutViewController.h"

#import "ETOrderListViewController.h"
#import "ETScanViewController.h"
#import "ETColor.h"
#import "MobClick.h"

@interface ETMineViewController ()

@end

@implementation ETMineViewController

@synthesize orderType;

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
    
    @autoreleasepool {
        nviMine.title = NSLocalizedString(@"Mine_Mine", @"");
        
        // Do any additional setup after loading the view.
        
        UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, 80, 30)];
        lblTitle.text = NSLocalizedString(@"Mine_Mine", nil);
        [lblTitle setFont:[UIFont fontWithName:@"Heiti SC" size:20.0]];
        [lblTitle setTextColor:[ETColor colorWithHexString:@"#ffffff"]];
        
        [ivHeadBar addSubview:lblTitle];
        
        
        tabbFooter = [[UITabBar alloc] init];
        tabiOrder = [[UITabBarItem alloc]init];
        tabiScan = [[UITabBarItem alloc]init];
        tabiMine = [[UITabBarItem alloc]init];
        
        tabbFooter.delegate = self;
        
        tabiOrder.tag = 0;
        tabiScan.tag = 1;
        tabiMine.tag = 2;
        
        [tabiMine setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        
        [tabiMine setFinishedSelectedImage:[ETColor scaleImage:[UIImage imageNamed:@"user_cur.png"] scaledToSize:CGSizeMake(30, 30)] withFinishedUnselectedImage:[ETColor scaleImage:[UIImage imageNamed:@"user.png"] scaledToSize:CGSizeMake(30, 30)]];
        
        [tabiOrder setImage:[UIImage imageNamed:@"order.png"]];
        [tabiOrder setTitle:NSLocalizedString(@"TabOrder", @"")];
        [tabiScan setImage:[ETColor scaleImage:[UIImage imageNamed:@"code.png"] scaledToSize:CGSizeMake(30, 30)]];
        [tabiScan setTitle:NSLocalizedString(@"TabCheckIn", @"")];
        //[tabiMine setImage:[ETColor scaleImage:[UIImage imageNamed:@"user.png"] scaledToSize:CGSizeMake(30, 30)]];
        [tabiMine setTitle:NSLocalizedString(@"TabMine", @"")];
        
        
        [tabbFooter setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"tab_bar.jpg"] scaledToSize:CGSizeMake(320, 50)]];
        float y = self.view.frame.size.height - 49;
        [tabbFooter setFrame:CGRectMake(0, y, 320, 49)];
        NSArray *itemArray = [[NSArray alloc] initWithObjects:tabiOrder
                              , tabiScan, tabiMine, nil];
        [tabbFooter setItems:itemArray];
        [self.view addSubview:tabbFooter];
        
        tbvMine.layer.cornerRadius = 6;
        tbvMine.layer.masksToBounds = YES;
        
        [btnExit setTitle:NSLocalizedString(@"About_Exit", nil) forState:UIControlStateNormal];
    }
}

-(void)viewDidLayoutSubviews
{
    [tabbFooter setSelectedItem:tabiMine];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return  30;
    }
    else
    {
        return 54;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tbvMine dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSUInteger row = [indexPath row];
    if(row == 0)
    {
        //cell.textLabel.text = NSLocalizedString(@"Mine_About", @"");
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(10, 0, 280, 54);
        [btn setTitle:NSLocalizedString(@"Mine_About", @"") forState:UIControlStateNormal];
        [btn setTitleColor:[ETColor colorWithHexString:@"#55555"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoAbout) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [cell.contentView addSubview:btn];
        
        //UITapGestureRecognizer *gestureAbout = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(gotoAbout)];
        //gestureAbout.numberOfTapsRequired = 1;
        //[cell.contentView addGestureRecognizer:gestureAbout];
    }
    else
    {
        //cell.textLabel.text = NSLocalizedString(@"Mine_Update", @"");
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(10, 0, 280, 54);
        [btn setTitle:NSLocalizedString(@"Mine_Update", @"") forState:UIControlStateNormal];
        [btn setTitleColor:[ETColor colorWithHexString:@"#55555"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkUpdate) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [cell.contentView addSubview:btn];
        
        //UITapGestureRecognizer *gestureUpdate = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(checkUpdate)];
        //gestureUpdate.numberOfTapsRequired = 1;
        //[cell.contentView addGestureRecognizer:gestureUpdate];
    }
    
    
    return cell;
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 0)
    {
        [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"orderListPage"]];
        //[self performSegueWithIdentifier:@"orderListPage" sender:self];
    }
    else if(item.tag == 1)
    {
        [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"scanPage"]];
        //[self performSegueWithIdentifier:@"scanPage" sender:self];
    }
    else
    {
        //[self performSegueWithIdentifier:@"minePage" sender:self];
    }
}
-(void)gotoScanPage
{
    [self performSegueWithIdentifier:@"scanPage" sender:self];
}
-(void)gotoOrderListPage
{
    [self performSegueWithIdentifier:@"orderListPage" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    id theSegue = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"orderListPage"] && [orderType isEqualToString:@"0"])
    {
        [theSegue setValue:@"0" forKey:@"orderType"];
        [theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
    else if([segue.identifier isEqualToString:@"orderListPage"] && [orderType isEqualToString:@"1"])
    {
        [theSegue setValue:@"1" forKey:@"orderType"];
        [theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
}

- (IBAction)btnExit:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Mine_ExitTitle", nil) message:NSLocalizedString(@"Mine_ExitMessage", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Mine_Cancel", nil) otherButtonTitles:NSLocalizedString(@"Mine_OK", nil), nil];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        return;
    }
    else if(buttonIndex == 1)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"token"];
        [userDefaults removeObjectForKey:@"merchant"];
        [userDefaults removeObjectForKey:@"expired"];
        
        [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"]];
        //[self performSegueWithIdentifier:@"loginPage" sender:self];
    }
}

/*
-(NSIndexPath *)tableView:(UITableView *) tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if(row == 0)
    {
        [self gotoAbout];
    }
    else
    {
        [self checkUpdate];
    }
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if(row == 0)
    {
        [self gotoAbout];
    }
    else
    {
        [self checkUpdate];
    }
}
*/


-(void)gotoAbout
{
    [self performSegueWithIdentifier:@"aboutPage" sender:self];
}

-(void)checkUpdate
{
    if(![self isNetworkConnected])
    {
        return;
    }
    if(updateFlag == 0)
    {
        updateFlag = 1;
        [MobClick checkUpdate];
        updateFlag = 0;
    }
    //[MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];

    //NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}

- (void)updateMethod:(NSDictionary *)appInfo {
    if([appInfo objectForKey:@"CFBundleShortVersionString"] == [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
    {
        [super showWithStatus:@"Current version is the newest version!"];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"umUpdateTitle", nil) message:NSLocalizedString(@"umUpdateTitle", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"umUpdateCancel", nil) otherButtonTitles:NSLocalizedString(@"umUpdateOK", nil), nil];
        [alert show];
    }
    updateFlag = 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



@end
