//
//  JMOViewControllerProvisioningDetails.h
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMOTableViewController.h"

@class JMOMobileProvisionning;
@interface JMOViewControllerProvisioningDetails : JMOTableViewController

@property (strong, nonatomic) JMOMobileProvisionning *info;
@property (strong, nonatomic) NSArray *arrayOfStrings;

@end
