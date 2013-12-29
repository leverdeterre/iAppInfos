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

+ (NSString *) getSysInfo
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

+ (NSString *)modelName
{
    NSString *systInfo = [self getSysInfo];
    if ([systInfo isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([systInfo isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([systInfo isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([systInfo isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([systInfo isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([systInfo isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([systInfo isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([systInfo isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([systInfo isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([systInfo isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
    if ([systInfo isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([systInfo isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (Global)";
    if ([systInfo isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([systInfo isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([systInfo isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([systInfo isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([systInfo isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([systInfo isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([systInfo isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([systInfo isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([systInfo isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([systInfo isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([systInfo isEqualToString:@"iPad3,1"])      return @"iPad-3G (WiFi)";
    if ([systInfo isEqualToString:@"iPad3,2"])      return @"iPad-3G (4G)";
    if ([systInfo isEqualToString:@"iPad3,3"])      return @"iPad-3G (4G)";
    if ([systInfo isEqualToString:@"iPad3,4"])      return @"iPad-4G (WiFi)";
    if ([systInfo isEqualToString:@"iPad3,5"])      return @"iPad-4G (GSM)";
    if ([systInfo isEqualToString:@"iPad3,6"])      return @"iPad-4G (GSM+CDMA)";
    if ([systInfo isEqualToString:@"iPad2,5"])      return @"iPad mini-1G (WiFi)";
    if ([systInfo isEqualToString:@"iPad2,6"])      return @"iPad mini-1G (GSM)";
    if ([systInfo isEqualToString:@"iPad2,7"])      return @"iPad mini-1G (GSM+CDMA)";
    if ([systInfo isEqualToString:@"iPad4,4"])      return @"iPad mini 2G Retina (WiFi)";
    if ([systInfo isEqualToString:@"iPad4,5"])      return @"iPad mini 2G Retina (Cellular)";
    if ([systInfo isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([systInfo isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    
    return @"iPhone Simulator";
}




@end
