//
//  ETAddQuestion.h
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETAddQuestion :NSObject
{
}
@property NSString *questionName;
@property NSString *questionAnswer;

-(ETAddQuestion *)initWithDic:(NSDictionary *)dic;
@end
