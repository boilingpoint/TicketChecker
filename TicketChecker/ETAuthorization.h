//
//  ETAuthorization.h
//  TicketChecker
//
//  Created by admin on 13-11-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETAuthorization : NSObject
+(NSString *)getDigestAuthorizationWithAccesskey:(NSString *)accessKey WithSecretKey:(NSString *)secretKey
                                       WithRealm:(NSString *)realm WithMethod:(NSString *)method WithUri:(NSString *)uri
                                      WithParams:(NSDictionary *)params WithAuth:(NSString *)auth;
+(NSString *)getUriSortParamsString:(NSDictionary *)params;
+(NSString *)getDigestResponseWithAccessKey:(NSString *)accessKey WithSecretKey:(NSString *)secretKey WithRealm:(NSString *)realm WithMethod:(NSString *)method WithUri:(NSString *)uri WithUriSortString:(NSString *)uriSortString;
+(NSString *)md5:(NSString *)str;
+ (NSString *) sha1:(NSString *)str;
+ (NSString *) sha1_base64:(NSString *)str;
+ (NSString *) md5_base64:(NSString *)str;
+ (NSString *) base64:(NSString *)str;
@end
