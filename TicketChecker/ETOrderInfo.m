//
//  ETOrderInfo.m
//  TicketChecker
//
//  Created by admin on 13-11-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETOrderInfo.h"
#import "ASIHTTPRequest.h"
#import "ETAuthorization.h"
#import "ETDictionary.h"
#import "ETAddFee.h"
#import "ETAddQuestion.h"
#import "ETGuestInfo.h"

@implementation ETOrderInfo

-(void)init
{
    [super init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    merchantCode = [userDefaults objectForKey:@"merchant"];
    token = [userDefaults objectForKey:@"token"];
    
    orderListUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders",merchantCode]];
    //orderDetailUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders/",merchantCode]];
    orderOverviewUrl = [apiUrl stringByAppendingString:@"overview"];
    recordGuestInfoUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"appsnapshot/%@/snapshot",merchantCode]];
}


-(ETOrderInfo *)getVendorOrderDetailByCode:(NSString *)orderid
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?lang_code=%@",orderListUrl,orderid, NSLocalizedString(@"language", nil)]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: merchantCode, nil],
                            @"code",
                            [NSArray arrayWithObjects: orderid, nil],
                            @"id",
                            [NSArray arrayWithObjects: NSLocalizedString(@"language", nil), nil],
                            @"lang_code",
                            nil];
    
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/merchant/" WithParams:params WithAuth:@"auth-int"]];
    [request startSynchronous];
    NSError *error = [request error];
    NSData *resData = nil;
    if(!error)
    {
        NSString *response = [request responseString];
        resData = [response dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(resData)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        if(dic == nil || [dic valueForKey:@"error"] != nil)
        {
            return nil;
        }
        
        
        return [self transformToObjectFromDictionary:dic];
    }
    return nil;
}

-(NSArray *)getVendorOrderListByDate:(NSString *)date State:(NSInteger) state Page:(NSInteger)page PageNum:(NSInteger)pageNum
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?book_date=%@&state=%d&lang_code=%@&page=%d&pn=%d",orderListUrl,date, state, NSLocalizedString(@"language", nil), page, pageNum]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: merchantCode, nil],
                            @"code",
                            [NSArray arrayWithObjects:date, nil],
                            @"book_date",
                            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",state], nil],
                            @"state",
                            [NSArray arrayWithObjects: NSLocalizedString(@"language", nil), nil],
                            @"lang_code",
                            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",page], nil],
                            @"page",
                            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",pageNum], nil],
                            @"pn",
                            nil];
    
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/merchant/" WithParams:params WithAuth:@"auth-int"]];
    [request startSynchronous];
    NSError *error = [request error];
    NSData *resData = nil;
    if(!error)
    {
        NSString *response = [request responseString];
        resData = [response dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(resData)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        if(dic == nil || [dic valueForKey:@"error"] != nil)
        {
            return nil;
        }
        NSArray *orderList = [self transformToObjectArrayFromDictionary:dic];
        
        self.totalPage = [(NSNumber *)[dic valueForKey:@"totalPage"] intValue];
        self.totalCount = [(NSNumber *)[dic valueForKey:@"total"]intValue];
        
        return orderList;
    }
    return nil;
}

-(NSDictionary *)getOrderOverviewByDate:(NSString *)date
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?book_date=%@",orderOverviewUrl,merchantCode, date]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: merchantCode, nil],
                            @"id",
                            [NSArray arrayWithObjects:date, nil],
                            @"book_date",
                            nil];
    
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/overview/" WithParams:params WithAuth:@"auth-int"]];
    [request startSynchronous];
    NSError *error = [request error];
    NSData *resData = nil;
    if(!error)
    {
        NSString *response = [request responseString];
        resData = [response dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(resData)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        if(dic == nil || [dic valueForKey:@"error"] != nil)
        {
            return nil;
        }
        
        
        return dic;
    }
    return nil;
}
-(ETOrderInfo *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETOrderInfo *order = [ETOrderInfo alloc];
    [order init];
    order.orderCode = [dic valueForKey:@"OrderCode"];
    order.status =  [(NSNumber *)[dic valueForKey:@"Status"] integerValue];
    order.activityName = [dic valueForKey:@"Activity"];
    order.saleDate = [dic valueForKey:@"SaleDate"];
    order.bookingDate = [dic valueForKey:@"BookingDate"];
    
    order.optionName = [dic valueForKey:@"Option"];
    order.price = [(NSNumber *)[dic valueForKey:@"TotalPrice"] doubleValue];
    order.currency = [dic valueForKey:@"CurrencyCode"];
    order.code = [dic valueForKey:@"SnapShotCode"];
    order.record = [(NSNumber *)[dic valueForKey:@"Record"] intValue];
    if([dic valueForKey:@"AllGuestInfoRequired"] != nil &&
       (NSNull *)[dic valueForKey:@"AllGuestInfoRequired"] != [NSNull null])
    {
        order.allGuestInfoRequired = [(NSNumber *)[dic valueForKey:@"AllGuestInfoRequired"] intValue];
    }
    else
    {
        order.allGuestInfoRequired = 1;
    }
    if([dic valueForKey:@"Fulfillment"] != nil && (NSNull *)[dic valueForKey:@"Fulfillment"] != [NSNull null])
    {
        order.fulfillment = [(NSNumber *)[dic valueForKey:@"Fulfillment"] intValue];
    }
    else
    {
        order.fulfillment = 1;
    }
    if([dic valueForKey:@"Agency"] != nil && (NSNull *)[dic valueForKey:@"Agency"] != [NSNull null])
    {
        order.vendorName = [dic valueForKey:@"Agency"];
    }
    else
    {
        order.vendorName = [dic valueForKey:@"Vendor"];
    }
    
    if([dic valueForKey:@"OfflineAgencyVoucherId"] != nil && (NSNull *)[dic valueForKey:@"OfflineAgencyVoucherId"] != [NSNull null])
    {
        order.voucherId = [dic valueForKey:@"OfflineAgencyVoucherId"];
    }
    else
    {
        order.voucherId = @"No Voucher";
    }
    if([dic valueForKey:@"OfflineAgencyNote"] != nil && (NSNull *)[dic valueForKey:@"OfflineAgencyNote"] != [NSNull null])
    {
        order.voucherNote = [dic valueForKey:@"OfflineAgencyNote"];
    }
    else
    {
        order.voucherNote = NULL;
    }
    
    NSDictionary *contactor =[dic valueForKey:@"contactor"];
    if(contactor != nil)
    {
        //TODO:根据语言版本来确定这地方用中文名称还是英文名称
        order.contactorFirstName = [contactor valueForKey:@"FirstName"];
        order.contactorLastName = [contactor valueForKey:@"LastName"];
        order.contactorPhone = [contactor valueForKey:@"Phone"];
        order.contactorMail = [contactor valueForKey:@"Email"];
        
        if(order.contactorLastName.length > 0){
            if([order.contactorLastName characterAtIndex:0] >= 'A' && [order.contactorLastName characterAtIndex:0] <= 'z')
            {
                order.contactorName = [NSString stringWithFormat:@"%@ %@",order.contactorFirstName,order.contactorLastName];
            }
            else
            {
                order.contactorName = [NSString stringWithFormat:@"%@%@",order.contactorLastName,order.contactorFirstName];
            }
        }
        else{
            order.contactorName = @"";
        }
    }
    NSDictionary *guests = [dic valueForKey:@"guestInfo"];
    if(guests != nil)
    {
        NSMutableArray *guestArray = [[NSMutableArray alloc] init];
    
        for(NSDictionary *dicGuest in guests)
        {
            ETGuestInfo *guest = [[ETGuestInfo alloc] initWithDic:dicGuest];
            if(guest != nil)
            {
                [guestArray addObject:guest];
            }
        }
        if([guestArray count] > 0)
        {
            order.guestArray = guestArray;
        }
    }
    NSDictionary *fees = [dic valueForKey:@"AdditionalFees"];
    NSDictionary *questions = [dic valueForKey:@"AdditionalQuestions"];
    if(fees != nil && (NSNull *)fees != [NSNull null])
    {
        NSMutableArray *feeArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dicFee in fees) {
            ETAddFee *fee = [[ETAddFee alloc] initWithDic:dicFee ];
            if(fee != nil)
            {
                [feeArray addObject:fee];
            }
        }
        if([feeArray count] > 0)
        {
            order.feeArray = feeArray;
        }
    }
    if(questions != nil && (NSNull *)questions != [NSNull null])
    {
        NSMutableArray *questionArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dicQuestion in questions) {
            ETAddQuestion *question = [[ETAddQuestion alloc] initWithDic:dicQuestion];
            if(question != nil)
            {
                [questionArray addObject:question];
            }
        }
        if([questionArray count] > 0)
        {
            order.questionArray = questionArray;
        }
    }
    order.guestCount = [dic valueForKey:@"guestcount"];
    return order;
}
-(NSArray *)transformToObjectArrayFromDictionary:(NSDictionary *)dic
{
    NSMutableArray *result = nil;
    
    NSArray *arOrders = [dic valueForKey:@"orders"];
    NSString *total =[dic valueForKey:@"total"];
    NSString *totalPage =[dic valueForKey:@"totalPage"];
    NSString *page =[dic valueForKey:@"page"];
    NSString *pn =[dic valueForKey:@"pn"];
    if(arOrders != nil)
    {
        result = [[NSMutableArray alloc] init];
        for (NSDictionary *dicOrder in arOrders) {
            [result addObject:[self transformToObjectFromDictionary:dicOrder]];
        }
    }
    return result;
}
-(BOOL)recordGuestInAction:(NSString *) action ByOrderCode:(NSString *)orderCode BySnapshotCode:(NSString *)snapshotCode WithGuestStates:(NSString *)guestStates
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?action=%@&guest_states=%@&order_code=%@&token=%@&vendor_code=%@",recordGuestInfoUrl,snapshotCode, action, guestStates, orderCode, token, merchantCode]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: merchantCode, nil],
                            @"code",
                            [NSArray arrayWithObjects: snapshotCode, nil],
                            @"id",
                            [NSArray arrayWithObjects: action, nil],
                            @"action",
                            [NSArray arrayWithObjects: guestStates, nil],
                            @"guest_states",
                            [NSArray arrayWithObjects: orderCode, nil],
                            @"order_code",
                            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",token], nil],
                            @"token",
                            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",merchantCode], nil],
                            @"vendor_code",
                            nil];
    
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"PUT" WithUri:@"/appsnapshot/" WithParams:params WithAuth:@"auth-int"]];
    [request setRequestMethod:@"PUT"];
    [request startSynchronous];
    //[request s]
    NSError *error = [request error];
    NSData *resData = nil;
    if(!error)
    {
        NSString *response = [request responseString];
        resData = [response dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(resData)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        if(dic == nil || [dic valueForKey:@"error"] != nil)
        {
            return false;
        }
        
        
        return true;
    }
    return false;
}

@end
