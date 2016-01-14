//
//  MasterViewController.m
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *bleSwitch;
@property (weak, nonatomic) IBOutlet UILabel *bleStatusLabel;

@property (nonatomic, strong) ETBleController * bleReader;
@property (strong, nonatomic) NSMutableDictionary * devices;
@property (strong, nonatomic) NSArray * values;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.bleReader = [[ETBleController alloc] init];
    self.devices = [self unarchiveStoredDevices];
    if(!self.devices) {
        self.devices = [[NSMutableDictionary alloc] init];
    } else {
        self.values = [self.devices allValues];
    }
    self.bleReader.delegate = self;
    self.bleStatusLabel.text = @"BT off";
    [self.bleSwitch setOn:NO];
    [super viewDidLoad];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self archiveStordeDevices];
}

- (NSMutableDictionary *) unarchiveStoredDevices {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [defaults objectForKey:@"storedDevices"];
    if (data) {
        return [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    
    return nil;
}

- (void) archiveStordeDevices {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.devices];
    [defaults setObject:data forKey:@"storedDevices"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ETBleDevice *object = self.values[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.delegate = self;
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ETBleDevice * object = self.values[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
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
    
    ETBleDevice * device = [self.devices objectForKey:value.deviceID];
    if (!device) {
        device = [[ETBleDevice alloc] init];
        device.deviceID = value.deviceID;
        device.label = @"Undefinied";
    }
    device.batteryLevel = [NSString stringWithFormat:@"%@",[ETBleDataHelper dataToBatteryLevel:value] ];
    
    [self.devices setObject:device forKey:value.deviceID];
    self.values = [self.devices allValues];
    [self.tableView reloadData];
}

- (IBAction)bleSwitchValueChanged:(id)sender {
    self.bleSwitch.isOn?[self.bleReader startScanning]: [self.bleReader stopScanning];
}

#pragma mark - detailDelegate
-(void) didUpdateDeviceInfos:(ETBleDevice *)updatedDevice {
    ETBleDevice * device = [self.devices objectForKey:updatedDevice.deviceID];
    device.label = [NSString stringWithString:updatedDevice.label];
    
    [self.devices setObject:device forKey:device.deviceID];
    self.values = [self.devices allValues];
    
    [self.tableView reloadData];
}


@end
