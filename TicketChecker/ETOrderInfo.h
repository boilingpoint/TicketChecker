//
//  ETOrderInfo.h
//  TicketChecker
//
//  Created by admin on 13-11-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETUserInfo.h"


@interface ETOrderInfo : ETBase
{
    NSString *orderListUrl;
    NSString *orderDetailUrl;
    NSString *orderOverviewUrl;
    NSString *recordGuestInfoUrl;
    
    NSString *merchantCode;
    NSString *token;
    
    NSInteger pageSize;
    NSInteger pageIndex;

    
    
}

@property int totalCount;
@property int totalPage;

@property NSString *orderId;
@property NSString *orderCode;
@property NSInteger status;
@property NSString *vendorName;
@property NSString *optionName;
@property NSString *activityName;
@property NSString *saleDate;
@property NSString *bookingDate;
@property NSString *contactorFirstName;
@property NSString *contactorLastName;
@property NSString *contactorName;
@property NSString *contactorPhone;
@property NSString *contactorMail;
@property NSString *guestCount;
@property NSArray *guestArray;
@property double price;
@property NSString *currency;
@property NSString *code;
@property int fulfillment;
@property int record;
@property int allGuestInfoRequired;
@property NSString *error;
@property NSString *voucherId;
@property NSString *voucherNote;

@property NSString *createDate;
@property NSString *updateDate;
@property NSArray *feeArray;
@property NSArray *questionArray;

-(void)init;
-(NSDictionary *)getOrderOverviewByDate:(NSString *)date;
-(ETUserInfo *)transformToObjectFromDictionary:(NSDictionary *)dic;
-(NSArray *)getVendorOrderListByDate:(NSString *)date State:(NSInteger) state Page:(NSInteger)page PageNum:(NSInteger)pageNum;
-(ETOrderInfo *)getVendorOrderDetailByCode:(NSString *)orderid;
-(BOOL)recordGuestInAction:(NSString *) action ByOrderCode:(NSString *)orderCode BySnapshotCode:(NSString *)snapshotCode WithGuestStates:(NSString *)guestStates;

@end
