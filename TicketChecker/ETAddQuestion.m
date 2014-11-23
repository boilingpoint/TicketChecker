//
//  ETAddQuestion.m
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETAddQuestion.h"
#import "ETDictionary.h"

@implementation ETAddQuestion

-(ETAddQuestion *)initWithDic:(NSDictionary *)dic
{
    if([dic isKindOfClass:[NSString class]])
    {
        return nil;
    }
    self.questionName = [ETDictionary getValueOfDictionary:dic ByKey:@"Title"];
    self.questionAnswer = [ETDictionary getValueOfDictionary:dic ByKey:@"Result"];
    return self;
}
@end
