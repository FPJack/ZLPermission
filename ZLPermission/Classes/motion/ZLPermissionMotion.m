//
//  ZLPermissionMotion.m
//  ZLPermission-ZLPermission_Rrivacy
//
//  Created by admin on 2025/11/21.
//

#import "ZLPermissionMotion.h"
#import <CoreMotion/CoreMotion.h>
#define kMotionFinishedNotification @"kZLMotionFinishedNotificationPermission"
@interface ZLPermissionMotion ()
@property (nonatomic,strong) CMMotionActivityManager *motionActivityManager;
@end
@implementation ZLPermissionMotion
- (CMMotionActivityManager *)motionActivityManager API_AVAILABLE(ios(11.0)){
    @synchronized (self.class) {
        if (!_motionActivityManager) {
            _motionActivityManager = [[CMMotionActivityManager alloc] init];
            __weak typeof(self) weakSelf = self;
            NSDate *today = [NSDate new];
            [_motionActivityManager queryActivityStartingFromDate:today toDate:today toQueue:[NSOperationQueue mainQueue] withHandler:^(NSArray<CMMotionActivity *> *__nullable activities, NSError *__nullable error) {
                [self.motionActivityManager stopActivityUpdates];
                ZLMotionAuthorizationStatus s = [weakSelf getPermissionStatus];
                [NSNotificationCenter.defaultCenter postNotificationName:kMotionFinishedNotification object:weakSelf.motionActivityManager userInfo:@{@"status":@(s)}];
                self.motionActivityManager = nil;
            }];
        }
        return _motionActivityManager;
    }
}
- (BOOL)isActivityAvailable {
    return [CMMotionActivityManager isActivityAvailable];
}
- (BOOL)hasPermission {
    if (@available(iOS 11.0, *)) {
        return self.getPermissionStatus == ZLSiriAuthorizationStatusAuthorized;
    } else {
        return NO;
    }
}
- (ZLMotionAuthorizationStatus)getPermissionStatus API_AVAILABLE(ios(11.0)){
    return [self parseStatus:[CMMotionActivityManager authorizationStatus]];

}
- (ZLMotionAuthorizationStatus)parseStatus:(CMAuthorizationStatus)status API_AVAILABLE(ios(11.0)){
    switch(status){
        case CMAuthorizationStatusNotDetermined:
            return ZLMotionAuthorizationStatusNotDetermined;
        case CMAuthorizationStatusDenied:
            return ZLMotionAuthorizationStatusDenied;
        case CMAuthorizationStatusRestricted:
            return ZLMotionAuthorizationStatusRestricted;
        case CMAuthorizationStatusAuthorized:
            return ZLMotionAuthorizationStatusAuthorized;
        default:
            return ZLMotionAuthorizationStatusDenied;
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLMotionAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLMotionAuthorizationStatus status))failure API_AVAILABLE(ios(11.0)){
    ZLMotionAuthorizationStatus status = [self getPermissionStatus];
    if (status == ZLMotionAuthorizationStatusNotDetermined) {
        __block id observer;
        observer = [NSNotificationCenter.defaultCenter addObserverForName:kMotionFinishedNotification object:self.motionActivityManager queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
            [NSNotificationCenter.defaultCenter removeObserver:observer];
            observer = nil;
            NSNumber *status = [notification.userInfo valueForKey:@"status"];
            if (![status isKindOfClass:NSNumber.class]) return;
            NSInteger intValue = status.integerValue;
            switch (intValue) {
                case ZLMotionAuthorizationStatusNotDetermined:
                    break;
                case ZLMotionAuthorizationStatusAuthorized: {
                    if (success) success(YES,intValue);
                }
                    break;
                case ZLMotionAuthorizationStatusDenied:
                case ZLMotionAuthorizationStatusRestricted: {
                    if (failure) failure(YES,intValue);
                    break;
                }
            }
        }];
    } else if (status == ZLMotionAuthorizationStatusAuthorized) {
        if (success) success(NO,status);
    } else {
        if (failure) failure(NO,status);
    }
}
@end
