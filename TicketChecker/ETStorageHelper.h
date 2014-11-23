//
//  ETStorageHelper.h
//  TicketChecker
//
//  Created by admin on 13-12-6.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETStorageHelper : NSObject

+(void)SetObject:(NSObject *)object ByKey:(NSString *)key;
+(id)GetObjectByKey:(NSString *)key;
@end
