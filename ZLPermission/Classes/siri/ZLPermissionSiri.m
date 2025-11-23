//
//  ZLPermissionSiri.m
//  FBSnapshotTestCase
//
//  Created by admin on 2025/11/21.
//

#import "ZLPermissionSiri.h"
#import <Intents/Intents.h>
@implementation ZLPermissionSiri
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLSiriAuthorizationStatusAuthorized;
}
- (ZLSiriAuthorizationStatus)getPermissionStatus {
    return [self parseStatus:[INPreferences siriAuthorizationStatus]];
}
- (ZLSiriAuthorizationStatus)parseStatus:(INSiriAuthorizationStatus)status {
    switch(status){
        case INSiriAuthorizationStatusNotDetermined:
            return ZLSiriAuthorizationStatusNotDetermined;
        case INSiriAuthorizationStatusDenied:
            return ZLSiriAuthorizationStatusDenied;
        case INSiriAuthorizationStatusRestricted:
            return ZLSiriAuthorizationStatusRestricted;
        case INSiriAuthorizationStatusAuthorized:
            return ZLSiriAuthorizationStatusAuthorized;
        default:
            return ZLSiriAuthorizationStatusDenied;
    }
}
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLSiriAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLSiriAuthorizationStatus status))failure {
    ZLSiriAuthorizationStatus status = [self getPermissionStatus];
    if (status == ZLSiriAuthorizationStatusNotDetermined) {
        if (@available(iOS 10.0, *)) {
            [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZLSiriAuthorizationStatus s = [self getPermissionStatus];
                    if (s == ZLSiriAuthorizationStatusAuthorized) {
                        if (success) success(YES,s);
                    } else {
                        if (failure) failure(YES,s);
                    }
                });
            }];
        } else {
            if (failure) failure(YES,ZLSiriAuthorizationStatusDenied);
        }
    } else if (status == ZLSiriAuthorizationStatusAuthorized) {
        if (success) success(NO,status);
    } else {
        if (failure) failure(NO,status);
    }
}


@end
