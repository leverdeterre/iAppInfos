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

#import "AppInformationsManager.h"

#define CustomKey1 @"CustomKey1"

@interface JMOViewController () <AppInformationsManagerDatasource>
@property (nonatomic, strong) NSArray *properties;
@end

@implementation JMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"iAppInfos";
    
    [AppInformationsManager sharedManager].datasource = self;
    [[AppInformationsManager sharedManager] addCustomValue:@"CustomValue" forCustomKey:CustomKey1];
    
    self.properties = [[AppInformationsManager sharedManager].datasource desiredAppVersionManagerKeys];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@", [AppInformationsManager sharedManager]);
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
    id info = [[AppInformationsManager sharedManager] infoForKey:key];
    
    cell.labelKey.text = key;
    
    if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
        if (nil == info) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.labelInfo.text = @"no info ... ";
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.labelInfo.text = @"Lot's of info";
        }
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.labelInfo.text = (NSString *)info;
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.properties objectAtIndex:indexPath.row];
    
    if ([key isEqualToString:AppVersionManagerKeyMobileProvisionning]) {
        JMOMobileProvisionning *info = [[AppInformationsManager sharedManager] infoForKey:key];

        if (info == nil) {
            return;
        }
        
        JMOViewControllerProvisioningDetails *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMOViewControllerProvisioningDetails"];
        vc.info = info;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark AppInformationsManagerDatasource

- (NSArray *)desiredAppVersionManagerKeys
{
    return @[AppVersionManagerKeyTargetedVersion,AppVersionManagerKeyYouriOSVersion,AppVersionManagerKeyYourDeviceModel,AppVersionManagerKeyCompilationSDK, AppVersionManagerKeyCFBundleVersion, AppVersionManagerKeyCFBundleShortVersionString, AppVersionManagerKeyFreeDiskSpace, AppVersionManagerKeyBatteryLevel,AppVersionManagerKeyMobileProvisionning, AppVersionManagerKeyPushToken,
             CustomKey1];
}

- (NSString *)getWSConfigurationForAppVersionManager:(AppInformationsManager *)manager
{
    NSLog(@"Return WS host ? or something to identified your WS configuration");
    return @"WS integration";
}

- (NSString *)getpushTokenForAppVersionManager:(AppInformationsManager *)manager
{
    return @"";
}
@end
