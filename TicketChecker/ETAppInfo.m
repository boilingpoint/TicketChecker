//
//  ETAppInfo.m
//  TicketChecker
//
//  Created by admin on 14-1-5.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETAppInfo.h"
#import "ASIHTTPRequest.h"
#import "ETAuthorization.h"
#import "ETDictionary.h"

@implementation ETAppInfo

-(void)init
{
    [super init];
    
    
    appInfoUrl = apiUrl;
}

-(ETAppInfo *)getAppInfoByLanguage:(NSString *)langCode
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",appInfoUrl,@"mineinfo", langCode]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: NSLocalizedString(@"language", nil), nil],
                            @"id",
                            nil];
    
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/mineinfo/" WithParams:params WithAuth:@"auth-int"]];
    [request startSynchronous];
    NSError *error = [request error];
    NSData *resData = nil;
    if(!error)
    {
        NSString *response = [request responseString];
        resData = [response dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(resData)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        if(dic == nil || [dic valueForKey:@"error"] != nil)
        {
            return nil;
        }
        
        
        return [self transformToObjectFromDictionary:dic];
    }
    return nil;
}
-(ETAppInfo *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETAppInfo *appInfo = [ETAppInfo alloc];
    appInfo.aboutMe = [dic valueForKey:@"about"];
    return appInfo;
}
@end
