//
//  UIDevice+iAppInfos.m
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "UIDevice+iAppInfos.h"

#include <sys/sysctl.h>

@implementation UIDevice (iAppInfos)

+ (NSString *) jmo_getSysInfo
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

+ (NSString *)jmo_modelName
{
    NSString *systInfo = [self jmo_getSysInfo];
    
    if ([systInfo isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([systInfo isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([systInfo isEqualToString:@"iPhone2,1"])    return @"iPhone 3G[S]";
    if ([systInfo isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([systInfo isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM / 2012)";
    if ([systInfo isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([systInfo isEqualToString:@"iPhone4,1"])    return @"iPhone 4[S]";
    if ([systInfo isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([systInfo isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([systInfo isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([systInfo isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (Global)";
    if ([systInfo isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([systInfo isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    if ([systInfo isEqualToString:@"iPhone7,1"])    return @"iPhone 6+";
    if ([systInfo isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([systInfo isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([systInfo isEqualToString:@"iPhone8,2"])    return @"iPhone 6s+";

    if ([systInfo isEqualToString:@"iPod1,1"])      return @"iPod touch 1G";
    if ([systInfo isEqualToString:@"iPod2,1"])      return @"iPod touch 2G";
    if ([systInfo isEqualToString:@"iPod3,1"])      return @"iPod touch 3";
    if ([systInfo isEqualToString:@"iPod4,1"])      return @"iPod touch 4";
    if ([systInfo isEqualToString:@"iPod5,1"])      return @"iPod touch 5";
    if ([systInfo isEqualToString:@"iPod7,1"])      return @"iPod touch 6";

    if ([systInfo isEqualToString:@"iPad1,1"])      return @"iPad 1";
    if ([systInfo isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([systInfo isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([systInfo isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([systInfo isEqualToString:@"iPad2,4"])      return @"iPad 2 (Mid 2012)";
    if ([systInfo isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([systInfo isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([systInfo isEqualToString:@"iPad2,7"])      return @"iPad Mini (Global)";
    
    if ([systInfo isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([systInfo isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([systInfo isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([systInfo isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([systInfo isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([systInfo isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    
    if ([systInfo isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([systInfo isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([systInfo isEqualToString:@"iPad4,3"])      return @"iPad Air (China)";
    if ([systInfo isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([systInfo isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([systInfo isEqualToString:@"iPad4,6"])      return @"iPad Mini 2 (China)";;
    if ([systInfo isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";;
    if ([systInfo isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([systInfo isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    
    if ([systInfo isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([systInfo isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([systInfo isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([systInfo isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    
    if ([systInfo isEqualToString:@"iPad6,7"])      return @"iPad Pro (WiFi)";
    if ([systInfo isEqualToString:@"iPad6,8"])      return @"iPad Pro (Cellular)";
    
    if ([systInfo isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([systInfo isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    return systInfo;
}

+ (NSString *)jmo_familyModelName
{
    NSString *systInfo = [self jmo_getSysInfo];
    
    if ([systInfo isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([systInfo isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([systInfo isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([systInfo isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([systInfo isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([systInfo isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([systInfo isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([systInfo isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([systInfo isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([systInfo isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([systInfo isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([systInfo isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([systInfo isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([systInfo isEqualToString:@"iPhone7,1"])    return @"iPhone 6+";
    if ([systInfo isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([systInfo isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([systInfo isEqualToString:@"iPhone8,2"])    return @"iPhone 6s+";
    
    if ([systInfo isEqualToString:@"iPod1,1"])      return @"iPod touch 1G";
    if ([systInfo isEqualToString:@"iPod2,1"])      return @"iPod touch 2G";
    if ([systInfo isEqualToString:@"iPod3,1"])      return @"iPod touch 3";
    if ([systInfo isEqualToString:@"iPod4,1"])      return @"iPod touch 4";
    if ([systInfo isEqualToString:@"iPod5,1"])      return @"iPod touch 5";
    if ([systInfo isEqualToString:@"iPod7,1"])      return @"iPod touch 6";
    
    if ([systInfo isEqualToString:@"iPad1,1"])      return @"iPad 1";
    if ([systInfo isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([systInfo isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([systInfo isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([systInfo isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([systInfo isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([systInfo isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([systInfo isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    
    if ([systInfo isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([systInfo isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([systInfo isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([systInfo isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([systInfo isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([systInfo isEqualToString:@"iPad3,6"])      return @"iPad 4";
    
    if ([systInfo isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([systInfo isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([systInfo isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([systInfo isEqualToString:@"iPad4,4"])      return @"iPad Mini 2";
    if ([systInfo isEqualToString:@"iPad4,5"])      return @"iPad Mini 2";
    if ([systInfo isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";;
    if ([systInfo isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([systInfo isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([systInfo isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    
    if ([systInfo isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    if ([systInfo isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([systInfo isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([systInfo isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([systInfo isEqualToString:@"iPad6,7"])      return @"iPad Pro";
    if ([systInfo isEqualToString:@"iPad6,8"])      return @"iPad Pro";
    
    if ([systInfo isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([systInfo isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    return systInfo;
}

+ (UIDeviceModelType)jmo_deviceModelType
{
    NSString *modelName = [self jmo_modelName];

    if ([modelName rangeOfString:@"iPhone"].location != NSNotFound) {
        return UIDeviceModelTypeiPhone;
        
    } else if ([modelName rangeOfString:@"iPod"].location != NSNotFound) {
        return UIDeviceModelTypeiPod;
        
    } else if ([modelName rangeOfString:@"iPad"].location != NSNotFound) {
        return UIDeviceModelTypeiPad;
    }
    
    return UIDeviceModelTypeSimulator;
}

@end
