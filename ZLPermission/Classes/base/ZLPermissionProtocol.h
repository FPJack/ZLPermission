//
//  ZLPermissionProtocol.h
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZLPermissionType)
{
    ZLPermissionTypeLocation,
    ZLPermissionTypePhoto,
    ZLPermissionTypeCamera,
    ZLPermissionTypeMicrophone,
    ZLPermissionTypeNotification,
    ZLPermissionTypeBluetooth,
    ZLPermissionTypeMediaLibrary,
    ZLPermissionTypeCalendar,
    ZLPermissionTypeReminders,
    ZLPermissionTypeHealth,
    ZLPermissionTypeContacts,
    ZLPermissionTypeNetwork,
    ZLPermissionTypeTracking,
};


typedef NS_ENUM(NSInteger,ZLAuthorizationStatus)
{
    ZLAuthorizationStatusNotDetermined = 0,
    ZLAuthorizationStatusDenied,
    ZLAuthorizationStatusRestricted,
    ZLAuthorizationStatusAuthorized
};

typedef NS_ENUM(NSInteger,ZLPhotoAuthorizationStatus)
{
    ZLPhotoAuthorizationStatusNotDetermined = 0,
    ZLPhotoAuthorizationStatusDenied,
    ZLPhotoAuthorizationStatusRestricted,
    ZLPhotoAuthorizationStatusAuthorized,
    ZLPhotoAuthorizationStatusLimited
};

typedef NS_ENUM(NSInteger,ZLMicrophoneAuthorizationStatus)
{
    ZLMicrophoneAuthorizationStatusNotDetermined = 0,
    ZLMicrophoneAuthorizationStatusDenied,
    ZLMicrophoneAuthorizationStatusAuthorized
};


typedef NS_ENUM(NSInteger,ZLLocationAuthorizationStatus)
{
    ZLLocationAuthorizationStatusNotDetermined = 0,
    ZLLocationAuthorizationStatusRestricted ,
    ZLLocationAuthorizationStatusDenied ,
    ZLLocationAuthorizationStatusAlways ,
    ZLLocationAuthorizationStatusWhenInUse,
};


typedef void(^ZLSuccessCallback)(BOOL isFirst,NSInteger status);
typedef void(^ZLFailureCallback)(BOOL isFirst,NSInteger status);
typedef void(^ZLFailureTypeCallback)(BOOL isFirstRequest,NSInteger status,ZLPermissionType type);



@protocol ZLPermissionProtocol <NSObject>
@required
+ (id )share;
- (BOOL)hasPermission;
- (NSInteger)getPermissionStatus;
- (void)requestSuccess:(void(^)(void))success
               failure:(void(^)(void))failure;
- (void)requestPermissionWithSuccess:(ZLSuccessCallback)success
                             failure:(ZLFailureCallback)failure;
- (void)requestPermissionWithSuccess:(ZLSuccessCallback)success
                     failureWithType:(ZLFailureTypeCallback)failure;
@end



@protocol ZLCameraPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLCameraPermissionProtocol> )share;
- (ZLAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end


@protocol ZLPhotoPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLPhotoPermissionProtocol> )share;
- (ZLPhotoAuthorizationStatus)getPermissionStatus;
/// 是否有读写权限
- (BOOL)hasReadWritePermission;
/// 是否有写权限
- (BOOL)hasWritePermission;
/// 获取读写权限状态
- (ZLPhotoAuthorizationStatus)getOnlyWritePermissionStatus;
/// 请求读写权限
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
/// 仅请求写权限
- (void)requestOnlyWritePermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                                      failure:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))failure;
@end



@protocol ZLMicrophonePermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLMicrophonePermissionProtocol> )share;
- (ZLMicrophoneAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end


@protocol ZLLocationPermissionProtocol <ZLPermissionProtocol>
@required
- (BOOL)systemLocationServicesEnabled;
- (ZLLocationAuthorizationStatus )getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status,ZLPermissionType type))failure;
@end

NS_ASSUME_NONNULL_END
