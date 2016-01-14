//
//  ViewController.m
//  ETactBleStatusChecker
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import "ViewController.h"
#import "ETBleController.h"
#import "ETBleDataHelper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bleStatusLabel;
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (weak, nonatomic) IBOutlet UISwitch *bleSwitch;

@property (nonatomic, strong) ETBleController * bleReader;
@property (strong, nonatomic) NSMutableDictionary * devices;
@property (strong, nonatomic) NSArray * values;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.bleReader = [[ETBleController alloc] init];
    self.devices = [[NSMutableDictionary alloc] init];
    self.bleReader.delegate = self;
    [self.bleSwitch setOn:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.devices count];
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETBleData * data = [self.values objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UITextField * deviceID = (UITextField *) [cell viewWithTag:101];
    deviceID.text = [self deviceIDToLabel:data.deviceID];
    
    UILabel * batteryLevel = [(UILabel *) cell viewWithTag:102];
    batteryLevel.text = [NSString stringWithFormat:@"%@",[ETBleDataHelper dataToBatteryLevel:data]];
    
    NSLog(@"DeviceId:%@",[ETBleDataHelper dataToDeviceID:data]);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(NSString *) deviceIDToLabel:(NSString *)deviceID {
    
    
    
    if ([deviceID isEqualToString:@"A5811BB4-AAD8-08D6-8F74-A2F608FCC538"]) {
        return @"0B";
    }
    
    if ([deviceID isEqualToString:@"FC39552D-5A7F-9555-A455-0010D9707D91"]) {
        return @"0C";
    }
    
    return @"FF";
}

#pragma mark ble delegate
-(void)didUpdateState:(CBCentralManagerState)state {
    switch (state) {
        case CBCentralManagerStatePoweredOff:
            self.bleStatusLabel.text = @"BT off";
            break;
            
        case CBCentralManagerStatePoweredOn:
            self.bleStatusLabel.text = @"BT on";
            break;
            
        case CBCentralManagerStateUnauthorized:
            self.bleStatusLabel.text = @"BT unauthorized";
            break;
            
        case CBCentralManagerStateUnsupported:
            self.bleStatusLabel.text = @"BT unsupported";
            break;
            
        case CBCentralManagerStateUnknown:
            self.bleStatusLabel.text = @"BT unknown";
            break;
            
        case CBCentralManagerStateResetting:
            self.bleStatusLabel.text = @"BT ressetting";
            break;
            
        default:
            self.bleStatusLabel.text = @"Unavailable";
            break;
    }

}

-(void)didReceiveValue:(ETBleData *)value {
    [self.devices setObject:value forKey:value.deviceID];
    self.values = [self.devices allValues];
    [self.tableView reloadData];
}

- (IBAction)bleSwitchValueChanged:(id)sender {
    self.bleSwitch.isOn?[self.bleReader startScanning]: [self.bleReader stopScanning];
}
@end
