//
//  ETBleDeviceUpdateDelegate.h
//  ETactBLEStatusChecker2
//
//  Created by Nicolas Linard on 13/01/2016.
//  Copyright © 2016 MEDES. All rights reserved.
//

#ifndef ETBleDeviceUpdateDelegate_h
#define ETBleDeviceUpdateDelegate_h

#import "ETBleDevice.h"
@protocol ETBleDeviceUpdateDelegate <NSObject>

-(void) didUpdateDeviceInfos:(ETBleDevice *) device;

@end

#endif /* ETBleDeviceUpdateDelegate_h */
