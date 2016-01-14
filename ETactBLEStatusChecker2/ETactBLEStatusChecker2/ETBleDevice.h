//
//  ETBleDevice.h
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETBleDevice : NSObject <NSCoding>

@property (nonatomic, strong) NSString * deviceID;
@property (nonatomic, strong) NSString * batteryLevel;
@property (nonatomic, strong) NSString * label;

@end
