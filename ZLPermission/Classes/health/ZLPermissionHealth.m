//
//  ZLPermissionHealth.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionHealth.h"
#import <HealthKit/HealthKit.h>

@implementation ZLPermissionHealth
- (BOOL)isHealthDataAvailable {
    return [HKHealthStore isHealthDataAvailable];
}
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLHealthAuthorizationStatusAuthorized;
}
- (ZLHealthAuthorizationStatus)parseStatus:(HKAuthorizationStatus)status {
    switch(status){
        case HKAuthorizationStatusNotDetermined:
            return ZLHealthAuthorizationStatusNotDetermined;
        case HKAuthorizationStatusSharingAuthorized:
            return ZLHealthAuthorizationStatusAuthorized;
        case HKAuthorizationStatusSharingDenied:
            return ZLHealthAuthorizationStatusDenied;
        default:
            return ZLHealthAuthorizationStatusDenied;
    }
}
- (ZLHealthAuthorizationStatus)getPermissionStatus {
   
    
    NSMutableSet *readTypes = [NSMutableSet set];
    NSMutableSet *writeTypes = [NSMutableSet set];
    
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSMutableSet *allTypes = [NSMutableSet set];
    [allTypes unionSet:readTypes];
    [allTypes unionSet:writeTypes];
    for (HKObjectType *sampleType in allTypes) {
        HKAuthorizationStatus status = [healthStore authorizationStatusForType:sampleType];
        return [self parseStatus:status];
    }
    
    return ZLHealthAuthorizationStatusDenied;
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))failure {
    if (![HKHealthStore isHealthDataAvailable])
    {
        if (failure) failure(YES, self.getPermissionStatus);
        return;
    }
//    NSMutableSet *readTypes = [NSMutableSet set];
//    NSMutableSet *writeTypes = [NSMutableSet set];
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    
    // 读取权限
    NSSet *readTypes = [NSSet setWithObjects:
                        [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],   // 步数
                        [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],      // 身高
                        nil];

    // 写入权限
    NSSet *writeTypes = [NSSet setWithObjects:
                         [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],  // 体重
                         nil];
    
    NSMutableSet *allTypes = [NSMutableSet set];
    [allTypes unionSet:readTypes];
    [allTypes unionSet:writeTypes];
    if (allTypes.count <= 0 ) {
        if (failure) failure(NO, ZLHealthAuthorizationStatusDenied);
        return;
    }
    
    for (HKObjectType *healthType in allTypes) {
        HKAuthorizationStatus status = [healthStore authorizationStatusForType:healthType];
        switch (status) {
            case HKAuthorizationStatusNotDetermined:
            {
                    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
                    [healthStore requestAuthorizationToShareTypes:writeTypes
                                                        readTypes:readTypes
                                                       completion:^(BOOL successRes, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (successRes) {
                                if (success) success(YES,ZLHealthAuthorizationStatusAuthorized);
                            }else {
                                if (failure) failure(YES,ZLHealthAuthorizationStatusDenied);
                            }
        
                        });
                    }];
            }
                break;
            case HKAuthorizationStatusSharingAuthorized: {
                if (success) success(YES,ZLHealthAuthorizationStatusAuthorized);
            } break;
            case HKAuthorizationStatusSharingDenied: {
                if (failure) failure(YES,ZLHealthAuthorizationStatusDenied);
            } break;
        }
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirstRequest, ZLHealthAuthorizationStatus status) {
        if (failure) failure(isFirstRequest,status,ZLPermissionTypeHealth);
    }];
}

@end
