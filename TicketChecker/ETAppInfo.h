//
//  ETAppInfo.h
//  TicketChecker
//
//  Created by admin on 14-1-5.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBase.h"

@interface ETAppInfo : ETBase
{
    NSString *appInfoUrl;
}

@property NSString *aboutMe;


-(ETAppInfo *)getAppInfoByLanguage:(NSString *)langCode;
-(ETAppInfo *)transformToObjectFromDictionary:(NSDictionary *)dic;
@end
