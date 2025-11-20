//
//  ZLPermissionTracking.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionTracking.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
@implementation ZLPermissionTracking
- (ZLAuthorizationStatus)parseStatus:(ATTrackingManagerAuthorizationStatus)status  API_AVAILABLE(ios(14)){
    switch(status){
        case ATTrackingManagerAuthorizationStatusNotDetermined:
            return ZLAuthorizationStatusNotDetermined;
        case ATTrackingManagerAuthorizationStatusRestricted:
            return ZLAuthorizationStatusRestricted;
        case ATTrackingManagerAuthorizationStatusDenied:
            return ZLAuthorizationStatusDenied;
        case ATTrackingManagerAuthorizationStatusAuthorized:
            return ZLAuthorizationStatusAuthorized;
        default:
            return ZLAuthorizationStatusDenied;
    }
}
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLAuthorizationStatusAuthorized;
}
- (ZLAuthorizationStatus)getPermissionStatus {
    if (@available(iOS 14, *)) {
        return [self parseStatus:ATTrackingManager.trackingAuthorizationStatus];

    } else {
        return ASIdentifierManager.sharedManager.isAdvertisingTrackingEnabled ? ZLAuthorizationStatusAuthorized : ZLAuthorizationStatusDenied;
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure{
    ZLAuthorizationStatus status = self.getPermissionStatus;
    switch (status) {
        case ZLAuthorizationStatusNotDetermined:
        {
            if (@available(iOS 14, *)) {
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                            if (success) success(YES,[self parseStatus:status]);
                        }
                        else if (status == ATTrackingManagerAuthorizationStatusNotDetermined) {
                            NSLog(@"app 启动的时候延迟调用才能正确弹窗");
                            if (failure) failure(YES,[self parseStatus:status]);
                        }else {
                            if (failure) failure(YES,[self parseStatus:status]);
                        }
                    });
                }];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
        case ZLAuthorizationStatusRestricted:
        case ZLAuthorizationStatusDenied:
        {
            if (failure) failure(NO,NO);
        }
            break;
        case ZLAuthorizationStatusAuthorized:
        {
            if (success) success(NO,NO);
        }
        default:
            break;
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirst, ZLAuthorizationStatus status) {
        if (failure) failure(isFirst,status,ZLPermissionTypeTracking);
    }];
}
- (void)requestSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    [self requestPermissionWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
        if (success) success();
    } failure:^(BOOL isFirst, ZLAuthorizationStatus status) {
        if (failure) failure();
    }];
}
@end
