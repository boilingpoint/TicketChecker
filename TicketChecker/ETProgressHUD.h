//
//  ETProgressHUD.h
//  TicketChecker
//
//  Created by admin on 13-12-7.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

extern NSString * const ETProgressHUDDidReceiveTouchEventNotification;
extern NSString * const ETProgressHUDWillDisappearNotification;
extern NSString * const ETProgressHUDDidDisappearNotification;
extern NSString * const ETProgressHUDWillAppearNotification;
extern NSString * const ETProgressHUDDidAppearNotification;

extern NSString * const ETProgressHUDStatusUserInfoKey;

enum {
    ETProgressHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    ETProgressHUDMaskTypeClear, // don't allow
    ETProgressHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    ETProgressHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger ETProgressHUDMaskType;

@interface ETProgressHUD : UIView

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 50000
@property (readwrite, nonatomic, retain) UIColor *hudBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIColor *hudForegroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIColor *hudStatusShadowColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIColor *hudRingBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIColor *hudRingForegroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIFont *hudFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIImage *hudSuccessImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIImage *hudErrorImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
#endif

+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;

+ (void)show;
+ (void)showWithMaskType:(ETProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(ETProgressHUDMaskType)maskType;

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(ETProgressHUDMaskType)maskType;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses HUD 1s later
+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showImage:(UIImage*)image status:(NSString*)status; // use 28x28 white pngs

+ (void)popActivity;
+ (void)dismiss;

+ (BOOL)isVisible;

@end