//
//  UIDevice+iAppInfos.h
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const UIDeviceModeliPhone1G;
extern NSString * const UIDeviceModeliPhone3G;
extern NSString * const UIDeviceModeliPhone3GS;

extern NSString * const UIDeviceModeliPhone4;
extern NSString * const UIDeviceModelVerizoniPhone4;
extern NSString * const UIDeviceModeliPhone4S;

extern NSString * const UIDeviceModeliPhone5_GSM;
extern NSString * const UIDeviceModeliPhone5_GSM_CDMA;
extern NSString * const UIDeviceModeliPhone5C_GSM;
extern NSString * const UIDeviceModeliPhone5C_Global;

extern NSString * const UIDeviceModeliPhone5S_GSM;
extern NSString * const UIDeviceModeliPhone5S_Global;

extern NSString * const UIDeviceModeliPodTouch1G;
extern NSString * const UIDeviceModeliPodTouch2G;
extern NSString * const UIDeviceModeliPodTouch3G;
extern NSString * const UIDeviceModeliPodTouch4G;
extern NSString * const UIDeviceModeliPodTouch5G;

extern NSString * const UIDeviceModeliPad;
extern NSString * const UIDeviceModeliPad2_Wifi;
extern NSString * const UIDeviceModeliPad2_GSM;
extern NSString * const UIDeviceModeliPad2_CDMA;
extern NSString * const UIDeviceModeliPad2;
extern NSString * const UIDeviceModeliPad3G_Wifi;
extern NSString * const UIDeviceModeliPad3G_4G;
extern NSString * const UIDeviceModeliPad4G_Wifi;
extern NSString * const UIDeviceModeliPad4G_GSM;
extern NSString * const UIDeviceModeliPad4G_GSM_CDMA;

extern NSString * const UIDeviceModeliPadMini1G_Wifi;
extern NSString * const UIDeviceModeliPadMini1G_GSM;
extern NSString * const UIDeviceModeliPadMini1G_GSM_CDMA;
extern NSString * const UIDeviceModeliPadMiniRetina2G_Wifi;
extern NSString * const UIDeviceModeliPadMiniRetina2G_Cellular;
extern NSString * const UIDeviceModeliPadAir_Wifi;
extern NSString * const UIDeviceModeliPadAir_Cellular;

extern NSString * const UIDeviceModelSimulatorI386;
extern NSString * const UIDeviceModelSimulatorX86_64;
extern NSString * const UIDeviceModelSimulator;

typedef NS_ENUM(NSInteger, UIDeviceModelType) {
    UIDeviceModelTypeiPhone,
    UIDeviceModelTypeiPod,
    UIDeviceModelTypeiPad,
    UIDeviceModelTypeSimulator
};

@class JMODevicePowerInfos;
@interface UIDevice (iAppInfos)

+ (NSString *)jmo_modelName;

/*!
 * @return Whether the device is an iPod, iPhone, or iPad. If it is not explicitly any of those,
 *  the device is assumed to be a simulator.
 */
+ (UIDeviceModelType)jmo_deviceModelType;
+ (JMODevicePowerInfos *)jmo_devicePowerInfos;

@end
