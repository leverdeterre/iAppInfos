iAppInfos
=========

iAppInfos allows a easy access to ALL important App informations.  

![Image](demo.png)

# Device infos
*   iOS Version 
*   Device model
*   Free disk space
*   Free memory space
*   Battery level 
*   Operator name
*   Has good graphical performance?  (Why detect good/bad performance? to enable optional effects if chipset/processor are strong enough)

# Apps infos
*   Targeted iOS Version
*   Version number 
*   Short Version number
*   SDK use for compilation
*   Mobile provisionning push information (enable or not),
*   Mobile provisionning dev information (development / production),
*   Mobile provisionning UDID list (provisioned devices),

# Optionnal keys
*   WS Configuration
*   Token push

# Configuration

To configure iAppInfos, you can set a custom datasource
```objective-c
[AppInformationsManager sharedManager].datasource = self;
```

## Configure interest keys

Your datasource can optionally implement desiredKeysForAppVersionManager method to filter the keys you need to observe.

```objective-c

- (NSArray *)desiredKeysForAppVersionManager:(AppInformationsManager *)manager
{
    return @[AppVersionManagerKeyYouriOSVersion,AppVersionManagerKeyYourDeviceModel,AppVersionManagerKeyCompilationSDK, AppVersionManagerKeyCFBundleVersion, AppVersionManagerKeyFreeDiskSpace, AppVersionManagerKeyBatteryLevel, AppVersionManagerKeyFreeMemory, AppVersionManagerKeyMobileProvisionning, AppVersionManagerKeyPushToken,AppVersionManagerKeyWSConfiguration];
}
```
## WS / Token configuration  

Your datasource can optionally implements this 2 methods to help the Manager to find this 2 values.

+ getWSConfigurationForAppVersionManager
+ getpushTokenForAppVersionManager

# Usage in the real life 

# Present all informations

See the sample, a very classic TableView Controller (JMOViewController)

# Get informations one by one

```objective-c
[[AppInformationsManager sharedManager] infoForKey:AppVersionManagerKeyYouriOSVersion];
```

##Defined keys are :
```objective-c
AppVersionManagerKeyTargetedVersion             @"MinTargetedVersion"
AppVersionManagerKeyYouriOSVersion              @"iOSVersion"
AppVersionManagerKeyYourDeviceModel             @"DeviceModel"
AppVersionManagerKeyCompilationSDK              @"SDKUseForCompilation"
AppVersionManagerKeyWSConfiguration             @"WSConfiguration"  //From Datasource
AppVersionManagerKeyCFBundleVersion             @"Version"
AppVersionManagerKeyCFBundleShortVersionString  @"ShortVersionString"
AppVersionManagerKeyFreeDiskSpace               @"FreeDiskSpace"
AppVersionManagerKeyBatteryLevel                @"BatteryLevel"
AppVersionManagerKeyMobileProvisionning         @"MobileProvisionning"
AppVersionManagerKeyPushToken                   @"PushToken"  //From Datasource
AppVersionManagerKeyFreeMemory                  @"FreeMemory"
AppVersionManagerKeyOperator                    @"Operator"
AppVersionManagerKeyGraphicalPerformance        @"Has Good Graphical Performance"
```
##Customs key/values
###Add a custom value
```objective-c
[[AppInformationsManager sharedManager] addCustomValue:@"This is a custom value" forCustomKey:@"CustomKey1"];
```


