//
//  ETGuestInfo.h
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBase.h"

@interface ETGuestInfo : ETBase

@property NSString *firstName;
@property NSString *lastName;
@property NSString *name;
@property NSString *phone;
@property NSString *email;
@property NSArray *feeArray;
@property NSArray *questionArray;
@property int fulfillmentStatus;

-(ETGuestInfo *)initWithDic:(NSDictionary *)dic;
@end
