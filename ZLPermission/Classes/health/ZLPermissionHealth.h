//
//  ZLPermissionHealth.h
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//
#ifdef ZLPermissionRequestHealthEnabled

#import <ZLPermission/ZLPermission.h>
#import <HealthKit/HealthKit.h>
#import "ZLHKRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLPermissionHealth : NSObject
+ (ZLPermissionHealth *)share;
- (void)requestPermissionWithWriteTypes:(NSArray<HKQuantityTypeIdentifier > *)writeTypes
                              readTypes:(NSArray<HKQuantityTypeIdentifier > *)readTypesadTypes
                                success:(void(^)(NSArray<ZLHKRes *> *))success
                                failure:(void(^)(NSArray<ZLHKRes *> *))failure;
@end

NS_ASSUME_NONNULL_END
#endif
