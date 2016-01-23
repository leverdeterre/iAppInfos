//
//  UIDevice+iAppInfos.h
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIDeviceModelType) {
    UIDeviceModelTypeiPhone,
    UIDeviceModelTypeiPod,
    UIDeviceModelTypeiPad,
    UIDeviceModelTypeSimulator
};

@interface UIDevice (iAppInfos)

/**
 *  jmo_modelName give the exact mobile device model name (iPhone 4 (GSM),iPhone 4 (GSM / 2012), etc..)
 *
 *  @return NSString, a device model name
 */
+ (NSString *)jmo_modelName;

/**
 *  jmo_familyModelName give the family model name (iPhone 4,5,6,6S)
 *
 *  @return NSString, a family model name
 */
+ (NSString *)jmo_familyModelName;

/**
 *  Whether the device is an iPod, iPhone, or iPad. If it is not explicitly any of those,
 *  the device is assumed to be a simulator.
 *
 *  @return UIDeviceModelType 
 */
+ (UIDeviceModelType)jmo_deviceModelType;

@end
