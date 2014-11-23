//
//  ETOrderListViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETOrderListViewController.h"
#import "ETColor.h"
#import "ETOrderInfo.h"
#import "ETLabelHelper.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@interface ETOrderListViewController ()

@end

@implementation ETOrderListViewController

@synthesize orderType;
@synthesize currentDate;
@synthesize currentTitle;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentPage = 1;
    self.pageSize = 10;
    self.orderType = [self GetObjectByKey:@"orderType"];
    self.currentDate = [self GetObjectByKey:@"currentDate"];
    
    UINavigationItem *back = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"Mine_Mine", <#comment#>)];
    //back.backBarButtonItem.title = NSLocalizedString(@"GoBack", @"");
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(goBack)];
    //nviMine.leftBarButtonItem = leftButton;
    back.leftBarButtonItem = leftButton;
    [nvOrderList pushNavigationItem:back animated:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //tbiOrderList.image = [ETColor scaleImage:[UIImage imageNamed:@"order.png"] scaledToSize:CGSizeMake(40, 40)];
    
    
    
    [self.view setBackgroundColor:[ETColor colorWithHexString:@"#e1e1e1"]];
    
    [self bindOrderListInfo:self.currentPage IsAppend:NO];
    
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [btnBack setTitle:NSLocalizedString(@"GoBack", nil) forState:UIControlStateNormal];
    [btnBack setTitleColor:[ETColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnBack setFont:[UIFont fontWithName:@"Heiti SC" size:12.0]];
    [btnBack addTarget:self action:@selector(btnBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnBack setBackgroundImage:[UIImage imageNamed:@"back_but.png"] forState:UIControlStateNormal];
    NSString *title = @"";
    if([orderType isEqualToString: @"0"])
    {
        title = NSLocalizedString(@"List_TodayOrder", nil);
    }
    else
    {
        title = NSLocalizedString(@"List_NoshowOrder", nil);
    }
    
    //UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 130, 30)];
    //lblTitle.text = currentTitle;
    //[lblTitle setFont:[UIFont fontWithName:@"Heiti SC" size:20.0]];
    //[lblTitle setTextColor:[ETColor colorWithHexString:@"#ffffff"]];
    UILabel *lblTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#ffffff"] WithFrame:CGRectMake(120, 10, 200, 30) WidhtText:title WithFontSize:20.0 WithFontName:@"Heiti SC" WithAlignment:2];
    
    
    tabbFooter = [[UITabBar alloc] init];
    tabiOrder = [[UITabBarItem alloc]init];
    tabiScan = [[UITabBarItem alloc]init];
    tabiMine = [[UITabBarItem alloc]init];
    
    tabbFooter.delegate = self;
    
    tabiOrder.tag = 0;
    tabiScan.tag = 1;
    tabiMine.tag = 2;
    [tabiOrder setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    [tabiOrder setFinishedSelectedImage:[UIImage imageNamed:@"order.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"order_cur.png"]];
    [tabiOrder setImage:[UIImage imageNamed:@"order_cur.png"]];
    [tabiOrder setTitle:NSLocalizedString(@"TabOrder", @"")];
    [tabiScan setImage:[ETColor scaleImage:[UIImage imageNamed:@"code.png"] scaledToSize:CGSizeMake(30, 30)]];
    [tabiScan setTitle:NSLocalizedString(@"TabCheckIn", @"")];
    [tabiMine setImage:[ETColor scaleImage:[UIImage imageNamed:@"user.png"] scaledToSize:CGSizeMake(30, 30)]];
    [tabiMine setTitle:NSLocalizedString(@"TabMine", @"")];
    
    [tabbFooter setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"tab_bar.jpg"] scaledToSize:CGSizeMake(320, 50)]];
    float y = self.view.frame.size.height - 49;
    [tabbFooter setFrame:CGRectMake(0, y, 320, 49)];
    NSArray *itemArray = [[NSArray alloc] initWithObjects:tabiOrder
                          , tabiScan, tabiMine, nil];
    [tabbFooter setItems:itemArray];
    [self.view addSubview:tabbFooter];
    
    [ivHeadBar addSubview:btnBack];
    [ivHeadBar addSubview:lblTitle];
    
    tbvOrderList.backgroundColor = [ETColor colorWithHexString:@"#e1e1e1"];
    //tbvOrderList.layer.cornerRadius = 6;
    //tbvOrderList.layer.masksToBounds = YES;
    
    if (_refreshHeaderView == nil) {
        ETRefreshTableHeaderView * view = [[ETRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-tbvOrderList.bounds.size.height, tbvOrderList.frame.size.width, tbvOrderList.bounds.size.height-10)];
        view.delegate = self;
        
        [tbvOrderList addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}


-(void)viewDidLayoutSubviews
{
    float height = self.view.frame.size.height - 111;
    [tbvOrderList setFrame:CGRectMake(tbvOrderList.frame.origin.x,
                                      tbvOrderList.frame.origin.y,
                                      tbvOrderList.frame.size.width,
                                      height)];
    
    
    [tabbFooter setSelectedItem:tabiOrder];
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 0)
    {
        //[self performSegueWithIdentifier:@"orderListPage" sender:self];
    }
    else if(item.tag == 1)
    {
        [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"scanPage"]];
        //[self performSegueWithIdentifier:@"scanPage" sender:self];
    }
    else
    {
        [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"minePage"]];
        //[self performSegueWithIdentifier:@"minePage" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.orderCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [ETColor colorWithHexString:@"#e1e1e1"];
    
    return myView;
}
-(void)btnBackButtonClick
{
    [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"indexPage"]];
    //[self performSegueWithIdentifier:@"indexPage" sender:self];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [ETColor colorWithHexString:@"#e1e1e1"];
    
    return myView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 42;
    }
    else if(indexPath.row == 1)
    {
        return 90;
        /*
        ETOrderInfo *order = [self.orderList objectAtIndex:indexPath.section];
        NSString *text = order.activityName;
        CGSize constraint = CGSizeMake(200, 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Heiti SC" size:14]];
        CGFloat height = MAX(size.height, 20.0f);
        return height+60;
        */
    }
    else
    {
        return 58;
    }
}
-(void)showDetail:(id)sender
{
    if(![self isNetworkConnected])
    {
        return;
    }
    int index = [sender tag];
    self.orderCode = [[self.orderList objectAtIndex:index] orderCode];
    [self show];
    [self performSegueWithIdentifier:@"orderDetail" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ETOrderListViewController *ctrl = sender;
    id theSegue = segue.destinationViewController;
    
    if([segue.identifier isEqualToString:@"orderDetail"])
    {
        [theSegue setValue:ctrl.orderCode forKey:@"orderCode"];
    }
    else if([segue.identifier isEqualToString:@"minePage"])
    {
        [theSegue setValue:orderType forKey:@"orderType"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section >= [self.orderList count]-4 && [self.orderList count] < self.orderCount)
    {
        /*
        if(progress == nil)
        {
            
            progress = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(90, 300, 100, 100)];
            [progress setColor:[UIColor blackColor]];
            [self.view addSubview:progress];
        }
        [progress startAnimating];
         */
        [super show];
    }
    if(indexPath.section < [self.orderList count]-4)
    {
        [super dismiss];
        /*
        if(progress != nil)
        {
            [progress stopAnimating];
        }
         */
    }
    if(indexPath.section >= [self.orderList count] && [self.orderList count] < self.orderCount)
    {
        if(self.currentPage < self.pageCount)
        {
            self.currentPage++;
        }
        
        [self bindOrderListInfo:self.currentPage IsAppend:YES];
        if([self.orderList count] == indexPath.section+1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"List_NoDataTitle", nil) message:NSLocalizedString(@"List_NoDataMessage", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Confirm", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        [super dismiss];
        /*
        if(progress != nil)
        {
            [progress stopAnimating];
        }
         */
    }
    if(indexPath.section>=[self.orderList count])
    {
        return nil;
    }
    ETOrderInfo *order = [self.orderList objectAtIndex:indexPath.section];
    static NSString *CellIdentifier = @"dynamicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        while([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if(indexPath.row == 0)
    {
        UILabel *lblOrderStateTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 20)];
        UILabel *lblOrderState = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 160, 20)];
        UIButton *btnOrderDetail = [[UIButton alloc] initWithFrame:CGRectMake(220, 0, 88, 42)];
        [btnOrderDetail setTitle:NSLocalizedString(@"List_Detail", nil) forState:UIControlStateNormal];
        [btnOrderDetail setTitleColor:[ETColor colorWithHexString:@"#ffffff" ] forState:UIControlStateNormal];
        [btnOrderDetail setBackgroundImage:[UIImage imageNamed:@"View_but.png"] forState:UIControlStateNormal];
        [btnOrderDetail setFont:[UIFont fontWithName:@"Heiti SC" size:12.0]];
        
        [btnOrderDetail setTag:indexPath.section];
        [btnOrderDetail addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        [lblOrderStateTitle setText:NSLocalizedString(@"List_State", nil) ];
        [lblOrderStateTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
        [lblOrderStateTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
        [lblOrderState setTextColor:[ETColor colorWithHexString:@"#d32525"]];
        [lblOrderState setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
        
        
        if(order.fulfillment == 0)
        {
            [lblOrderState setText:NSLocalizedString(@"List_AllShow", nil)];
        }
        else if(order.fulfillment == 1 || (order.fulfillment == 2 && order.record == 1))
        {
            [lblOrderState setText:NSLocalizedString(@"List_NoShow", nil)];
        }
        else
        {
            [lblOrderState setText:NSLocalizedString(@"List_SomeShow", nil)];
        }
        [cell.contentView addSubview:lblOrderStateTitle];
        [cell.contentView addSubview:lblOrderState];
        [cell.contentView addSubview:btnOrderDetail];
    }
    else if(indexPath.row == 1)
    {
        UILabel *lblOrderCodeTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#b7afa8"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"List_Code", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];
        UILabel *lblOrderCode = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 228, 20) WidhtText:order.orderCode WithFontSize:14.0 WithFontName:nil WithAlignment:0];
        UILabel *lblOptionNameTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#b7afa8"] WithFrame:CGRectMake(10, 38, 72, 20) WidhtText:NSLocalizedString(@"List_ActivityName", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];
        UILabel *lblOptionName = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 38, 208, 35) WidhtText:order.activityName WithFontSize:14.0 WithFontName:nil WithAlignment:0 WithRow:2];
        int h =lblOptionName.frame.size.height;
        if(lblOptionName.frame.size.height > 14)
        {
            [lblOptionName setFrame:CGRectMake(lblOptionName.frame.origin.x, 23, lblOptionName.frame.size.width, lblOptionName.frame.size.height)];
        }
        UILabel *lblSaleTimeTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#b7afa8"] WithFrame:CGRectMake(10, 65, 72, 20) WidhtText:NSLocalizedString(@"List_SaleDate", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];
        UILabel *lblSaleTime = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 65, 228, 20) WidhtText:((NSNull *)order.saleDate == [NSNull null]?@"":order.saleDate) WithFontSize:14.0 WithFontName:nil WithAlignment:0];
        
        [cell.contentView addSubview:lblOrderCodeTitle];
        [cell.contentView addSubview:lblOrderCode];
        [cell.contentView addSubview:lblOptionNameTitle];
        [cell.contentView addSubview:lblOptionName];
        [cell.contentView addSubview:lblSaleTimeTitle];
        [cell.contentView addSubview:lblSaleTime];
        
    }
    else
    {
        UILabel *lblContactorTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#b7afa8"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"List_Contactor", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];
        UILabel *lblContactor = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 228, 20) WidhtText:order.contactorName WithFontSize:14.0 WithFontName:nil WithAlignment:0 WithRow:1];
        UILabel *lblGuestCountTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#b7afa8"] WithFrame:CGRectMake(10, 30, 72, 20) WidhtText:NSLocalizedString(@"List_GuestCount", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];
        UILabel *lblGuestCount = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 30, 208, 20) WidhtText:[(NSNumber *)order.guestCount stringValue] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
        
        
        [cell.contentView addSubview:lblContactorTitle];
        [cell.contentView addSubview:lblContactor];
        [cell.contentView addSubview:lblGuestCountTitle];
        [cell.contentView addSubview:lblGuestCount];
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(void)goBack
{
    [self dismissModalViewControllerAnimated:YES];
}


-(void) bindOrderListInfo:(int)pageIndex IsAppend:(BOOL)isAppend
{
    if(![super isNetworkConnected])
    {
        return;
    }
    if(currentDate == nil)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        currentDate = [formatter stringFromDate:[NSDate date]];
    }
    ETOrderInfo *order = [ETOrderInfo alloc];
    [order init];
    
    NSArray *addOrderList = [order getVendorOrderListByDate:currentDate State:[(NSNumber *)orderType intValue] Page:pageIndex PageNum:self.pageSize];
    if(addOrderList != nil)
    {
        if(isAppend == NO)
        {
            self.orderList = addOrderList;
        }
        else
        {
            self.orderList = [self.orderList arrayByAddingObjectsFromArray:addOrderList];
        }
    }
    self.orderCount = order.totalCount;
    self.pageCount = order.totalPage;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	_reloading = YES;
    [self bindOrderListInfo:1 IsAppend:NO];
    [tbvOrderList reloadData];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView etRefreshScrollViewDataSourceDidFinishedLoading:tbvOrderList];
	
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
