//
//  JMOViewController.m
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "JMOViewController.h"
#import "JMOViewControllerProvisioningDetails.h"

#import "JMOCell.h"
#import "JMOLogMacro.h"

#import "iAppInfos.h"

#define CustomKey1 @"CustomKey1"

@interface JMOViewController ()
@property (nonatomic, strong) NSArray *properties;
@end

@implementation JMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"iAppInfos";
    
    [[iAppInfos sharedInfo] addCustomValue:@"This is a custom value" forCustomKey:CustomKey1];
    self.properties = [[iAppInfos sharedInfo] filteredKeys];
    self.tableView.dataSource = self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.properties.count;
}

- (JMOCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JMOCell";
    JMOCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *key = [self.properties objectAtIndex:indexPath.row];
    id info = [[iAppInfos sharedInfo] infoForKey:key];
    
    cell.labelKey.text = key;
    
    if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
        if (nil == info) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.labelInfo.text = @"No info ...";
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.labelInfo.text = @"Lot's of infos :)";
        }
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([info isKindOfClass:[NSString class]]) {
            cell.labelInfo.text = (NSString *)info;
        } else {
            cell.labelInfo.text = [NSString stringWithFormat:@"%@ Mo",info];
        }
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.properties objectAtIndex:indexPath.row];
    
    if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
        JMOMobileProvisionning *info = [[iAppInfos sharedInfo] infoForKey:key];

        if (info == nil) {
            return;
        }
        
        JMOViewControllerProvisioningDetails *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMOViewControllerProvisioningDetails"];
        vc.info = info;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - AppInformationsManagerDatasource

- (NSArray *)desiredKeysForAppVersionManager:(iAppInfos *)manager
{
    return @[AppVersionManagerKeyTargetedVersion,
             AppVersionManagerKeyYouriOSVersion,
             AppVersionManagerKeyYourDeviceModel,
             AppVersionManagerKeyCompilationSDK,
             AppVersionManagerKeyCFBundleVersion,
             AppVersionManagerKeyCFBundleShortVersionString,
             AppVersionManagerKeyFreeDiskSpace,
             AppVersionManagerKeyFreeMemory,
             AppVersionManagerKeyBatteryLevel,
             AppVersionManagerKeyMobileProvisionning,
             AppVersionManagerKeyPushToken,
             AppVersionManagerKeyWSConfiguration,
             AppVersionManagerKeyOperator,
             AppVersionManagerKeyGraphicalPerformance,
             CustomKey1];
}

- (NSString *)getWSConfigurationForAppVersionManager:(iAppInfos *)manager
{
    JMOLog(@"Return WS url ? or something to identified your WS configuration");
    return @"Dev";
}

- (NSString *)getpushTokenForAppVersionManager:(iAppInfos *)manager
{
    JMOLog(@"Are you storing the token somewhere?");
    return @"";
}

@end
