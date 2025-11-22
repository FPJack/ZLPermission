//
//  ZLPermissionHealth.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//
#ifdef ZLPermissionRequestHealthEnabled

#import "ZLPermissionHealth.h"
#import <HealthKit/HealthKit.h>


static ZLPermissionHealth *health;
@implementation ZLPermissionHealth
+ (ZLPermissionHealth *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        health  = ZLPermissionHealth.new;
    });
    return health;
}
- (BOOL)isHealthDataAvailable {
    return [HKHealthStore isHealthDataAvailable];
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

- (ZLHealthAuthorizationStatus)getPermissionStatusWithHKObjectType:(HKQuantityTypeIdentifier)quantityTypeIdentifier {
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    HKAuthorizationStatus status = [healthStore authorizationStatusForType:[HKObjectType quantityTypeForIdentifier:quantityTypeIdentifier]];
    return [self parseStatus:status];
}


- (void)requestPermissionWithWriteTypes:(NSArray<HKQuantityTypeIdentifier > *)writeTypes
                              readTypes:(NSArray<HKQuantityTypeIdentifier > *)readTypesadTypes
                                success:(void(^)(NSArray<ZLHKRes *> *))success
                                failure:(void(^)(NSArray<ZLHKRes *> *))failure {
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSMutableArray<ZLHKRes *> *arr = NSMutableArray.array;
    NSMutableSet *writes = NSMutableSet.new;
    [writeTypes   enumerateObjectsUsingBlock:^(HKQuantityTypeIdentifier  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZLHKRes *res = ZLHKRes.new;
        res.status = ZLHealthAuthorizationStatusDenied;
        res.identifier = obj;
        HKObjectType *objectType =  [HKObjectType quantityTypeForIdentifier:obj];
        res.isFirst = [self parseStatus:[healthStore authorizationStatusForType:objectType]] == ZLHealthAuthorizationStatusNotDetermined;
        [writes addObject:objectType];
        [arr addObject:res];
    }];
    
    
    NSMutableSet *reads = NSMutableSet.new;
    [readTypesadTypes enumerateObjectsUsingBlock:^(HKQuantityTypeIdentifier  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZLHKRes *res = ZLHKRes.new;
        res.status = ZLHealthAuthorizationStatusDenied;
        res.identifier = obj;
        HKObjectType *objectType =  [HKObjectType quantityTypeForIdentifier:obj];
        res.isFirst = [self parseStatus:[healthStore authorizationStatusForType:objectType]] == ZLHealthAuthorizationStatusNotDetermined;
        [reads addObject:objectType];
        [arr addObject:res];
    }];
   
    if (![HKHealthStore isHealthDataAvailable]) {
        if (failure) failure(arr);
        return;
    }

   
    [healthStore requestAuthorizationToShareTypes:writes
                                         readTypes:reads
                                        completion:^(BOOL successRes, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [arr enumerateObjectsUsingBlock:^(ZLHKRes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HKObjectType *objectType =  [HKObjectType quantityTypeForIdentifier:obj.identifier];
                obj.status = [self parseStatus:[healthStore authorizationStatusForType:objectType]];
                obj.error = error;
            }];
            if (successRes) {
                if (success) success(arr);
            } else {
                if (failure) failure(arr);
            }
        });
    }];
}
@end
#endif
