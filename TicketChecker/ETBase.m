//
//  ETBase.m
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETBase.h"
#import "SVHTTPRequest.h"

@implementation ETBase

-(void)init
{
    apiUrl = @"http://58.68.245.154:8012/";//@"http://zh-cn.api.totalgds.com/";//
    accessKey = @"etourer";
    secretKey = @"a42d9b0a94c7cc527b16775ad695a15a";
    realm = @"totalgds openapi";
}
-(NSString *)trimString:(NSString *)str
{
    NSMutableString *mStr = [str mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    NSString *result = [mStr copy];
    return result;
}
@end
