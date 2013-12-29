//
//  JMOTableViewController.m
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "JMOTableViewController.h"
#import "JMOAppDelegate.h"

@interface JMOTableViewController ()

@end

@implementation JMOTableViewController

#pragma mark mailComposeController

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
