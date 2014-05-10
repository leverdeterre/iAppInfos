iAppInfos
=========

[![Twitter](https://img.shields.io/badge/contact-@leverdeterre-green.svg)](http://twitter.com/leverdeterre)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/leverdeterre/iAppInfos/blob/master/LICENCE)
[![Cocoapods](http://img.shields.io/cocoapods/v/iAppInfos.svg)](https://github.com/leverdeterre/iAppInfos)

iAppInfos allows a easy access to ALL important App informations.  

![Image](demo.png)

#Available informations
## Device infos
*   iOS version 
*   Device model
*   Device type
*   Device performace (Has good graphical performance?)
*   Free disk space 
*   Free memory space
*   Battery level 
*   Operator name

## Apps infos
*   Targeted iOS version
*   App version number 
*   App short Version number
*   SDK use for compilation
*   Mobile provisionning push information (enable or not),
*   Mobile provisionning dev information (development / production),
*   Mobile provisionning UDID list (provisioned devices),

##Add custom values
*   WS Configuration
*   Token push

```objective-c
[[AppInformationsManager sharedManager] addCustomValue:@"This is a custom value" forCustomKey:@"CustomKey1"];
```

# Usage in the real life 

# Present all informations

See the sample, a very classic TableView Controller (JMOViewController)

# Get informations one by one

```objective-c
//Using properties
@property (strong, readonly, nonatomic) NSString *targetedVersion;
@property (strong, readonly, nonatomic) NSString *currentOSVersion;
@property (strong, readonly, nonatomic) NSString *appVersion;
@property (strong, readonly, nonatomic) NSString *shortAppVersion;
@property (assign, readonly, nonatomic) NSInteger freeMemorySpace; //in pourcent
@property (strong, readonly, nonatomic) NSString *operatorName;
@property (strong, readonly, nonatomic) NSString *deviceModelName;
@property (assign, readonly, nonatomic) UIDeviceModelType deviceModelType;
@property (strong, readonly, nonatomic) JMODevicePowerInfos *devicePowerInfo;
@property (strong, readonly, nonatomic) NSString *compilationSDK;
@property (strong, readonly, nonatomic) NSString *freeDiskSpace;
@property (assign, readonly, nonatomic) NSInteger batteryLevel; //in pourcent
@property (strong, readonly, nonatomic) JMOMobileProvisionning *mobileProvisionning;

//Using dictionnary keys
[[AppInformationsManager sharedManager] infoForKey:AppVersionManagerKeyYouriOSVersion];
```

##Defined keys are :
```objective-c
#define AppVersionManagerKeyTargetedVersion             @"targetedVersion"
#define AppVersionManagerKeyYouriOSVersion              @"currentOSVersion"
#define AppVersionManagerKeyCFBundleVersion             @"appVersion"
#define AppVersionManagerKeyCFBundleShortVersionString  @"shortAppVersion"
#define AppVersionManagerKeyFreeMemory                  @"freeMemorySpace"
#define AppVersionManagerKeyOperator                    @"operatorName"
#define AppVersionManagerKeyYourDeviceModel             @"deviceModelName"
#define AppVersionManagerKeyYourDeviceType              @"deviceModelType"
#define AppVersionManagerKeyGraphicalPerformance        @"devicePowerInfo"
#define AppVersionManagerKeyCompilationSDK              @"compilationSDK"
#define AppVersionManagerKeyFreeDiskSpace               @"freeDiskSpace"
#define AppVersionManagerKeyBatteryLevel                @"batteryLevel"
#define AppVersionManagerKeyMobileProvisionning         @"mobileProvisionning"
```



