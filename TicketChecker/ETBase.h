//
//  ETBase.h
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETBase : NSObject
{
    NSString *apiUrl;
    NSString *accessKey;
    NSString *secretKey;
    NSString *realm;
}
-(void)init;
-(NSHTTPURLResponse *)request:(NSString *)action withParameters:(NSArray *)parameters;
-(NSString *)trimString:(NSString *)str;
@end
