//
//  ETAddFee.m
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETAddFee.h"
#import "ETDictionary.h"

@implementation ETAddFee

-(ETAddFee *)initWithDic:(NSDictionary *)dic
{
    if([dic isKindOfClass:[NSString class]])
    {
        return nil;
    }
    //ETAddFee *fee = [ETAddFee alloc];
    self.feeName = [ETDictionary getValueOfDictionary:dic ByKey:@"Title"];
    self.feePrice = [ETDictionary getValueOfDictionary:dic ByKey:@"Result"];
    return self;
}
@end
