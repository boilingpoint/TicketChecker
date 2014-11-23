//
//  ETFormatHelper.m
//  TicketChecker
//
//  Created by admin on 13-11-19.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETFormatHelper.h"

@implementation ETFormatHelper

+(BOOL) isPureInt:(NSString *)str
{
    NSScanner *scan = [NSScanner scannerWithString:str];
    int val;
    @try
    {
        return [scan scanInt:&val] && [scan isAtEnd];
    }
    @catch(NSException *e)
    {
        return false;
    }
    
    
}
+(BOOL) isPureFloat:(NSString *)str
{
    NSScanner *scan = [NSScanner scannerWithString:str];
    float val;
    @try
    {
        return [scan scanFloat:&val] && [scan isAtEnd];
    }
    @catch(NSException *e)
    {
        return false;
    }
}
+(BOOL) isNumber:(NSString *)str
{
    return [ETFormatHelper isPureInt:str] && [ETFormatHelper isPureFloat:str];
}
@end
