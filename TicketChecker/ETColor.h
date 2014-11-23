//
//  ETColor.h
//  TicketChecker
//
//  Created by admin on 13-11-11.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ETColor : NSObject
{
}
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIImage *)scaleImage:(UIImage *)image scaledToSize:(CGSize)size;
@end
