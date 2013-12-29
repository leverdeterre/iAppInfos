//
//  JMOViewControllerProvisioningDetails.m
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "JMOViewControllerProvisioningDetails.h"
#import "JMOMobileProvisionning.h"
#import "JMOCell.h"

@interface JMOViewControllerProvisioningDetails ()

@end

@implementation JMOViewControllerProvisioningDetails

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrayOfStrings ) {
        return self.arrayOfStrings.count;
    }
    
    return self.info.summary.allKeys.count;
}

- (JMOCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JMOCell";
    JMOCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (self.arrayOfStrings ) {
        NSString *key = [self.arrayOfStrings objectAtIndex:indexPath.row];
        cell.labelKey.text = key;
        cell.labelInfo.text = @"";
    }
    else {
        NSString *key = [self.info.summary.allKeys objectAtIndex:indexPath.row];
        cell.labelKey.text = key;
        if ([[self.info.summary objectForKey:key] isKindOfClass:[NSArray class]]) {
            cell.labelInfo.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            cell.labelInfo.text = [[self.info.summary objectForKey:key] description];
        }
    }

    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrayOfStrings ) {
        return;
    }
    else {
        NSString *key = [self.info.summary.allKeys objectAtIndex:indexPath.row];
        if ([[self.info.summary objectForKey:key] isKindOfClass:[NSArray class]]) {
            NSArray *arr = [self.info.summary objectForKey:key];
            JMOViewControllerProvisioningDetails *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMOViewControllerProvisioningDetails"];
            vc.arrayOfStrings = arr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
