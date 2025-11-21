//
//  ZLPermissionMediaLibrary.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionMediaLibrary.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation ZLPermissionMediaLibrary
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLAuthorizationStatusAuthorized;
}
- (ZLAuthorizationStatus)getPermissionStatus {
    return [self parseStatus:MPMediaLibrary.authorizationStatus];
}
- (ZLAuthorizationStatus)parseStatus:(MPMediaLibraryAuthorizationStatus)status {
    switch(status){
        case MPMediaLibraryAuthorizationStatusNotDetermined:
            return ZLAuthorizationStatusNotDetermined;
        case MPMediaLibraryAuthorizationStatusRestricted:
            return ZLAuthorizationStatusRestricted;
        case MPMediaLibraryAuthorizationStatusDenied:
            return ZLAuthorizationStatusDenied;
        case MPMediaLibraryAuthorizationStatusAuthorized:
            return ZLAuthorizationStatusAuthorized;
        default:
            return ZLAuthorizationStatusDenied;
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure {
    ZLAuthorizationStatus status = [self getPermissionStatus];
    switch (status) {
        case ZLAuthorizationStatusAuthorized:
        {
            if (success) success(NO, status);
        }
            break;
        case ZLAuthorizationStatusRestricted:
        case ZLAuthorizationStatusDenied:
        {
            if (failure) failure(NO, status);
        }
            break;
        case ZLAuthorizationStatusNotDetermined:
        {
            [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZLAuthorizationStatus gmStatus = [self parseStatus:status];
                    if (gmStatus == ZLAuthorizationStatusAuthorized) {
                        if (success) success(YES,gmStatus);
                    }else {
                        if (failure) failure(YES, gmStatus);
                    }
                });
            }];
        }
            break;
        default:
        {
            if (failure) failure(NO, status);
        }
            break;
    }
}

@end
