//
//  DetailViewController.h
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBleDeviceUpdateDelegate.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *deviceLabelTextfield;

@property (nonatomic) id<ETBleDeviceUpdateDelegate> delegate;

@end

