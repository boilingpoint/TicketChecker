//
//  ETIndexViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETIndexViewController.h"
#import "ETMineViewController.h"
#import "ETOrderListViewController.h"
#import "ETScanViewController.h"
#import "ETColor.h"
#import "ETOrderInfo.h"


#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@implementation ETIndexViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)goCurrentOrders
{
    if(![super isNetworkConnected]) {
        return;
    }
    [self SetObject:@"0" ByKey:@"orderType"];
    [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"orderListPage"]];
}
-(void)goNoshowOrders
{
    if(![super isNetworkConnected]) {
        return;
    }
    [self SetObject:@"1" ByKey:@"orderType"];
    [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"orderListPage"]];
}

-(void)goMine
{
    [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"minePage"]];
}

-(void)goScan
{
    [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"scanPage"]];
}

-(void)viewDidLayoutSubviews
{
    [self.navigationController  setNavigationBarHidden:YES animated:YES];
    [tabbIndex setSelectedItem:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    txtName.text = NSLocalizedString(@"Name", nil);
    
    [btnCurrentOrders setTitle:NSLocalizedString(@"Index_CurrentOrder", @"") forState:UIControlStateNormal];
    [btnNoShow setTitle:NSLocalizedString(@"Index_Noshow", @"") forState:UIControlStateNormal];
    [btnScan setTitle:NSLocalizedString(@"Index_Scan", @"") forState:UIControlStateNormal];
    
    
    tabbIndex = [[UITabBar alloc] init];
    tabiOrderList = [[UITabBarItem alloc]init];
    tabiScan = [[UITabBarItem alloc]init];
    tabiMine = [[UITabBarItem alloc]init];
    
    tabbIndex.delegate = self;
    
    tabiOrderList.tag = 0;
    tabiScan.tag = 1;
    tabiMine.tag = 2;
    
    [tabiOrderList setImage:[UIImage imageNamed:@"order.png"]];
    [tabiOrderList setTitle:NSLocalizedString(@"TabOrder", @"")];
    [tabiScan setImage:[ETColor scaleImage:[UIImage imageNamed:@"code.png"] scaledToSize:CGSizeMake(30, 30)]];
    [tabiScan setTitle:NSLocalizedString(@"TabCheckIn", @"")];
    [tabiMine setImage:[ETColor scaleImage:[UIImage imageNamed:@"user.png"] scaledToSize:CGSizeMake(30, 30)]];
    [tabiMine setTitle:NSLocalizedString(@"TabMine", @"")];
    
    [tabbIndex setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"tab_bar.jpg"] scaledToSize:CGSizeMake(320, 50)]];
    float y = self.view.frame.size.height - 49;
    [tabbIndex setFrame:CGRectMake(0, y, 320, 49)];
    NSArray *itemArray = [[NSArray alloc] initWithObjects:tabiOrderList
    , tabiScan, tabiMine, nil];
    [tabbIndex setItems:itemArray];
    [self.view addSubview:tabbIndex];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    currentDate = [formatter stringFromDate:[NSDate date]];
    lblTitle.text = currentDate;
    [self SetObject:currentDate ByKey:@"currentDate"];
    
    tbvIndex.backgroundColor = [ETColor colorWithHexString:@"#1f709d"];
    
    tbvIndex.layer.cornerRadius = 6;
    tbvIndex.layer.masksToBounds = YES;
    
    

    //imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 455)];
    imgBackground.image = [ETColor scaleImage:[UIImage imageNamed:@"today_order_bg.jpg"] scaledToSize:CGSizeMake(320, 455)];
    
    vIndexSplit.frame = CGRectMake(50, 10, 301, 20);
    [vIndexSplit setBounds:CGRectMake(0, 10, 301, 20)];
    
    [self bindOrderInfo];
    
    if (_refreshHeaderView == nil) {
        ETRefreshTableHeaderView * view = [[ETRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-tbvIndex.bounds.size.height, tbvIndex.frame.size.width, tbvIndex.bounds.size.height)];
        view.delegate = self;
        
        [tbvIndex addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 0)
    {
        [self goCurrentOrders];
        //[self performSegueWithIdentifier:@"todayOrderList" sender:self];
    }
    else if(item.tag == 1)
    {
        [self goScan];
        //[self performSegueWithIdentifier:@"scanPage" sender:self];
    }
    else
    {
        [self goMine];
        //[self performSegueWithIdentifier:@"minePage" sender:self];
    }
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    id theSegue = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"todayOrderList"])
    {
        [theSegue setValue:@"0" forKey:@"orderType"];
        [theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
    else if([segue.identifier isEqualToString:@"noshowOrderList"])
    {
        [theSegue setValue:@"1" forKey:@"orderType"];
        [theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
    else if([segue.identifier isEqualToString:@"orderListPage"])
    {
        [theSegue setValue:@"0" forKey:@"orderType"];
        [theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
    else if([segue.identifier isEqualToString:@"minePage"])
    {
        [theSegue setValue:@"0" forKey:@"orderType"];
    }
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *splitView = [[UIImageView alloc] init];
    [splitView setImage:[ETColor scaleImage:[UIImage imageNamed:@"index_split.jpg"] scaledToSize:CGSizeMake(300, 16)]];
    return splitView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 16;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath section];
    
    static NSString *SimpleTableIdentifier = @"todayOrder";
    if(row == 0)
    {
        SimpleTableIdentifier = @"todayOrder";
    }
    else
    {
        SimpleTableIdentifier = @"noshowOrder";
    }
    UITableViewCell *cell = [tbvIndex dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        
    }
    else
    {
        while([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.contentView.contentMode = UIViewContentModeRight;
    if(row == 0) {
        UIImage *image = [ETColor scaleImage:[UIImage imageNamed:@"order_number.png"] scaledToSize:CGSizeMake(34, 38)];
        UILabel *lblOrderContent = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 5.0f, 190.0f, 40.0f)];
        lblOrderContent.text = NSLocalizedString(@"Index_TodayOrder", @"");
        lblOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(210.0f, 5.0f, 190.0f, 40.0f)];
        [lblOrderNum setTextColor:[ETColor colorWithHexString:@"#fa5d0e"]];
        //lblOrderNum.text = @"100";
        UILabel *lblOrderUserContent = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 30.0f, 190.0f, 40.0f)];
        lblOrderUserContent.text = NSLocalizedString(@"Index_TodayGuest", @"");
        lblOrderUserNum = [[UILabel alloc] initWithFrame:CGRectMake(210.0f, 30.0f, 190.0f, 40.0f)];
        [lblOrderUserNum setTextColor:[ETColor colorWithHexString:@"#fa5d0e"]];
        //lblOrderUserNum.text = @"200";
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goCurrentOrders)];
        [cell addGestureRecognizer:tapGesture];
        
        cell.imageView.image = image;
        [cell.contentView addSubview:lblOrderContent];
        [cell.contentView addSubview:lblOrderNum];
        [cell.contentView addSubview:lblOrderUserContent];
        [cell.contentView addSubview:lblOrderUserNum];
    } else {
        UIImage *image = [ETColor scaleImage:[UIImage imageNamed:@"wait_icon.png"] scaledToSize:CGSizeMake(34, 38)];
        UILabel *lblNoshowContent = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 5.0f, 190.0f, 40.0f)];
        lblNoshowContent.text = NSLocalizedString(@"Index_NoshowOrder", @"");
        lblNoshowNum = [[UILabel alloc] initWithFrame:CGRectMake(210.0f, 5.0f, 190.0f, 40.0f)];
        [lblNoshowNum setTextColor:[ETColor colorWithHexString:@"#fa5d0e"]];
        //lblNoshowNum.text = @"200";
        UILabel *lblNoshowUserContent = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 30.0f, 190.0f, 40.0f)];
        lblNoshowUserContent.text = NSLocalizedString(@"Index_NoshowGuest", @"");
        lblNoshowUserNum = [[UILabel alloc] initWithFrame:CGRectMake(210.0f, 30.0f, 190.0f, 40.0f)];
        [lblNoshowUserNum setTextColor:[ETColor colorWithHexString:@"#fa5d0e"]];
        //lblNoshowUserNum.text = @"500";
        cell.imageView.image = image;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goNoshowOrders)];
        [cell addGestureRecognizer:tapGesture];
        
        [cell.contentView addSubview:lblNoshowContent];
        [cell.contentView addSubview:lblNoshowUserContent];
        [cell.contentView addSubview:lblNoshowNum];
        [cell.contentView addSubview:lblNoshowUserNum];
    }
    
    if(orderOverview != nil)
    {
        if(row == 0) {
            lblOrderNum.text = [NSString stringWithFormat:@"%@",[orderOverview valueForKey:@"ordercount"]];
            lblOrderUserNum.text = [NSString stringWithFormat:@"%@",[orderOverview valueForKey:@"guestcount"] ];
        } else {
            lblNoshowNum.text = [NSString stringWithFormat:@"%@",[orderOverview valueForKey:@"noshow_ordercount"]];
            lblNoshowUserNum.text = [NSString stringWithFormat:@"%@",[orderOverview valueForKey:@"noshow_guestcount"]];
        }
    }
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(void) bindOrderInfo
{
    ETOrderInfo *order = [ETOrderInfo alloc];
    [order init];
    orderOverview = [order getOrderOverviewByDate:currentDate];
    [tbvIndex reloadData];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	_reloading = YES;
    [self bindOrderInfo];
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView etRefreshScrollViewDataSourceDidFinishedLoading:tbvIndex];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView etRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView etRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark ETRefreshTableHeaderDelegate Methods

- (void)etRefreshTableHeaderDidTriggerRefresh:(ETRefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)etRefreshTableHeaderDataSourceIsLoading:(ETRefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)etRefreshTableHeaderDataSourceLastUpdated:(ETRefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
@end
