//
//  MasterViewController.h
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBleController.h"
#import "ETBleDataHelper.h"
#import "ETBleDevice.h"
#import "ETBleDataHelper.h"
#import "ETBleDeviceUpdateDelegate.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <ETBleReaderDelegate,ETBleDeviceUpdateDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

