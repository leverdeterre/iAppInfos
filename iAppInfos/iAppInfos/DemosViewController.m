//
//  DemosViewController.m
//  iAppInfos
//
//  Created by Jerome Morissard on 5/10/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "DemosViewController.h"
#import "JMOViewController.h"
#import "JMOLogMacro.h"
#import "iAppInfos.h"

@interface DemosViewController ()

@end

@implementation DemosViewController

- (IBAction)demo1Pressed:(id)sender
{
    JMOViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMOViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)demo2Pressed:(id)sender
{
    /*
    JMOViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMOViewController"];
    [self.navigationController pushViewController:vc animated:YES];
     */
    
    JMOLog(@"%@",[iAppInfos sharedInfo]);
}

@end
