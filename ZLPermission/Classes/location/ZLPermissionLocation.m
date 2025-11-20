//
//  ZLPermissionLocation.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionLocation.h"
#import <CoreLocation/CoreLocation.h>
#define kLocationFinishedNotification @"kGMLocationFinishedNotification"
@interface ZLPermissionLocation()<CLLocationManagerDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;
@end
@implementation ZLPermissionLocation
- (CLLocationManager *)locationManager {
    @synchronized (self.class) {
        if (!_locationManager) {
            _locationManager = [[CLLocationManager alloc] init];
        }
        return _locationManager;
    }
}
- (BOOL)systemLocationServicesEnabled {
    return CLLocationManager.locationServicesEnabled;
}
- (BOOL)hasPermission {
    ZLLocationAuthorizationStatus status = [self getPermissionStatus];
    return status == ZLLocationAuthorizationStatusAlways || status == ZLLocationAuthorizationStatusWhenInUse;
}
- (ZLLocationAuthorizationStatus )getPermissionStatus{
    if (@available(iOS 14,*))
    {
        return [self parseStatus:self.locationManager.authorizationStatus] ;
    }
    return [self parseStatus:CLLocationManager.authorizationStatus];
}
- (ZLLocationAuthorizationStatus)parseStatus:(CLAuthorizationStatus)status {
    switch(status){
        case kCLAuthorizationStatusNotDetermined:
            return ZLLocationAuthorizationStatusNotDetermined;
        case kCLAuthorizationStatusRestricted:
            return ZLLocationAuthorizationStatusRestricted;
        case kCLAuthorizationStatusDenied:
            return ZLLocationAuthorizationStatusDenied;
        case kCLAuthorizationStatusAuthorizedAlways:
            return ZLLocationAuthorizationStatusAlways;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return ZLLocationAuthorizationStatusWhenInUse;
        default:
            return ZLLocationAuthorizationStatusDenied;
    }
}
- (void)startLocation {
    self.locationManager.delegate = self;
    if (self.getPermissionStatus == ZLLocationAuthorizationStatusNotDetermined) {
        BOOL hasAlwaysKey = [[NSBundle mainBundle]
                             objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;
        BOOL hasWhenInUseKey =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] !=
        nil;
        if (hasAlwaysKey) {
            [self.locationManager requestAlwaysAuthorization];
        } else if (hasWhenInUseKey) {
            [self.locationManager requestWhenInUseAuthorization];
        } else {
            NSAssert(hasAlwaysKey || hasWhenInUseKey,
                     @"To use location services in iOS 8+, your Info.plist must "
                     @"provide a value for either "
                     @"NSLocationWhenInUseUsageDescription or "
                     @"NSLocationAlwaysUsageDescription.");
        }
    }
}
- (void)stopLocation
{
    if (!_locationManager) return;
    self.locationManager = nil;
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    ZLLocationAuthorizationStatus gmStatus = [self parseStatus:status];
    if (gmStatus == ZLLocationAuthorizationStatusNotDetermined) return;
    [NSNotificationCenter.defaultCenter postNotificationName:kLocationFinishedNotification object:self.locationManager userInfo:@{@"status":@(gmStatus)}];
}
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    ZLLocationAuthorizationStatus status = [self getPermissionStatus];
    if (status == ZLLocationAuthorizationStatusNotDetermined) return;
    [NSNotificationCenter.defaultCenter postNotificationName:kLocationFinishedNotification object:self.locationManager userInfo:@{@"status":@(status)}];
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))failure{
    ZLLocationAuthorizationStatus authorizationStatus = [self getPermissionStatus];
    NSString *key = @"ZLPermissionLocation";
    BOOL isFirst = ![NSUserDefaults.standardUserDefaults boolForKey:key];
    switch (authorizationStatus) {
        case ZLLocationAuthorizationStatusNotDetermined:
        {
            __block NSObject* observer;
            observer = [NSNotificationCenter.defaultCenter addObserverForName:kLocationFinishedNotification object:self.locationManager queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
                NSNumber *status = [notification.userInfo valueForKey:@"status"];
                if (![status isKindOfClass:NSNumber.class]) return;
                NSInteger intValue = status.intValue;
                switch (intValue) {
                    case ZLLocationAuthorizationStatusNotDetermined:
                        break;
                    case ZLLocationAuthorizationStatusWhenInUse:
                    case ZLLocationAuthorizationStatusAlways: {
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        if (success) success(YES && isFirst,intValue);
                        [NSNotificationCenter.defaultCenter removeObserver:observer];
                        observer = nil;
                    }
                        break;
                    case ZLLocationAuthorizationStatusDenied:
                    case ZLLocationAuthorizationStatusRestricted: {
                        if (failure) failure(YES,intValue);
                        [NSNotificationCenter.defaultCenter removeObserver:observer];
                        observer = nil;
                        break;
                    }
                }
                [self stopLocation];
            }];
            [self startLocation];
        }
            break;
        case ZLLocationAuthorizationStatusWhenInUse:
        case ZLLocationAuthorizationStatusAlways: {
            if (success) success(NO,authorizationStatus);
        }
            break;
        case ZLLocationAuthorizationStatusDenied:
        case ZLLocationAuthorizationStatusRestricted: {
            if (failure) failure(NO,authorizationStatus);
            break;
        }
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirst, ZLLocationAuthorizationStatus status) {
        if (failure) failure(isFirst,status,ZLPermissionTypeLocation);
    }];
}
- (void)requestSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    [self requestPermissionWithSuccess:^(BOOL isFirst, ZLLocationAuthorizationStatus status) {
        if (success) success();
    } failure:^(BOOL isFirst, ZLLocationAuthorizationStatus status) {
        if (failure) failure();
    }];
}
@end
