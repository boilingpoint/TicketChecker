//
//  ETFormatHelper.h
//  TicketChecker
//
//  Created by admin on 13-11-19.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETFormatHelper : NSObject

+(BOOL) isPureInt:(NSString *)str;
+(BOOL) isPureFloat:(NSString *)str;
+(BOOL) isNumber:(NSString *)str;
@end
