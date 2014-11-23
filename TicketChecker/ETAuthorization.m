//
//  ETAuthorization.m
//  TicketChecker
//
//  Created by admin on 13-11-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETAuthorization.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation ETAuthorization

+(NSString *)getDigestAuthorizationWithAccesskey:(NSString *)accessKey WithSecretKey:(NSString *)secretKey
                           WithRealm:(NSString *)realm WithMethod:(NSString *)method WithUri:(NSString *)uri
                          WithParams:(NSDictionary *)params WithAuth:(NSString *)auth
{
    NSString *response = @"";
    NSString *uri_sort_params_string = @"";
    if([auth isEqualToString:@"auth-int"])
    {
        uri_sort_params_string = [self getUriSortParamsString:params];
    }
    response = [self getDigestResponseWithAccessKey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:method WithUri:uri WithUriSortString:uri_sort_params_string];
    NSString *result = [NSString stringWithFormat:@"Digest AccessKey=\"%@\", realm=\"%@\", uri=\"%@\", response=\"%@\", qop=\"%@\"",accessKey,realm,uri,response,auth];
    return result;
}
                                  
+(NSString *)getUriSortParamsString:(NSDictionary *)params
{
    NSString *result = @"";
    if(params == nil || params.count == 0)
    {
        return result;
    }
    NSArray *keyArray = [params allKeys];
    NSArray *sortedArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSString *key in sortedArray) {
        NSArray *value = [params valueForKey:key];
        result = [result stringByAppendingFormat:@"%@=%@&",key,value[0]];
    }
    if([result length] > 0)
    {
        result = [result substringToIndex:[result length] - 1];
    }
    
    return result;
}

+(NSString *)getDigestResponseWithAccessKey:(NSString *)accessKey WithSecretKey:(NSString *)secretKey WithRealm:(NSString *)realm WithMethod:(NSString *)method WithUri:(NSString *)uri WithUriSortString:(NSString *)uriSortString
{
    method = method.lowercaseString;
    NSString *result=@"";
    NSString *md5Key = [self md5:[NSString stringWithFormat:@"%@:%@:%@",accessKey,realm,secretKey]];
    NSString *methodAndUri = [NSString stringWithFormat:@"%@:%@",method,uri];
    if(![uriSortString isEqualToString:@""])
    {
        methodAndUri = [NSString stringWithFormat:@"%@:%@",methodAndUri,uriSortString];
    }
    result = [self md5:methodAndUri];
    return [self md5:[NSString stringWithFormat:@"%@:%@",md5Key,result]];
}

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

+(NSString *)sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *) sha1_base64:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    base64 = [GTMBase64 encodeData:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output;
}

+ (NSString *) md5_base64:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    base64 = [GTMBase64 encodeData:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output;
}

+ (NSString *) base64:(NSString *)str
{
    NSData * data = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString * output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

@end
