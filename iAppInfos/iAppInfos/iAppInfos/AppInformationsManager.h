//
//  AppInformationsManager.h
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppVersionManagerKeyTargetedVersion             @"MinTargetedVersion"
#define AppVersionManagerKeyYouriOSVersion              @"iOSVersion"
#define AppVersionManagerKeyYourDeviceModel             @"DeviceModel"
#define AppVersionManagerKeyCompilationSDK              @"SDKUseForCompilation"
#define AppVersionManagerKeyWSConfiguration             @"WSConfiguration"  //From Datasource
#define AppVersionManagerKeyCFBundleVersion             @"Version"
#define AppVersionManagerKeyCFBundleShortVersionString  @"ShortVersionString"
#define AppVersionManagerKeyFreeDiskSpace               @"FreeDiskSpace"
#define AppVersionManagerKeyBatteryLevel                @"BatteryLevel"
#define AppVersionManagerKeyMobileProvisionning         @"MobileProvisionning"
#define AppVersionManagerKeyPushToken                   @"PushToken" //From Datasource
#define AppVersionManagerKeyFreeMemory                  @"FreeMemory"
#define AppVersionManagerKeyOperator                    @"Operator"
#define AppVersionManagerKeyGraphicalPerformance        @"Has Good Graphical Performance"

@class AppInformationsManager;
@protocol AppInformationsManagerDatasource <NSObject>
@optional
- (NSArray *)desiredKeysForAppVersionManager:(AppInformationsManager *)manager;
- (NSString *)getWSConfigurationForAppVersionManager:(AppInformationsManager *)manager;
- (NSString *)getpushTokenForAppVersionManager:(AppInformationsManager *)manager;
@end


@interface AppInformationsManager : NSObject

@property (weak, nonatomic) id <AppInformationsManagerDatasource> datasource;

+ (instancetype)sharedManager;
- (NSArray*)observedProperties;
- (void)addCustomValue:(NSString *)value forCustomKey:(NSString *)key;
- (id)infoForKey:(NSString *)key;
- (NSString *)htmlDescriptionWithKeys:(NSArray *)keys;

@end