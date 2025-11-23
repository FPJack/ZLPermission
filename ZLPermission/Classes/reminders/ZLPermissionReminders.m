//
//  ZLPermissionReminders.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionReminders.h"
#import <EventKit/EventKit.h>

@implementation ZLPermissionReminders
- (ZLEventAuthorizationStatus)parseStatus:(EKAuthorizationStatus)status {
    switch(status){
        case EKAuthorizationStatusNotDetermined:
            return ZLEventAuthorizationStatusNotDetermined;
        case EKAuthorizationStatusRestricted:
            return ZLEventAuthorizationStatusRestricted;
        case EKAuthorizationStatusDenied:
            return ZLEventAuthorizationStatusDenied;
        case EKAuthorizationStatusFullAccess:
            return ZLEventAuthorizationStatusFullAccess;
        case EKAuthorizationStatusWriteOnly:
            return ZLEventAuthorizationStatusWriteOnly;
        default:
            return ZLEventAuthorizationStatusDenied;
    }
}
- (BOOL)hasPermission {
    ZLEventAuthorizationStatus status = [self getPermissionStatus];
    return status == ZLEventAuthorizationStatusFullAccess || status == ZLEventAuthorizationStatusWriteOnly;
}
- (ZLEventAuthorizationStatus)getPermissionStatus {
    return [self parseStatus:[EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]];
}
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure {
    ZLEventAuthorizationStatus status = [self getPermissionStatus];
    switch (status) {
        case ZLEventAuthorizationStatusFullAccess: {
            if (success) success(NO,status);
        } break;
        case ZLEventAuthorizationStatusNotDetermined:
        {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            if (@available(iOS 17.0, *)) {
                [eventStore requestFullAccessToRemindersWithCompletion:^(BOOL granted, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) success(YES,[self getPermissionStatus]);
                    });
                }];
            } else {
                [eventStore requestAccessToEntityType:EKEntityTypeReminder
                                           completion:^(BOOL granted, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) success(YES,[self getPermissionStatus]);
                    });
                }];
            }
        }
            break;
        case ZLEventAuthorizationStatusRestricted:
        case ZLEventAuthorizationStatusDenied: {
            if (failure) failure(NO,status);
        }
            break;
        case ZLEventAuthorizationStatusWriteOnly:{
            if (success) success(NO,status);
        }
            
            break;
    }
}

@end
