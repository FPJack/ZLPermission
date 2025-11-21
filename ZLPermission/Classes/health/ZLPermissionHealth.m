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
- (ZLHealthAuthorizationStatus)getPermissionStatusWithHKObjectType:(HKObjectType *)objectType {
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    HKAuthorizationStatus status = [healthStore authorizationStatusForType:objectType];
    return [self parseStatus:status];
}


//- (void)requestPermissionWithWriteTypes:(NSSet<HKQuantityTypeIdentifier *> *)writeTypes
//                              readTypes:(NSSet<HKQuantityTypeIdentifier *> *)rereadTypesadTypes
//                                success:(void(^)(ZLHKRes *res))success
//                                failure:(void(^)(ZLHKRes *res))failure {
//
//    if (![HKHealthStore isHealthDataAvailable]) {
//        if (failure) failure(YES, ZLHealthAuthorizationStatusDenied);
//        return;
//    }
//
//    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
//
//    NSSet *readTypes = [NSSet setWithObjects:
//                        [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
//                        [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
//                        nil];
//
//    NSSet *writeTypes = [NSSet setWithObjects:
//                         [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
//                         nil];
//
//    NSMutableSet *allTypes = [NSMutableSet set];
//    [allTypes unionSet:readTypes];
//    [allTypes unionSet:writeTypes];
//
//    // 判断是否为首次请求
//    BOOL isFirst = NO;
//    for (HKObjectType *type in allTypes) {
//        if ([healthStore authorizationStatusForType:type] == HKAuthorizationStatusNotDetermined) {
//            isFirst = YES;
//            break;
//        }
//    }
//
//    // 只调用一次
//    [healthStore requestAuthorizationToShareTypes:writeTypes
//                                         readTypes:readTypes
//                                        completion:^(BOOL successRes, NSError *error) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (successRes) {
//                if (success) success(isFirst, ZLHealthAuthorizationStatusAuthorized);
//            } else {
//                if (failure) failure(isFirst, ZLHealthAuthorizationStatusDenied);
//            }
//        });
//    }];
//}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirstRequest, ZLHealthAuthorizationStatus status) {
        if (failure) failure(isFirstRequest,status,ZLPermissionTypeHealth);
    }];
}

@end
