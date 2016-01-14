//
//  ViewController.h
//  ETactBleStatusChecker
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBleReaderDelegate.h"

@interface ViewController : UIViewController <ETBleReaderDelegate, UITableViewDelegate, UITableViewDataSource>


@end

