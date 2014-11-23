//
//  ETLabelHelper.h
//  TicketChecker
//
//  Created by admin on 13-11-20.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETLabelHelper : NSObject

+(UILabel *)getAutoSizeLabelWithColor:(UIColor *)color WithFrame:(CGRect)rect WidhtText:(NSString *)text WithFontSize:(float)fontSize WithFontName:(NSString *)fontName WithAlignment:(int) alignment;
+(UILabel *)getAutoSizeLabelWithColor:(UIColor *)color WithFrame:(CGRect)rect WidhtText:(NSString *)text WithFontSize:(float)fontSize WithFontName:(NSString *)fontName WithAlignment:(int) alignment WithRow:(int)rowNum;
@end
