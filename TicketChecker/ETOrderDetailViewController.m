//
//  ETOrderDetailViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETOrderDetailViewController.h"
#import "ETOrderInfo.h"
#import "ETColor.h"
#import "ETAddFee.h"
#import "ETAddQuestion.h"
#import "ETGuestInfo.h"
#import "ETLabelHelper.h"

@interface ETOrderDetailViewController ()

@end

@implementation ETOrderDetailViewController

@synthesize orderCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self dismiss];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [ETColor colorWithHexString:@"#e1e1e1"];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.orderInfo = [userDefaults objectForKey:@"order"];
    if(self.orderInfo == nil || (NSNull *)self.orderInfo == [NSNull null])
    {
        self.orderInfo = [ETOrderInfo alloc];
        [self.orderInfo init];
        self.orderInfo = [self.orderInfo getVendorOrderDetailByCode:orderCode];
    }
    
    lblOrderStateTitle.text = NSLocalizedString(@"List_State", nil);
    [lblOrderStateTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [lblOrderStateTitle setTextColor:[ETColor colorWithHexString:@"#555555"]];
    
    [lblOrderState setTextColor:[ETColor colorWithHexString:@"#d32525"]];
    if(self.orderInfo.fulfillment == 0)
    {
        lblOrderState.text = NSLocalizedString(@"List_AllShow", nil);
        [lblOrderState setTextColor:[ETColor colorWithHexString:@"#33cc64"]];
    }
    else if(self.orderInfo.fulfillment == 1 || (self.orderInfo.fulfillment == 2 && self.orderInfo.record == 1))
    {
        lblOrderState.text = NSLocalizedString(@"List_NoShow", nil);
    }
    else
    {
        lblOrderState.text = NSLocalizedString(@"List_SomeShow", nil);
    }
    [lblOrderState setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    
    lblOrderCodeTitle.text = NSLocalizedString(@"List_Code", nil);
    [lblOrderCodeTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [lblOrderCodeTitle setTextColor:[ETColor colorWithHexString:@"#555555"]];
    
    lblOrderCode.text = self.orderInfo.orderCode;
    [lblOrderCode setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [lblOrderCode setTextColor:[ETColor colorWithHexString:@"#555555"]];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [btnBack setTitle:NSLocalizedString(@"GoBack", nil) forState:UIControlStateNormal];
    [btnBack setTitleColor:[ETColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnBack setFont:[UIFont fontWithName:@"Heiti SC" size:12.0]];
    [btnBack addTarget:self action:@selector(btnBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
                         
    [btnBack setBackgroundImage:[UIImage imageNamed:@"back_but.png"] forState:UIControlStateNormal];
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 80, 30)];
    lblTitle.text = NSLocalizedString(@"List_Detail", nil);
    [lblTitle setFont:[UIFont fontWithName:@"Heiti SC" size:20.0]];
    [lblTitle setTextColor:[ETColor colorWithHexString:@"#ffffff"]];
    
    [ivHeadBar addSubview:btnBack];
    [ivHeadBar addSubview:lblTitle];
    
    //ivFootBar = [[UIView alloc] initWithFrame:CGRectMake(0, 524, 320, 44)];
    
    btnCheckAll = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 28, 28)];
    [btnCheckAll setTitleColor:[ETColor colorWithHexString:@"#c7c7c7"] forState:UIControlStateNormal];
    [btnCheckAll addTarget:self action:@selector(btnCheckAllClick) forControlEvents:UIControlEventTouchUpInside];
    [btnCheckAll setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"p_nochoose.png"] scaledToSize:CGSizeMake(28, 28)] forState:UIControlStateNormal];
    [btnCheckAll setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"p_choose.png"] scaledToSize:CGSizeMake(28, 28)] forState:UIControlStateSelected];
    btnCheckAll.selected = false;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnCheckAllClick)];
    gesture.numberOfTapsRequired = 1;
    
    UILabel *lblCheckAll = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 50, 32)];
    lblCheckAll.text = [NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"Detail_All", nil),[self.orderInfo.guestArray count]];
    [lblCheckAll setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [lblCheckAll setTextColor:[ETColor colorWithHexString:@"#000000"]];
    
    if(self.orderInfo.allGuestInfoRequired == 0) {
        btnCheckAll.enabled = false;
    }
    else
    {
        [lblCheckAll addGestureRecognizer:gesture];
        [lblCheckAll setUserInteractionEnabled:YES];
    }
    
    btnCheckIn = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 70, 32)];
    [btnCheckIn setTitle:NSLocalizedString(@"Detail_CheckIn", nil) forState:UIControlStateNormal];
    [btnCheckIn setTitleColor:[ETColor colorWithHexString:@"#c7c7c7"] forState:UIControlStateDisabled];
    [btnCheckIn setTitleColor:[ETColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnCheckIn setFont:[UIFont fontWithName:@"Heiti SC" size:12.0]];
    [btnCheckIn addTarget:self action:@selector(btnCheckInClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnCheckIn setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"not_present_nochoose.png"] scaledToSize:CGSizeMake(70, 32)] forState:UIControlStateDisabled];
    [btnCheckIn setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"not_present_choose.png"] scaledToSize:CGSizeMake(70, 32)] forState:UIControlStateNormal];
    btnCheckIn.enabled = false;
    
    btnNoshow = [[UIButton alloc] initWithFrame:CGRectMake(220, 10, 70, 32)];
    [btnNoshow setTitle:NSLocalizedString(@"Detail_NoShow", nil) forState:UIControlStateNormal];
    [btnNoshow setTitleColor:[ETColor colorWithHexString:@"#c7c7c7"] forState:UIControlStateDisabled];
    [btnNoshow setTitleColor:[ETColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnNoshow setFont:[UIFont fontWithName:@"Heiti SC" size:12.0]];
    [btnNoshow addTarget:self action:@selector(btnNoshowClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnNoshow setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"not_present_nochoose.png"] scaledToSize:CGSizeMake(70, 32)] forState:UIControlStateDisabled];
    [btnNoshow setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"not_present_choose.png"] scaledToSize:CGSizeMake(70, 32)] forState:UIControlStateNormal];
    btnNoshow.enabled = false;
    
    [ivFootBar setImage: [ETColor scaleImage:[UIImage imageNamed:@"detail_tab.png"] scaledToSize:CGSizeMake(320, 50)]];
    [ivFootBar addSubview:btnCheckAll];
    [ivFootBar addSubview:lblCheckAll];
    [ivFootBar addSubview:btnCheckIn];
    [ivFootBar addSubview:btnNoshow];
    //[self.view addSubview:ivFootBar];
    
    self.guestButtonArray = [[NSMutableArray alloc] init];
    self.guestLabelArray = [[NSMutableArray alloc] init];
    self.guestCheckArray = [[NSMutableArray alloc] init];
    
    if(self.orderInfo.allGuestInfoRequired == 0)
    {
        btnCheckIn.enabled = true;
        btnNoshow.enabled = true;
    }
}

-(void)viewDidLayoutSubviews
{
    float height = self.view.frame.size.height - 174;
    [tbvOrderDetail setFrame:CGRectMake(tbvOrderDetail.frame.origin.x,
                                      tbvOrderDetail.frame.origin.y,
                                      tbvOrderDetail.frame.size.width,
                                      height)];
    [ivFootBar setFrame:CGRectMake(0, self.view.frame.size.height - 49, 320, 49)];
}

-(void)btnCheckAllClick//:(UIButton *)btn
{
    if(btnCheckAll == nil) {
        return;
    }
    btnCheckAll.selected = !btnCheckAll.selected;
    for(int i=0;i<[self.orderInfo.guestArray count];i++)
    {
        self.guestCheckArray[i] = btnCheckAll.selected?@"0":@"1";;
        if(i<[self.guestButtonArray count])
        {
            UIButton *chk = [self.guestButtonArray objectAtIndex:i];
            chk.selected = btnCheckAll.selected;
        }
    }
    /*
    for(UIButton *chk in self.guestButtonArray)
    {
        chk.selected = btnCheckAll.selected;
        self.guestCheckArray[chk.tag] = chk.selected?@"0":@"1";
    }
     */
    [self redrawGuestButton];
    /*
    if(btn.selected)
    {
        btnCheckIn.enabled = true;
        btnNoshow.enabled = true;
    }
    else
    {
        btnCheckIn.enabled = false;
        btnNoshow.enabled = false;
    }
     */
}
-(void)btnCheckInClick:(UIButton *)btn
{
    [self checkGuestByAction:@"check_in"];
}
-(void)btnNoshowClick:(UIButton *)btn
{
    [self checkGuestByAction:@"no_show"];
}
-(void)checkGuestByAction:(NSString *)action
{
    if(![self isNetworkConnected])
    {
        return;
    }
    NSString *guestStates = @"";
    if(btnCheckAll.selected == true)
    {
        for(ETGuestInfo *guest in self.orderInfo.guestArray)
        {
            if([action isEqualToString:@"check_in"])
            {
                guest.fulfillmentStatus = 0;
            }
            else
            {
                guest.fulfillmentStatus = 1;
            }
            guestStates = [guestStates stringByAppendingString:@"0"];
            guestStates = [guestStates stringByAppendingString:@","];
        }
    }
    else
    {
        if(self.guestButtonArray != nil &&
           [self.guestButtonArray count]>0)
        {
            for(UIButton *chk in self.guestButtonArray)
            {
                if(chk.selected == YES)
                {
                    guestStates = [guestStates stringByAppendingString:@"0"];
                    guestStates = [guestStates stringByAppendingString:@","];
                }
                else
                {
                    guestStates = [guestStates stringByAppendingString:@"1"];
                    guestStates = [guestStates stringByAppendingString:@","];
                }
            }
        }
    }
    BOOL result = [self.orderInfo recordGuestInAction:action ByOrderCode:self.orderInfo.orderCode BySnapshotCode:self.orderInfo.code WithGuestStates:guestStates];
    if(result == false) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Detail_ErrorTitle", nil) message:NSLocalizedString(@"Detail_ErrorMessage", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Confirm", nil) otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else
    {
        [self redrawGuestLabelForState:([action isEqualToString: @"check_in"]?0:1)];
    }
}
-(void)btnBackButtonClick
{
    [self dismissModalViewControllerAnimated:YES];
    //[self performSegueWithIdentifier:@"indexPage" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 6;
    }
    else if(section == 1)
    {
        return 3;
    }
    else if(section == 2 && self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] > 0)
    {
        return [self.orderInfo.feeArray count];
    }
    else if((section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) ||
            (section ==3 &&(self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] >0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0))
    {
        return [self.orderInfo.questionArray count];
    }
    else if((section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0)) ||
            (section == 3 && ((self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) || (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0))) ||
            (section ==4 && (self.orderInfo.feeArray != nil || [self.orderInfo.feeArray count] >0) && (self.orderInfo.questionArray != nil || [self.orderInfo.questionArray count] >0) && self.orderInfo.guestCount > 0))
    {
        return [self.orderInfo.guestArray count];//[(NSNumber *)self.orderInfo.guestCount integerValue];
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionCount = 3;
    if(self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] > 0)
    {
        sectionCount++;
    }
    if(self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0)
    {
        sectionCount++;
    }
    return sectionCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    if(section == 0)
    {
        if(indexPath.row == 0)
        {
            UILabel *lblActivity = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.activityName WithFontSize:14.0 WithFontName:nil WithAlignment:0];
            return MAX(lblActivity.frame.size.height, 52);
        } else if(indexPath.row == 1)
        {
            UILabel *lblOption = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.optionName WithFontSize:14.0 WithFontName:nil WithAlignment:0];
            return MAX(lblOption.frame.size.height, 52);
        }
        return 42;
    }
    else if(section == 1)
    {
        UILabel *lblContactorName = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:([NSLocalizedString(@"language", nil) isEqualToString:@"en-US"]?[NSString stringWithFormat:@"%@.%@",self.orderInfo.contactorFirstName,self.orderInfo.contactorLastName]:[NSString stringWithFormat:@"%@%@",self.orderInfo.contactorLastName, self.orderInfo.contactorFirstName]) WithFontSize:14.0 WithFontName:nil WithAlignment:0];
        return MAX(lblContactorName.frame.size.height, 42);
    }
    else if(section == 2 && self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] > 0)
    {
        ETAddFee *addFee=self.orderInfo.feeArray[indexPath.row];
        
        UILabel *lblAddFeeTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:addFee.feeName WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
        UILabel *lblAddFee = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:[NSString stringWithFormat:@"%@",addFee.feePrice] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
        return MAX(MAX(lblAddFeeTitle.frame.size.height, lblAddFee.frame.size.height)+20, 42.0f);
    }
    else if((section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) ||
            (section ==3 &&(self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] >0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) )
    {
        ETAddQuestion *addQuestion = self.orderInfo.questionArray[indexPath.row];
        
        UILabel *lblAddFeeTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:addQuestion.questionName WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
        UILabel *lblAddFee = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:[NSString stringWithFormat:@"%@",addQuestion.questionAnswer] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
        return MAX(MAX(lblAddFeeTitle.frame.size.height, lblAddFee.frame.size.height )+20, 42.0f);
    }
    else if((section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0)) ||
            (section == 3 && ((self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) || (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0))) ||
            (section ==4 && (self.orderInfo.feeArray != nil || [self.orderInfo.feeArray count] >0) && (self.orderInfo.questionArray != nil || [self.orderInfo.questionArray count] >0) && self.orderInfo.guestCount > 0))
    {
        int y=5;
        ETGuestInfo *guest = self.orderInfo.guestArray[indexPath.row];
        if(![guest.lastName isEqualToString:@""]) {
            UILabel *lblGuestName = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(45, y, 180, 20) WidhtText:([NSLocalizedString(@"language", nil) isEqualToString:@"en-US"]?[NSString stringWithFormat:@"Lastname:%@ Firstname:%@",guest.lastName,guest.firstName]:[NSString stringWithFormat:@"姓:%@ 名:%@",guest.lastName, guest.firstName])  WithFontSize:14.0 WithFontName:nil WithAlignment:0];
            y+=5;
            y+=MAX(lblGuestName.frame.size.height,30);
            if(guest.phone != nil && ![guest.phone isEqualToString:@""])
            {
                y+=35;
            }
            if(guest.email != nil && ![guest.email isEqualToString:@""])
            {
                UILabel *lblGuestMail = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(100, y, 200, 30) WidhtText:guest.email WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                y+=5;
                y+=MAX(lblGuestMail.frame.size.height,30);
            }
        }
        if(guest.feeArray != nil && [guest.feeArray count] > 0)
        {
            for(ETAddFee *fee in guest.feeArray)
            {
                UILabel *lblFee = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, y, 290, 30) WidhtText:[NSString stringWithFormat:@"%@： %@",fee.feeName,fee.feePrice] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                y+=5;
                y+=MAX(lblFee.frame.size.height,30);
            }
        }
        if(guest.questionArray != nil && [guest.questionArray count] > 0)
        {
            for(ETAddQuestion *question in guest.questionArray)
            {
                UILabel *lblQuestion = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, y, 290, 30) WidhtText:[NSString stringWithFormat:@"%@： %@",question.questionName,question.questionAnswer] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                y+=5;
                y+=MAX(lblQuestion.frame.size.height,30);
            }
        }
        return y+5;
    }
    return 42;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 44;
    }
    return 34;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [NSString stringWithFormat:@"%@%@",@"   ", NSLocalizedString(@"Detail_OrderInfo", nil)];
    }
    else if(section == 1)
    {
        return [NSString stringWithFormat:@"%@%@",@"   ", NSLocalizedString(@"Detail_ContactorInfo", nil)];
    }
    else if(section == 2 && self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] > 0)
    {
        return [NSString stringWithFormat:@"%@%@",@"   ", NSLocalizedString(@"Detail_OtherFee", nil)];
    }
    else if((section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) ||
            (section ==3 &&(self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] >0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) )
    {
        return [NSString stringWithFormat:@"%@%@",@"   ", NSLocalizedString(@"Detail_OrderQuestion", nil)];
    }
    else if((section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0)) ||
            (section == 3 && ((self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) || (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0))) ||
            (section ==4 && (self.orderInfo.feeArray != nil || [self.orderInfo.feeArray count] >0) && (self.orderInfo.questionArray != nil || [self.orderInfo.questionArray count] >0) && self.orderInfo.guestCount > 0))
    {
        return [NSString stringWithFormat:@"%@%@",@"   ", NSLocalizedString(@"Detail_Particpate", nil)];
    }
    return @"";
}

//-(UITableViewCell *)product

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%ld%ld",@"dynamicCell",(long)indexPath.section, (long)indexPath.row];
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
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            UILabel *lblActivityTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_Activity", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
            UILabel *lblActivity = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.activityName WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
            /*
            [lblActivityTitle setText:@"活动："];
            [lblActivityTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblActivityTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblActivity setText:self.orderInfo.activityName];
            [lblActivity setTextColor:[ETColor colorWithHexString:@"#555555"]];
            [lblActivity setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            [cell.contentView addSubview:lblActivityTitle];
            [cell.contentView addSubview:lblActivity];
        } else if(indexPath.row == 1)
        {
            UILabel *lblOptionTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_Option", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
            UILabel *lblOption = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.optionName WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
            /*
            [lblOptionTitle setText:@"方案："];
            [lblOptionTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblOptionTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblOption setText:self.orderInfo.optionName];
            [lblOption setTextColor:[ETColor colorWithHexString:@"#555555"]];
             [lblOption setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            [cell.contentView addSubview:lblOptionTitle];
            [cell.contentView addSubview:lblOption];
        }
        else if(indexPath.row == 2)
        {
            UILabel *lblSalerTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_Saler", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
            UILabel *lblSaler = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.vendorName WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
            /*
            [lblSalerTitle setText:@"卖家："];
            [lblSalerTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblSalerTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblSaler setText:self.orderInfo.vendorName];
            [lblSaler setTextColor:[ETColor colorWithHexString:@"#555555"]];
             [lblSaler setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            [cell.contentView addSubview:lblSalerTitle];
            [cell.contentView addSubview:lblSaler];
        }
        else if(indexPath.row == 3)
        {
            UILabel *lblPriceTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_Price", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
            UILabel *lblPrice = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:[NSString stringWithFormat:@"%@%.2f",self.orderInfo.currency,self.orderInfo.price] WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
            /*
            [lblPriceTitle setText:@"价格："];
            [lblPriceTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblPriceTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblPrice setText:[NSString stringWithFormat:@"%@",self.orderInfo.price]];
            [lblPrice setTextColor:[ETColor colorWithHexString:@"#555555"]];
             [lblPrice setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            [cell.contentView addSubview:lblPriceTitle];
            [cell.contentView addSubview:lblPrice];
        }
        else if(indexPath.row == 4)
        {
            UILabel *lblGuestCountTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_GuestNum", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
            UILabel *lblGuestCount = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:[NSString stringWithFormat:@"%@",self.orderInfo.guestCount] WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
            /*
            [lblGuestCountTitle setText:@"人数："];
            [lblGuestCountTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblGuestCountTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblGuestCount setText:[NSString stringWithFormat:@"%@",self.orderInfo.guestCount]];
            [lblGuestCount setTextColor:[ETColor colorWithHexString:@"#555555"]];
            [lblGuestCount setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            
            [cell.contentView addSubview:lblGuestCountTitle];
            [cell.contentView addSubview:lblGuestCount];
        }
        else if(indexPath.row == 5)
        {
            UILabel *lblVoucherTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 77, 20) WidhtText:NSLocalizedString(@"Detail_VoucherId", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];
            UILabel *lblVoucher = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:[NSString stringWithFormat:@"%@",self.orderInfo.voucherId] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
            [cell.contentView addSubview:lblVoucherTitle];
            [cell.contentView addSubview:lblVoucher];
        }
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            UILabel *lblContactorNameTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_ContactorName", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
            UILabel *lblContactorName = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.contactorName WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
            /*
            [lblContactorNameTitle setText:@"姓名："];
            [lblContactorNameTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblContactorNameTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblContactorName setText:self.orderInfo.contactorName];
            [lblContactorName setTextColor:[ETColor colorWithHexString:@"#555555"]];
            [lblContactorName setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            [cell.contentView addSubview:lblContactorNameTitle];
            [cell.contentView addSubview:lblContactorName];
        }
        else if(indexPath.row == 1)
        {
            UILabel *lblContactorPhoneTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_ContactorPhone", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 90, 20)];
            UILabel *lblContactorPhone = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.contactorPhone WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 90, 20)];
            /*
            [lblContactorPhoneTitle setText:@"手机："];
            [lblContactorPhoneTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblContactorPhoneTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblContactorPhone setText:self.orderInfo.contactorPhone];
            [lblContactorPhone setTextColor:[ETColor colorWithHexString:@"#555555"]];
            [lblContactorPhone setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
             */
            [cell.contentView addSubview:lblContactorPhoneTitle];
            [cell.contentView addSubview:lblContactorPhone];
        }
        else if(indexPath.row == 2)
        {
            UILabel *lblContactorMailTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:NSLocalizedString(@"Detail_ContactorMail", nil) WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 90, 20)];
            UILabel *lblContactorMail = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:self.orderInfo.contactorMail WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 90, 20)];
            /*
            [lblContactorMailTitle setText:@"邮箱："];
            [lblContactorMailTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
            [lblContactorMailTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            [lblContactorMail setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
            
            [lblContactorMail setTextColor:[ETColor colorWithHexString:@"#555555"]];
            
            [lblContactorMail setText:self.orderInfo.contactorMail];
             */
            [cell.contentView addSubview:lblContactorMailTitle];
            [cell.contentView addSubview:lblContactorMail];
        }
    }
    else if(indexPath.section == 2 && self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] > 0)
    {
        ETAddFee *addFee=self.orderInfo.feeArray[indexPath.row];
        
        UILabel *lblAddFeeTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:addFee.feeName WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
        UILabel *lblAddFee = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:[NSString stringWithFormat:@"%@",addFee.feePrice] WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
        /*
        [lblAddFeeTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
        [lblAddFeeTitle setText:addFee.feeName];
        
        [lblAddFeeTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
        [lblAddFee setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
        
        [lblAddFee setTextColor:[ETColor colorWithHexString:@"#555555"]];
        
        [lblAddFee setText:[NSString stringWithFormat:@"%@%@",self.orderInfo.currency,addFee.feePrice]];
        */
        [cell.contentView addSubview:lblAddFeeTitle];
        [cell.contentView addSubview:lblAddFee];
    }
    else if((indexPath.section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) ||
            (indexPath.section ==3 &&(self.orderInfo.feeArray != nil && [self.orderInfo.feeArray count] >0) && self.orderInfo.questionArray != nil && [self.orderInfo.questionArray count] >0) )
    {
        ETAddQuestion *addQuestion = self.orderInfo.questionArray[indexPath.row];
        
        UILabel *lblAddQuestionTitle = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, 10, 72, 20) WidhtText:addQuestion.questionName WithFontSize:14.0 WithFontName:nil WithAlignment:1];//[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 20)];
        UILabel *lblAddQuestion = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(90, 10, 208, 20) WidhtText:addQuestion.questionAnswer WithFontSize:14.0 WithFontName:nil WithAlignment:0];//[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
        /*
        [lblAddQuestionTitle setTextColor:[ETColor colorWithHexString:@"#b7afa8"]];
        [lblAddQuestionTitle setText:addQuestion.questionName];
        
        [lblAddQuestionTitle setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
        [lblAddQuestion setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
        
        [lblAddQuestion setTextColor:[ETColor colorWithHexString:@"#555555"]];
        
        [lblAddQuestion setText:[NSString stringWithFormat:@"%@",addQuestion.questionAnswer]];
        */
        [cell.contentView addSubview:lblAddQuestionTitle];
        [cell.contentView addSubview:lblAddQuestion];
    }
    else if((indexPath.section == 2 && (self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) && (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0)) ||
            (indexPath.section == 3 && ((self.orderInfo.feeArray == nil || [self.orderInfo.feeArray count] ==0) || (self.orderInfo.questionArray == nil || [self.orderInfo.questionArray count] ==0))) ||
            (indexPath.section ==4 && (self.orderInfo.feeArray != nil || [self.orderInfo.feeArray count] >0) && (self.orderInfo.questionArray != nil || [self.orderInfo.questionArray count] >0) && self.orderInfo.guestCount > 0))
    {
        int y=5;
        ETGuestInfo *guest = self.orderInfo.guestArray[indexPath.row];
        if(![guest.lastName isEqualToString:@""]) {
            UIButton *btnCheckBox = [[UIButton alloc] initWithFrame:CGRectMake(10, y, 20, 20)];
            UILabel *lblGuestName = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(45, y, 180, 20) WidhtText:guest.name WithFontSize:14.0 WithFontName:nil WithAlignment:0];
            NSString *stateName = @"";
            NSString *stateColor;
            if(guest.fulfillmentStatus == 0)
            {
                //checkedCount++;
                btnCheckBox.selected = true;
                stateName = NSLocalizedString(@"Detail_CheckIn", nil);
                stateColor = @"#33cc64";
            }
            else
            {
                btnCheckBox.selected = false;
                stateName = NSLocalizedString(@"Detail_NoShow", nil);
                stateColor = @"#d42424";
            }
            
            UILabel *lblStateName = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:stateColor] WithFrame:CGRectMake(200, y, 95, 20) WidhtText:stateName WithFontSize:14.0 WithFontName:nil WithAlignment:1];
            
            y+=5;
            y+=MAX(lblGuestName.frame.size.height,30);
            if(guest.phone != nil && ![guest.phone isEqualToString:@""])
            {
                UILabel *lblGuestPhone = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(45, y, 200, 30) WidhtText:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Detail_GuestPhone", nil),guest.phone] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                [cell.contentView addSubview:lblGuestPhone];
                y+=35;
            }
            if(guest.email != nil && ![guest.email isEqualToString:@""])
            {
                UILabel *lblGuestMail = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(45, y, 200, 30) WidhtText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Detail_ContactorMail", nil), guest.email] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                [cell.contentView addSubview:lblGuestMail];
                y+=5;
                y+=MAX(lblGuestMail.frame.size.height,30);
            }
            
            [btnCheckBox setImage:[ETColor scaleImage:[UIImage imageNamed:@"p_nochoose.png"] scaledToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
            [btnCheckBox setImage:[ETColor scaleImage:[UIImage imageNamed:@"p_choose.png"] scaledToSize:CGSizeMake(20, 20)] forState:UIControlStateSelected];
            [btnCheckBox addTarget:self action:@selector(btnCheckBoxClick:) forControlEvents:UIControlEventTouchUpInside];
            btnCheckBox.tag = indexPath.row;
            
            
            if(indexPath.row < [self.guestButtonArray count])
            {
                self.guestButtonArray[indexPath.row] = btnCheckBox;
            }
            else
            {
                [self.guestButtonArray addObject:btnCheckBox];
            }
            if(indexPath.row < [self.guestLabelArray count])
            {
                self.guestLabelArray[indexPath.row] = lblStateName;
            }
            else
            {
                [self.guestLabelArray addObject:lblStateName];
            }
            
            if(btnCheckAll.selected == true)
            {
                btnCheckBox.selected = true;
            }
            if(indexPath.row >= [self.guestCheckArray count])
            {
                [self.guestCheckArray addObject:[NSString stringWithFormat:@"%d",btnCheckAll.selected == true?0:guest.fulfillmentStatus ]];
            }
            else
            {
                if([[self.guestCheckArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
                {
                    btnCheckBox.selected = true;
                }
                else
                {
                    btnCheckBox.selected = false;
                }
            }
            
            [self redrawGuestButton];
            
            [cell.contentView addSubview:btnCheckBox];
            [cell.contentView addSubview:lblGuestName];
            [cell.contentView addSubview:lblStateName];
        }
        if(guest.feeArray != nil && [guest.feeArray count] > 0)
        {
            for(ETAddFee *fee in guest.feeArray)
            {
                UILabel *lblFee = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, y, 290, 30) WidhtText:[NSString stringWithFormat:@"%@： %@",fee.feeName,fee.feePrice] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                [cell.contentView addSubview:lblFee];
                y+=5;
                y+=MAX(lblFee.frame.size.height,30);
            }
        }
        if(guest.questionArray != nil && [guest.questionArray count] > 0)
        {
            for(ETAddQuestion *question in guest.questionArray)
            {
                UILabel *lblQuestion = [ETLabelHelper getAutoSizeLabelWithColor:[ETColor colorWithHexString:@"#555555"] WithFrame:CGRectMake(10, y, 290, 30) WidhtText:[NSString stringWithFormat:@"%@： %@",question.questionName,question.questionAnswer] WithFontSize:14.0 WithFontName:nil WithAlignment:0];
                [cell.contentView addSubview:lblQuestion];
                y+=5;
                y+=MAX(lblQuestion.frame.size.height,30);
            }
        }
    }
    
    return cell;
}
-(void)btnCheckBoxClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.guestCheckArray[btn.tag] = btn.selected?@"0":@"1";
    [self redrawGuestButton];
    
}
-(void)redrawGuestButton
{
    btnCheckIn.enabled = false;
    btnNoshow.enabled = false;
    int selectCount = 0;
    int i = 0;
    BOOL allCheckState = btnCheckAll.selected;
    for(NSString *state in self.guestCheckArray)
    {
        if(i == 0) {
            allCheckState = [state isEqualToString:@"0"];
        }
        else
        {
            allCheckState = allCheckState && [state isEqualToString:@"0"];
        }
        if([state isEqualToString:@"0"])
        {
            btnCheckIn.enabled = true;
            btnNoshow.enabled = true;
            selectCount++;
        }
        i++;
    }
    /*
    for(UIButton *chk in self.guestButtonArray)
    {
        if(i == 0) {
            allCheckState = chk.selected;
        }
        else
        {
            allCheckState = allCheckState && chk.selected;
        }
        if(chk.selected == true)
        {
            btnCheckIn.enabled = true;
            btnNoshow.enabled = true;
            selectCount++;
        }
        i++;
    }
     */
    if(btnCheckAll.selected)
    {
    btnCheckAll.selected = allCheckState;// && [self.guestButtonArray count] == [self.orderInfo.guestArray count]);
    }
    else
    {
        btnCheckAll.selected = (allCheckState && [self.guestButtonArray count] == [self.orderInfo.guestArray count]);
    }
    if(btnCheckAll.selected == true) {
        selectCount = [(NSNumber *)self.orderInfo.guestCount intValue];
        btnCheckIn.enabled = true;
        btnNoshow.enabled = true;
    }
    if(selectCount > 0) {
        [btnCheckIn setTitle:[NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"Detail_CheckIn", nil),selectCount] forState:UIControlStateNormal];
        [btnNoshow setTitle:[NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"Detail_NoShow", nil),selectCount] forState:UIControlStateNormal];
    }
    else {
        [btnCheckIn setTitle:NSLocalizedString(@"Detail_CheckIn", nil) forState:UIControlStateNormal];
        [btnNoshow setTitle:NSLocalizedString(@"Detail_NoShow", nil) forState:UIControlStateNormal];
    }
}
-(void)redrawGuestLabelForState:(int)state
{
    if(self.orderInfo.allGuestInfoRequired == 0)
    {
        lblOrderState.text = (state == 0 ?NSLocalizedString(@"List_AllShow", nil):NSLocalizedString(@"List_NoShow", nil));
        return;
    }
    int i = 0;
    int allFulfill = -1;
    for (i=0; i<[self.guestLabelArray count]; i++) {
        UIButton *btn = [self.guestButtonArray objectAtIndex:i];
        UILabel *lbl = [self.guestLabelArray objectAtIndex:i];
        ETGuestInfo *guest = [self.orderInfo.guestArray objectAtIndex:i];
        
        if(btn == nil || btn.selected != true)
        {
            continue;
        }
        if(state == 0)
        {
            if(guest != nil)
            {
                guest.fulfillmentStatus = 0;
            }
            [lbl setText:NSLocalizedString(@"Detail_CheckIn", nil)];
            [lbl setTextColor:[ETColor colorWithHexString:@"#33cc64"]];
        }
        else
        {
            if(guest != nil)
            {
                guest.fulfillmentStatus = 1;
            }
            
            [lbl setText:NSLocalizedString(@"Detail_NoShow", nil)];
            [lbl setTextColor:[ETColor colorWithHexString:@"#d42424"]];
        }
        if(lbl.frame.origin.x + lbl.frame.size.width+30 > 320)
        {
            lbl.textAlignment = NSTextAlignmentRight;
            [lbl setFrame:CGRectMake(lbl.frame.origin.x-30, lbl.frame.origin.y, lbl.frame.size.width+30, lbl.frame.size.height)];
        }
        else
        {
            lbl.textAlignment = NSTextAlignmentRight;
            [lbl setFrame:CGRectMake(lbl.frame.origin.x, lbl.frame.origin.y, lbl.frame.size.width+30, lbl.frame.size.height)];
        }
    }
    for (i=0; i<[self.orderInfo.guestArray count]; i++) {
        ETGuestInfo *guest = [self.orderInfo.guestArray objectAtIndex:i];
        if(guest.fulfillmentStatus == 0)
        {
            allFulfill = (allFulfill == -1 || allFulfill == 0?0:2);
        }
        else if(guest.fulfillmentStatus == 1)
        {
            allFulfill = (allFulfill == -1 || allFulfill == 1?1:2);
        }
    }
    [lblOrderState setTextColor:[ETColor colorWithHexString:@"d42424"]];
    if(allFulfill == 0)
    {
        [lblOrderState setTextColor:[ETColor colorWithHexString:@"33cc64"]];
        lblOrderState.text = NSLocalizedString(@"List_AllShow", nil);
    }
    else if(allFulfill == 1)
    {
        lblOrderState.text = NSLocalizedString(@"List_NoShow", nil);
    }
    else
    {
        lblOrderState.text = NSLocalizedString(@"List_SomeShow", nil);
    }
}
@end
