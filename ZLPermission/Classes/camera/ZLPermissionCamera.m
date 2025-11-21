//
//  ZLPermissionCamera.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionCamera.h"
#import <Photos/Photos.h>

@implementation ZLPermissionCamera
- (ZLAuthorizationStatus)parseStatus:(AVAuthorizationStatus)status {
    switch(status){
        case AVAuthorizationStatusNotDetermined:
            return ZLAuthorizationStatusNotDetermined;
        case AVAuthorizationStatusRestricted:
            return ZLAuthorizationStatusRestricted;
        case AVAuthorizationStatusDenied:
            return ZLAuthorizationStatusDenied;
        case AVAuthorizationStatusAuthorized:
            return ZLAuthorizationStatusAuthorized;
        default:
        return ZLAuthorizationStatusNotDetermined;
    }
}
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLAuthorizationStatusAuthorized;
}
- (ZLAuthorizationStatus)getPermissionStatus {
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        return [self parseStatus:[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]] ;
    } else {
        return [self parseStatus:AVAuthorizationStatusAuthorized];
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure {
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        ZLAuthorizationStatus permission = [self getPermissionStatus];
            switch (permission) {
                case ZLAuthorizationStatusAuthorized:
                    if (success) success(NO,permission);
                    break;
                case ZLAuthorizationStatusDenied:
                case ZLAuthorizationStatusRestricted:
                    if (failure) failure(NO,permission);
                    break;
                case ZLAuthorizationStatusNotDetermined:
                {
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                             completionHandler:^(BOOL granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (granted) {
                                if (success) success(YES,[self getPermissionStatus]);
                            }else {
                                if (failure) failure(YES,[self getPermissionStatus]);
                            }
                        });
                    }];
                }
                break;
                default:
                    if (failure) failure(NO,permission);
                    break;
            }
        } else {
            if (success) success(YES,[self getPermissionStatus]);
        }
}

@end
