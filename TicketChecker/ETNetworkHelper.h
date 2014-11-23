//
//  ETNetworkHelper.h
//  TicketChecker
//
//  Created by admin on 13-12-7.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETNetworkHelper : NSObject
-(bool)getNetWorkState:(const char*)UrlStr;
- (BOOL) connectedToNetwork;
@end
