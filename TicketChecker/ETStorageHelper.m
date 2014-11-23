//
//  ETStorageHelper.m
//  TicketChecker
//
//  Created by admin on 13-12-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETStorageHelper.h"

@implementation ETStorageHelper
+(void)SetObject:(id)object ByKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}
+(id)GetObjectByKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}
@end
