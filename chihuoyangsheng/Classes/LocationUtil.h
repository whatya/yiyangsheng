//
//  LocationUtil.h
//  chihuoyangsheng
//
//  Created by BobZhang on 14-9-28.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationUtil : NSObject<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
- (void)initLocationManager;
- (void)startLocate;
+(int)distansFromGPS:(CLLocation*)locaton toAnotherLocation:(CLLocation*)anotherLocation;
@end
