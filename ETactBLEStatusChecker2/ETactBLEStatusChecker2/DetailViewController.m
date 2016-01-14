//
//  DetailViewController.m
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import "DetailViewController.h"
#import "ETBleDevice.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        
        self.deviceLabelTextfield.text = ((ETBleDevice *)self.detailItem).label;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.deviceLabelTextfield resignFirstResponder];
    [self endEditing];
    return NO;
}

-(void)endEditing {
    ((ETBleDevice *)self.detailItem).label =self.deviceLabelTextfield.text;
    [self.delegate didUpdateDeviceInfos:((ETBleDevice *)self.detailItem)];
    [self.navigationController.navigationController popViewControllerAnimated:YES];
}

-(IBAction)done:(id)sender {
    [self endEditing];
}

@end
