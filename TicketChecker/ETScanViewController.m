//
//  ETScanViewController.m
//  TicketChecker
//
//  Created by admin on 13-11-4.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETScanViewController.h"
#import "ETColor.h"
#import "ETMineViewController.h"
#import "ETOrderListViewController.h"




@implementation ETScanViewController

@synthesize orderType;

@synthesize label;
//@synthesize readerView;

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
    
    vContent.backgroundColor = [ETColor colorWithHexString:@"2d2d2d"];
    
    @autoreleasepool {
        order = [ETOrderInfo alloc];
        [order init];
        
        UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 100, 30)];
        lblTitle.text = NSLocalizedString(@"Scan_Scan", nil);
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
        
        
        [tabiScan setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        
        [tabiScan setFinishedSelectedImage:[ETColor scaleImage:[UIImage imageNamed:@"code.png"] scaledToSize:CGSizeMake(30, 30)] withFinishedUnselectedImage:[ETColor scaleImage:[UIImage imageNamed:@"code_cur.png"] scaledToSize:CGSizeMake(30, 30)]];
        
        [tabiOrder setImage:[UIImage imageNamed:@"order.png"]];
        [tabiOrder setTitle:NSLocalizedString(@"TabOrder", @"")];
        [tabiScan setImage:[ETColor scaleImage:[UIImage imageNamed:@"code.png"] scaledToSize:CGSizeMake(30, 30)]];
        [tabiScan setTitle:NSLocalizedString(@"TabCheckIn", @"")];
        [tabiMine setImage:[ETColor scaleImage:[UIImage imageNamed:@"user.png"] scaledToSize:CGSizeMake(30, 30)]];
        [tabiMine setTitle:NSLocalizedString(@"TabMine", @"")];
        
        [tabbFooter setBackgroundImage:[ETColor scaleImage:[UIImage imageNamed:@"tab_bar.jpg"] scaledToSize:CGSizeMake(320, 50)]];
        float contentHeight = self.view.frame.size.height - 62;
        [vContent setFrame:CGRectMake(0, 62, 320, contentHeight)];
        float y = vContent.frame.size.height - 49;
        [tabbFooter setFrame:CGRectMake(0, y, 320, 49)];
        NSArray *itemArray = [[NSArray alloc] initWithObjects:tabiOrder
                              , tabiScan, tabiMine, nil];
        [tabbFooter setItems:itemArray];
        [vContent addSubview:tabbFooter];
        
        txtOrderCode.placeholder = NSLocalizedString(@"Scan_OrderCode", nil);
        
        [btnScan setTitle:NSLocalizedString(@"Scan_Scan",@"")forState:UIControlStateNormal];
        /*
        const char *queueName = [[[NSDate date] description] UTF8String];
        dispatch_queue_t myQueue = dispatch_queue_create(queueName, NULL);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(myQueue, ^{
            dispatch_async(mainQueue, ^{
                
            });
        });
         */
        readerView = [ZBarReaderView new];
        
        readerView.frame = CGRectMake(67, 141, 186, 186);
        readerView.readerDelegate = self;
        readerView.allowsPinchZoom = NO;
        readerView.torchMode = 0;
        
         [vContent addSubview:readerView];
        
        if(TARGET_IPHONE_SIMULATOR) {
            cameraSim = [[ZBarCameraSimulator alloc] initWithViewController:self];
            cameraSim.readerView = readerView;
        }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    txtOrderCode.text = @"";
    if(readerView == nil)
    {
        @autoreleasepool {
            readerView = [ZBarReaderView new];
        }
        readerView.frame = CGRectMake(67, 141, 186, 186);
        readerView.readerDelegate = self;
        readerView.allowsPinchZoom = NO;
        readerView.torchMode = 0;
    }
    [readerView start];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self dismiss];
    if(readerView != nil)
    {
        [readerView stop];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
/*
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [readerView flushCache];
    if(readerView != nil)
    {
        [readerView stop];
    }
    cameraSim = nil;
    readerView = nil;
}
 */

-(void)viewDidLayoutSubviews
{
    float contentHeight = self.view.frame.size.height - 62;
    [vContent setFrame:CGRectMake(0, 62, 320, contentHeight)];
    float y = vContent.frame.size.height - 49;
    [tabbFooter setFrame:CGRectMake(0, y, 320, 49)];
    
    float height = vContent.frame.size.height/7;
    [readerView setFrame:CGRectMake(67, height, 186, 186)];
    [txtOrderCode setFrame:CGRectMake(30, height+186+50, 260, 30)];
    
    [tabbFooter setSelectedItem:tabiScan];
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x;
    y = rect.origin.y;
    width = rect.size.width;
    height = rect.size.height/2;
    
    return CGRectMake(x, y, width, height);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

-(void)resumeView
{
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    float tt =vContent.frame.size.height;
    float th =vContent.frame.size.height - txtOrderCode.frame.origin.y - txtOrderCode.frame.size.height - height;
    [self moveView:(th)];
}
-(void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [self moveView:(-vContent.frame.size.height + txtOrderCode.frame.origin.y + txtOrderCode.frame.size.height + height)];
}



-(void)hideKeyboard
{
    [txtOrderCode resignFirstResponder];
    [self resumeView];
}
-(void)moveView:(float)move
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = vContent.frame;
    frame.origin.y += move;
    vContent.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    vContent.frame = frame;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol *symbol;
    for(symbol in symbols) {
        break;
    }
    if(symbol != nil)
    {
        if([txtOrderCode.text isEqualToString:symbol.data])
        {
            return;
        }
        txtOrderCode.text = symbol.data;
        NSString *voucherUrl = symbol.data;
        NSString *orderCode;
        if(voucherUrl.length<16) {
            orderCode = voucherUrl;
        } else {
            NSError *error;
            NSString *regulaStr = @"http[s]?://.*/voucher/([a-zA-Z0-9]+).*$";
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
            
            NSTextCheckingResult *match = [regex firstMatchInString:voucherUrl options:0 range:NSMakeRange(0, [voucherUrl length])];
            if(match)
            {
                orderCode = [voucherUrl substringWithRange:[match rangeAtIndex:1]];
                //orderCode = [voucherUrl substringFromIndex:voucherUrl.length - 15];
            }
        }
        [self checkOrderCode:orderCode];
    }
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation != UIInterfaceOrientationMaskPortraitUpsideDown);
}


- (IBAction)txtOrderCodeChanged:(id)sender {
    if([txtOrderCode.text length]>=15) {
        [self checkOrderCode:txtOrderCode.text];
    }
}

-(void)checkOrderCode:(NSString *)orderCode
{
    BOOL isAlert = NO;
    NSString *message = NSLocalizedString(@"Scan_ErrorMessage", nil);
    if([orderCode length] == 15)
    {
        _orderCode = orderCode;
        txtOrderCode.text = orderCode;
        
        if(![self isNetworkConnected])
        {
            return;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if(order == nil)
        {
            order = [ETOrderInfo alloc];
            [order init];
        }
        order = [order getVendorOrderDetailByCode:orderCode];
        if(order == nil || (NSNull *)order == [NSNull null])
        {
            isAlert = YES;
        }
        else if(![order.bookingDate isEqualToString:[formatter stringFromDate:[NSDate date]]])
        {
            isAlert = YES;
            message = [NSString stringWithFormat:NSLocalizedString(@"Scan_ErrorMessageOut", nil), order.bookingDate];
        }
        else
        {
            [self show];
            [self performSegueWithIdentifier:@"orderDetail" sender:self];
        }
    }
    else
    {
        isAlert = YES;
    }
    if(isAlert)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Scan_ErrorTitle", nil) message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Confirm", nil) otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    //resultText.text = symbol.data;
    
    //imgQrcode.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //lblResult.text = symbol.data;
    // EXAMPLE: do something useful with the barcode image
    /*resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    */
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    
    
    if([symbol.data length] == 15)
    {
        txtOrderCode.text = symbol.data;
        order = [order getVendorOrderDetailByCode:symbol.data];
        if(order == nil)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Scan_ErrorTitle", nil) message:NSLocalizedString(@"Scan_ErrorMessage", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
            //[self performSegueWithIdentifier:@"orderDetail" sender:self];
        }
    }
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
        //[self performSegueWithIdentifier:@"scanPage" sender:self];
    }
    else
    {
        [super gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"minePage"]];
        //[self performSegueWithIdentifier:@"minePage" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(readerView != nil)
    {
        [readerView stop];
    }
    id theSegue = segue.destinationViewController;
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    if([segue.identifier isEqualToString:@"orderListPage"] )
    {
        [theSegue setValue:@"0" forKey:@"orderType"];
        [theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
    else if([segue.identifier isEqualToString:@"minePage"])
    {
        [theSegue setValue:@"0" forKey:@"orderType"];
        //[theSegue setValue:[formatter stringFromDate:[NSDate date]] forKey:@"currentDate"];
    }
    else
     */
    if([segue.identifier isEqualToString:@"orderDetail"])
    {
        [theSegue setValue:_orderCode forKey:@"orderCode"];
    }
}
 

@end
