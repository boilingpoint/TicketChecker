//
//  ETUserInfo.m
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETUserInfo.h"
#import "ASIHTTPRequest.h"
#import "ETAuthorization.h"
#import "Jastor.h"

@implementation ETUserInfo

-(void)init
{
    [super init];
    loginUrl = [apiUrl stringByAppendingString:@"login"];
    
}

-(ETUserInfo *)getUserByUserName:(NSString *)username Password:(NSString *)password
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?password=%@",loginUrl,[username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], password]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: password, nil],
                            @"password",
                            [NSArray arrayWithObjects:username, nil],
                            @"id",
                            nil];
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/login/" WithParams:params WithAuth:@"auth-int"]];
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
        if(dic == nil)
        {
            return nil;
        }
        if([dic valueForKey:@"error"] != nil)
        {
            self.error = [dic valueForKey:@"message"];
        }
        else
        {
            [self transformToObjectFromDictionary:dic];
        }
        return self;
    }
    return nil;
}

-(ETUserInfo *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    self.access_token = [dic valueForKey:@"access_token"];
    self.expire_in = [dic valueForKey:@"expire_in"];
    self.merchant_code = [dic valueForKey:@"merchant_code"];
    
    return self;
}

@end
