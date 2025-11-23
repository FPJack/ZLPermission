//
//  ZLPermissionNotification.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionNotification.h"
#import <UserNotifications/UserNotifications.h>

@implementation ZLPermissionNotification
- (BOOL)hasPermission {
    ZLNotificationAuthorizationStatus status = [self getPermissionStatus];
    return status == ZLNotificationAuthorizationStatusAuthorized
    || status == ZLNotificationAuthorizationStatusProvisional
    || status == ZLNotificationAuthorizationStatusEphemeral;
}

- (ZLNotificationAuthorizationStatus)parseStatus:(UNAuthorizationStatus)status {
    switch(status){
        case UNAuthorizationStatusNotDetermined:
            return ZLNotificationAuthorizationStatusNotDetermined;
        case UNAuthorizationStatusAuthorized:
            return ZLNotificationAuthorizationStatusAuthorized;
        case UNAuthorizationStatusDenied:
            return ZLNotificationAuthorizationStatusDenied;
        case UNAuthorizationStatusProvisional:
            return ZLNotificationAuthorizationStatusProvisional;
        case UNAuthorizationStatusEphemeral:
            return ZLNotificationAuthorizationStatusEphemeral;
        default:
            return ZLNotificationAuthorizationStatusDenied;
    }
}

- (ZLNotificationAuthorizationStatus)getPermissionStatus {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);

    __block UNAuthorizationStatus authorizationStatus;
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        authorizationStatus = settings.authorizationStatus;
        dispatch_semaphore_signal(sem);
    }];
    dispatch_semaphore_wait(sem , DISPATCH_TIME_FOREVER);
    return [self parseStatus:authorizationStatus];
}
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLNotificationAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLNotificationAuthorizationStatus status))failure {
    ZLNotificationAuthorizationStatus status = [self getPermissionStatus];
    if (status == ZLNotificationAuthorizationStatusNotDetermined) {
        NSString *key = @"ZLPermissionNotificationKey";
        BOOL isFirst = ![NSUserDefaults.standardUserDefaults boolForKey:key];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                                [[UIApplication sharedApplication] registerForRemoteNotifications];
                                if (success) success(isFirst,[self parseStatus:settings.authorizationStatus]);
                            }
                        });
                    }];
                }else {
                    if (failure) failure(isFirst,ZLNotificationAuthorizationStatusDenied);
                }
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
                [[NSUserDefaults standardUserDefaults]synchronize];
            });
        }];
    }else if (status == ZLNotificationAuthorizationStatusAuthorized
              || status == ZLNotificationAuthorizationStatusProvisional
              || status == ZLNotificationAuthorizationStatusEphemeral) {
        if (success) success(NO,status);
    }else {
        if (failure) failure(NO,status);
    }
}

@end
