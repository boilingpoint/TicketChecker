//
//  ETDictionary.m
//  TicketChecker
//
//  Created by admin on 13-11-15.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETDictionary.h"
#import "ETFormatHelper.h"

@implementation ETDictionary

+(NSString *)getValueOfDictionary:(NSDictionary *)dic ByKey:(NSString *)key
{
    if([dic isKindOfClass:[NSString class]])
    {
        return nil;
    }
    if((NSNull *)dic == [NSNull null])
    {
        return nil;
    }
    NSArray *keys = [dic allKeys];
    for (NSString *dicKey in keys) {
        if([dicKey isEqualToString:key]) {
            id dataDic = [dic valueForKey:dicKey];
            if(dataDic == nil || (NSNull *)dataDic == [NSNull null])
            {
                return nil;
            }
            else if([dataDic isKindOfClass:[NSString class]]) {
                return [dic valueForKey:dicKey];
            } else if([dataDic isKindOfClass:[NSNumber class]]) {
                return [NSString stringWithFormat:@"%d",[(NSNumber *)[dic valueForKey:dicKey] intValue]];
            } else if([dataDic isKindOfClass:[NSArray class]]) {
                NSString *result = [[NSString alloc] init];
                
                for (NSString *value in dataDic) {
                    result = [NSString stringWithFormat:@"%@%@,",result, value];
                }
                if([result length] > 0) {
                    result = [result substringToIndex:result.length - 1];
                }
                return result;
            } else { 
                NSString *result = [[NSString alloc] init];
                
                for (NSString *valuekey in [dataDic allValues]) {
                    result = [NSString stringWithFormat:@"%@%@,",result, [dataDic valueForKey:valuekey]];
                }
                if([result length] > 0) {
                    result = [result substringToIndex:result.length - 1];
                }
                return result;
            }
        }
    }
    NSString *result = nil;
    for(NSString *dicKey in keys) {
        id innerDic = [dic valueForKey:dicKey];
        if([innerDic isKindOfClass:[NSDictionary class]]) {
            id result = [self getValueOfDictionary:innerDic ByKey:key];
            if(result != nil)
            {
                return result;
            }
        }
    }
    return nil;
}

@end
