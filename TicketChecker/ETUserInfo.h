//
//  ETUserInfo.h
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBase.h"
#import "Jastor.h"

@interface ETUserInfo : ETBase
{
    NSString *loginUrl;
    
    NSString *id;
    NSString *name;
    NSString *sign;
    NSString *desc;
}
@property NSString *access_token;
@property NSString *expire_in;
@property NSString *merchant_code;
@property NSString *error;

-(ETUserInfo *)getUserByUserName:(NSString *)username Password:(NSString *)password;
-(ETUserInfo *)transformToObjectFromDictionary:(NSDictionary *)dic;

@end
