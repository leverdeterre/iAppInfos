//
//  AppInformationsManager.m
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "AppInformationsManager.h"

#import "UIDevice+iAppInfos.h"
#import "UIApplication+iAppInfos.h"
#import "NSDictionary+iAppInfos.h"
#import "JMOMobileProvisionning.h"
#import "JMODevicePowerInfos.h"

#import "mach/mach.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface AppInformationsManager ()
@property (strong, nonatomic) NSMutableDictionary *customValues;
@end

@implementation AppInformationsManager

#define MB (1024*1024)
#define GB (MB*1024)

#pragma mark Singleton Methods

+ (instancetype)sharedManager {
    static AppInformationsManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.customValues = [NSMutableDictionary new];
    });
    return sharedMyManager;
}

- (NSString *)description
{
    NSArray *keys = [self observedProperties];
    NSMutableString *str = [NSMutableString new];
    [str appendString:@"\n"];
    
    JMOMobileProvisionning *mobileProvi = nil;
    [str appendFormat:@"\n\t#Global infos\n"];
    for (NSString *key in keys) {
        id info = [[AppInformationsManager sharedManager] infoForKey:key];
        if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
             mobileProvi = (JMOMobileProvisionning *)info;
        }
        else {
            [str appendFormat:@"\t%@\t%@\n", key, info];
        }
    }
    
    if (nil != mobileProvi) {
        [str appendFormat:@"\n\t#MobileProvisionning infos\n"];
        [str appendFormat:@"\t%@\n", mobileProvi.teamName ];
        [str appendFormat:@"\t%@\n", mobileProvi];
    }
    
    return str;
}

#pragma mark to be datasource

- (NSString *)wSConfiguration
{
    if ([self.datasource respondsToSelector:@selector(getWSConfigurationForAppVersionManager:)]) {
        return [self.datasource getWSConfigurationForAppVersionManager:self];
    }
    
    return @"No info ...";
}

- (NSString *)pushToken
{
    if ([self.datasource respondsToSelector:@selector(getpushTokenForAppVersionManager:)]) {
        return [self.datasource getpushTokenForAppVersionManager:self];
    }
    
    return @"No info ...";
}

#pragma mark Private methods

+ (NSString *)memoryFormatter:(long long)diskSpace {
    NSString *formatted;
    double bytes = 1.0 * diskSpace;
    double megabytes = bytes / MB;
    double gigabytes = bytes / GB;
    if (gigabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f GB", gigabytes];
    else if (megabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f MB", megabytes];
    else
        formatted = [NSString stringWithFormat:@"%.2f bytes", bytes];
    
    return formatted;
}

- (NSString *)targetedVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleInfoDictionaryVersion"];
}

- (NSString *)youriOSVersion
{
    return [UIDevice currentDevice].systemVersion;
}

- (NSString *)yourDeviceModel
{
    return [UIDevice jmo_modelName];
}

- (NSString *)compilationSDK
{
    return [UIApplication jmo_iOSSDKVersion];
}

- (NSString *)version
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)shortVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)freeDiskSpace
{
    long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
    return [self.class memoryFormatter:freeSpace];
}

- (NSString *)batteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [NSString stringWithFormat:@"%2.f%%",[UIDevice currentDevice].batteryLevel* 100];
}

- (JMOMobileProvisionning *)mobileProvisionning
{
    // There is no provisioning profile in AppStore Apps
    NSString *profilePath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    NSString *result = nil;

    // Check provisioning profile existence
    if (profilePath)
    {
        // Get hex representation
        NSData *profileData = [NSData dataWithContentsOfFile:profilePath];
        NSString *profileString = [NSString stringWithFormat:@"%@", profileData];
        
        // Remove brackets at beginning and end
        profileString = [profileString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        profileString = [profileString stringByReplacingCharactersInRange:NSMakeRange(profileString.length - 1, 1) withString:@""];
        
        // Remove spaces
        profileString = [profileString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        // Convert hex values to readable characters
        NSMutableString *profileText = [NSMutableString new];
        for (int i = 0; i < profileString.length; i += 2)
        {
            NSString *hexChar = [profileString substringWithRange:NSMakeRange(i, 2)];
            int value = 0;
            sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
            [profileText appendFormat:@"%c", (char)value];
        }
        
        NSRange range1 = [profileText rangeOfString:@"<?xml"];
        if ( range1.location != NSNotFound ) {
            NSRange range2 = [profileText rangeOfString:@"</plist>"];
            if ( range2.location != NSNotFound ) {
                NSRange range = NSMakeRange(range1.location, range2.location + range2.length - range1.location);
                result = [profileText substringWithRange:range];
                
                NSDictionary *dict = [NSDictionary jmo_dictionaryWithMobileProvisioningString:result];
                JMOMobileProvisionning *provisionningObj = [[JMOMobileProvisionning alloc] initWithDictionary:dict];
                return provisionningObj;
            }
        }

    }
    
    return nil;
}

vm_size_t machFreeMemory(void)
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

- (NSString *)freeMemorySpace
{
    unsigned long freeSpace = machFreeMemory();
    unsigned long long totalMemory = [[NSProcessInfo processInfo] physicalMemory];
    CGFloat pourcent = (CGFloat)freeSpace/totalMemory;
    return [NSString stringWithFormat:@"%@ (%d%%)",[self.class memoryFormatter:freeSpace],(int)(100*pourcent)];
}

- (NSString *)operator
{
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    return [carrier carrierName];
}

- (BOOL)hasGoodGraphicalPerformance
{
    JMODevicePowerInfos *graphInfo = [JMODevicePowerInfos infosForDeviceModelNamed:[UIDevice jmo_modelName]];
    return [graphInfo hasGoodGraphicPerformance];
}


#pragma mark - Public 

- (id)infoForKey:(NSString *)key
{
    if ([key isEqualToString:AppVersionManagerKeyTargetedVersion]) {
        return [self targetedVersion];
    }
    else if ([key isEqualToString:AppVersionManagerKeyYouriOSVersion]) {
        return [self youriOSVersion];
    }
    else if ([key isEqualToString:AppVersionManagerKeyYourDeviceModel]) {
        return [self yourDeviceModel];
    }
    else if ([key isEqualToString:AppVersionManagerKeyCompilationSDK]) {
        return [self compilationSDK];
    }
    else if ([key isEqualToString:AppVersionManagerKeyWSConfiguration]) {
        return [self wSConfiguration];
    }
    else if ([key isEqualToString:AppVersionManagerKeyCFBundleVersion]) {
        return [self version];
    }
    else if ([key isEqualToString:AppVersionManagerKeyCFBundleShortVersionString]) {
        return [self shortVersion];
    }
    else if ([key isEqualToString:AppVersionManagerKeyFreeDiskSpace]) {
        return [self freeDiskSpace];
    }
    else if ([key isEqualToString:AppVersionManagerKeyBatteryLevel]) {
        return [self batteryLevel];
    }
    else if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
        static JMOMobileProvisionning *provisionningObj;
        if (provisionningObj == nil) {
            provisionningObj = [self mobileProvisionning];
        }
        return provisionningObj;
    }
    else if ([key isEqualToString:AppVersionManagerKeyPushToken]) {
        return [self pushToken];
    }
    else if ([key isEqualToString:AppVersionManagerKeyFreeMemory]) {
        return [self freeMemorySpace];
    }
    else if ([key isEqualToString:AppVersionManagerKeyOperator]) {
        return [self operator];
    }
    else if ([key isEqualToString:AppVersionManagerKeyGraphicalPerformance]) {
        if ([self hasGoodGraphicalPerformance]) {
            return @"YES";
        }
        return  @"NO";
    }
    else {
        id obj = [self.customValues objectForKey:key];
        if (nil != obj) {
            return obj;
        }
    }
    return @"";
}

- (void)addCustomValue:(NSString *)value forCustomKey:(NSString *)key
{
    [self.customValues setValue:value forKey:key];
}

- (NSString *)htmlDescriptionWithKeys:(NSArray *)keys
{
    NSMutableString *str = [NSMutableString new];
    [str appendString:@"<TABLE>"];
    
    for (NSString *key in keys) {
        id info = [[AppInformationsManager sharedManager] infoForKey:key];
        if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
            JMOMobileProvisionning *mobileProvi = (JMOMobileProvisionning *)info;
            [str appendFormat:@"<TR><TD>%@</TD><TD>%@</TD></TR>", key, mobileProvi.teamName ];
        }
        else {
            [str appendFormat:@"<TR><TD>%@</TD><TD>%@</TD></TR>", key, info];
        }
    }
    
    [str appendString:@"</TABLE>"];
    return str;
}

- (NSArray*)observedProperties
{
    if ([self.datasource respondsToSelector:@selector(desiredKeysForAppVersionManager:)]) {
        return [self.datasource desiredKeysForAppVersionManager:self];
    }
    
    return @[AppVersionManagerKeyTargetedVersion,AppVersionManagerKeyYouriOSVersion,AppVersionManagerKeyYourDeviceModel,AppVersionManagerKeyCompilationSDK, AppVersionManagerKeyCFBundleVersion, AppVersionManagerKeyCFBundleShortVersionString, AppVersionManagerKeyFreeDiskSpace,AppVersionManagerKeyFreeMemory, AppVersionManagerKeyBatteryLevel,AppVersionManagerKeyMobileProvisionning, AppVersionManagerKeyPushToken,AppVersionManagerKeyWSConfiguration];
}

@end
