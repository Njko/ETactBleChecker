//
//  ETBleDevice.m
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import "ETBleDevice.h"

@implementation ETBleDevice

-(NSString *)description {
    return [NSString stringWithFormat:@"Device ID:%@ Battery Level:%@",self.label, self.batteryLevel];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _batteryLevel = [aDecoder decodeObjectForKey:@"batteryLevel"];
        _deviceID = [aDecoder decodeObjectForKey:@"deviceID"];
        _label = [aDecoder decodeObjectForKey:@"label"];
    }
    return self;
}


-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.label forKey:@"label"];
    [aCoder encodeObject:self.deviceID forKey:@"deviceID"];
    [aCoder encodeObject:self.batteryLevel forKey:@"batteryLevel"];
}

@end
