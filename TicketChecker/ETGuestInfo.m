//
//  ETGuestInfo.m
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETGuestInfo.h"
#import "ETDictionary.h"
#import "ETAddFee.h"
#import "ETAddQuestion.h"

@implementation ETGuestInfo

-(ETGuestInfo *)initWithDic:(NSDictionary *)dic
{
    if([dic isKindOfClass:[NSString class]])
    {
        return nil;
    }
    self.firstName =[ETDictionary getValueOfDictionary:dic ByKey:@"FirstName"];
    self.lastName = [ETDictionary getValueOfDictionary:dic ByKey:@"LastName"];
    if(self.firstName == nil || (NSNull *)self.firstName == [NSNull null]) {
        self.firstName = @"";
    }
    if(self.lastName == nil || (NSNull *)self.lastName == [NSNull null]) {
        self.lastName = @"";
    }
    if(self.lastName.length > 0){
        if([self.lastName characterAtIndex:0] >= 'A' && [self.lastName characterAtIndex:0] <= 'z')
        {
            self.name = [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
        }
        else
        {
            self.name = [NSString stringWithFormat:@"%@%@",self.lastName,self.firstName];
        }
    }
    else{
        self.name = @"";
    }
    self.phone = [ETDictionary getValueOfDictionary:dic ByKey:@"Phone"];
    self.email = [ETDictionary getValueOfDictionary:dic ByKey:@"Email"];
    //if()
    if([ETDictionary getValueOfDictionary:dic ByKey:@"FulfillmentStatus"] != nil && (NSNull *)[ETDictionary getValueOfDictionary:dic ByKey:@"FulfillmentStatus"] != [NSNull null])
    {
    self.fulfillmentStatus = [(NSNumber *)[ETDictionary getValueOfDictionary:dic ByKey:@"FulfillmentStatus"] integerValue];
    }
    else
    {
        self.fulfillmentStatus = 1;
    }
    NSDictionary *fees = [dic valueForKey:@"AdditionalFee"];
    if(fees != nil && (NSNull *)fees != [NSNull null] && [fees count] != 0) {
        NSMutableArray *feeMutArray = [[NSMutableArray alloc] init];
        for(NSDictionary *fee in fees) {
            ETAddFee *objFee =[[ETAddFee alloc] initWithDic:fee];
            if(objFee != nil)
            {
                [feeMutArray addObject:objFee];
            }
        }
        self.feeArray = feeMutArray;
    }
    NSDictionary *questions = [dic valueForKey:@"AdditionalQuestion"];
    if(questions != nil && (NSNull *)questions != [NSNull null] && [questions count] != 0) {
        NSMutableArray *questionMutArray = [[NSMutableArray alloc] init];
        for(NSDictionary *question in questions) {
            ETAddQuestion *objQuestion = [[ETAddQuestion alloc] initWithDic:question];
            if(objQuestion != nil)
            {
                [questionMutArray addObject:objQuestion];
            }
        }
        self.questionArray = questionMutArray;
    }
    return self;
}
@end
