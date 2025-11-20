//
//  GMPermissionPhoto.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "GMPermissionPhoto.h"
#import <Photos/Photos.h>

@implementation GMPermissionPhoto
- (ZLPhotoAuthorizationStatus)parseStatus:(PHAuthorizationStatus)status {
    switch(status){
        case PHAuthorizationStatusNotDetermined:
            return ZLPhotoAuthorizationStatusNotDetermined;
        case PHAuthorizationStatusRestricted:
            return ZLPhotoAuthorizationStatusRestricted;
        case PHAuthorizationStatusDenied:
            return ZLPhotoAuthorizationStatusDenied;
        case PHAuthorizationStatusAuthorized:
            return ZLPhotoAuthorizationStatusAuthorized;
        case PHAuthorizationStatusLimited:
            return ZLPhotoAuthorizationStatusLimited;
            default:
            return ZLPhotoAuthorizationStatusDenied;
    }
}
- (ZLPhotoAuthorizationStatus)getPermissionStatus {
    if (@available(iOS 14.0, *)) {
        return [self parseStatus:[PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite]];
    }
    return [self parseStatus:PHPhotoLibrary.authorizationStatus];
}

- (BOOL)hasPermission { 
    return [self hasReadWritePermission];
}
- (void)requestPermissionReadWrite:(BOOL)isReadWrite
                           success:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                           failure:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))failure {
    if (@available(iOS 8.0, *)) {
        ZLPhotoAuthorizationStatus status;
        if (isReadWrite) {
            status = [self getPermissionStatus];
        }else {
            status = [self getOnlyWritePermissionStatus];
        }
        switch (status) {
            case ZLPhotoAuthorizationStatusAuthorized:
            case ZLPhotoAuthorizationStatusLimited:
            {
                if (success) success(NO,status);
            }
                break;
            case ZLPhotoAuthorizationStatusRestricted:
            case ZLPhotoAuthorizationStatusDenied:
            {
                if (failure) failure(NO,status);
            }
                break;
            case ZLPhotoAuthorizationStatusNotDetermined:
            {
                if (@available(iOS 14.0, *)) {
                    [PHPhotoLibrary requestAuthorizationForAccessLevel:isReadWrite ? PHAccessLevelReadWrite :PHAccessLevelAddOnly  handler:^(PHAuthorizationStatus status) {
                        ZLPhotoAuthorizationStatus s = [self parseStatus:status];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (s == ZLPhotoAuthorizationStatusAuthorized
                                || s == ZLPhotoAuthorizationStatusLimited) {
                                if (success) success(YES,s);
                            }else {
                                if (failure) failure(YES,s);
                            }
                        });
                    }];
                }else {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        ZLPhotoAuthorizationStatus s = [self parseStatus:status];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (s == ZLPhotoAuthorizationStatusAuthorized
                                || s == ZLPhotoAuthorizationStatusLimited) {
                                if (success)  success(YES,s);
                            }else {
                                if (failure) failure(YES,s);
                            }
                        });
                    }];
                }
            }
                break;
                
            default:
            {
                if (failure) failure(NO,status);
            }
                break;
        }
    }
}

- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))failure{
    [self requestPermissionReadWrite:YES success:success failure:failure];
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirst, ZLPhotoAuthorizationStatus status) {
        if (failure) failure(isFirst,status,ZLPermissionTypePhoto);
    }];
}

- (void)requestSuccess:(nonnull void (^)(void))success failure:(nonnull void (^)(void))failure { 
    [self requestPermissionWithSuccess:^(BOOL isFirst, ZLPhotoAuthorizationStatus status) {
        if(success) success();
    } failure:^(BOOL isFirst, ZLPhotoAuthorizationStatus status) {
        if (failure) failure();
    }];
}
- (ZLPhotoAuthorizationStatus)getOnlyWritePermissionStatus { 
    if (@available(iOS 14.0, *)) {
        return [self parseStatus:[PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelAddOnly]];
    }
    return [self getPermissionStatus];
}

- (BOOL)hasReadWritePermission { 
    return self.getPermissionStatus == ZLAuthorizationStatusAuthorized || self.getPermissionStatus == ZLPhotoAuthorizationStatusLimited;
}

- (BOOL)hasWritePermission { 
    return self.getOnlyWritePermissionStatus == ZLPhotoAuthorizationStatusAuthorized || self.getOnlyWritePermissionStatus == ZLPhotoAuthorizationStatusLimited;
}

- (void)requestWriteOnlyPermissionWithSuccess:(nonnull void (^)(BOOL, ZLPhotoAuthorizationStatus))success failure:(nonnull void (^)(BOOL, ZLPhotoAuthorizationStatus))failure { 
    [self requestPermissionReadWrite:NO success:success failure:failure];
}

@end
