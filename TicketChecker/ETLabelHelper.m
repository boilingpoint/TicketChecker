//
//  ETLabelHelper.m
//  TicketChecker
//
//  Created by admin on 13-11-20.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ETLabelHelper.h"

@implementation ETLabelHelper

/*
+(UILabel *)getAutoSizeLabelWithColor:(UIColor *)color WithFrame:(CGRect)rect WidhtText:(NSString *)text WithFontSize:(float)fontSize WithFontName:(NSString *)fontName
{
    if([fontName isEqualToString:@""] || fontName == nil)
    {
        fontName = @"Heiti SC";
    }
    UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
    [lbl setFont:[UIFont fontWithName:fontName size:fontSize]];
    [lbl setTextColor:color];
    [lbl setText:text];
    
    CGSize size = CGSizeMake(rect.size.width, 1000);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:lbl.font, NSFontAttributeName, nil];
    CGSize actualsize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    lbl.frame = CGRectMake(rect.origin.x+rect.size.width - actualsize.width, rect.origin.y, actualsize.width, actualsize.height);
    return lbl;
}
 */
+(UILabel *)getAutoSizeLabelWithColor:(UIColor *)color WithFrame:(CGRect)rect WidhtText:(NSString *)text WithFontSize:(float)fontSize WithFontName:(NSString *)fontName WithAlignment:(int) alignment//alignment=0为默认对齐（左对齐），alignment=1(右对齐)，alignment=2(居中对齐)
{
    if([fontName isEqualToString:@""] || fontName == nil)
    {
        fontName = @"Heiti SC";
    }
    UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
    [lbl setNumberOfLines:0];
    lbl.lineBreakMode = UILineBreakModeWordWrap;
    
    [lbl setFont:[UIFont fontWithName:fontName size:fontSize]];
    [lbl setTextColor:color];
    [lbl setText:(text != nil && (NSNull *)text != [NSNull null] ? text : @"")];
    
    CGSize size = CGSizeMake(rect.size.width, 1000);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:lbl.font, NSFontAttributeName, nil];
    CGSize actualsize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    CGFloat x = rect.origin.x;
    if(alignment == 1)
    {
        x = rect.origin.x+rect.size.width - actualsize.width;
    }
    else if(alignment == 2)
    {
        x = (rect.origin.x+rect.size.width - actualsize.width)/2;
    }
    lbl.frame = CGRectMake(x, rect.origin.y, actualsize.width, actualsize.height);
    return lbl;
}
+(UILabel *)getAutoSizeLabelWithColor:(UIColor *)color WithFrame:(CGRect)rect WidhtText:(NSString *)text WithFontSize:(float)fontSize WithFontName:(NSString *)fontName WithAlignment:(int) alignment WithRow:(int)rowNum
{
    if([fontName isEqualToString:@""] || fontName == nil)
    {
        fontName = @"Heiti SC";
    }
    UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
    [lbl setNumberOfLines:rowNum];
    lbl.lineBreakMode = UILineBreakModeTailTruncation;
    
    [lbl setFont:[UIFont fontWithName:fontName size:fontSize]];
    [lbl setTextColor:color];
    [lbl setText:(text != nil && (NSNull *)text != [NSNull null] ? text : @"")];
    
    CGSize size = CGSizeMake(rect.size.width, 1000);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:lbl.font, NSFontAttributeName, nil];
    CGSize actualsize = [text sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:CGSizeMake(rect.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeTailTruncation];
    //actualsize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    CGFloat x = rect.origin.x;
    if(alignment == 1)
    {
        x = rect.origin.x+rect.size.width - actualsize.width;
    }
    else if(alignment == 2)
    {
        x = (rect.origin.x+rect.size.width - actualsize.width)/2;
    }
    int y =actualsize.height>rect.size.height?rect.origin.y-actualsize.height+rect.size.height:rect.origin.y;
    
    lbl.frame = CGRectMake(x, y, actualsize.width, actualsize.height);
    return lbl;
}
@end
