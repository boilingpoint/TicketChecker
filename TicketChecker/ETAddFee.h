//
//  ETAddFee.h
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ETAddFee : NSObject
{}
@property NSString *feeName;
@property NSString *feeCurrency;
@property NSString *feePrice;

-(ETAddFee *)initWithDic:(NSDictionary *)dic;
@end
