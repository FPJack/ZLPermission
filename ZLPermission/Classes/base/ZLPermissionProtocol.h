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

typedef NS_ENUM(NSInteger,ZLHealthAuthorizationStatus)
{
    ZLHealthAuthorizationStatusNotDetermined = 0,
    ZLHealthAuthorizationStatusDenied ,
    ZLHealthAuthorizationStatusAuthorized ,
};

///蓝牙
typedef NS_OPTIONS(NSInteger, ZLBluetoothCapabilities) {
    ZLBluetoothCapabilityNotDetermined          = 0, /// 未决定
    ZLBluetoothCapabilityRestricted       = 1 << 0, /// 受限
    ZLBluetoothCapabilityDenied    = 1 << 1, /// 拒绝
    ZLBluetoothCapabilityAllowedAlways   = 1 << 2, /// 永远允许
    ZLBluetoothCapabilityUnknown     = 1 << 3, /// 未知
    ZLBluetoothCapabilityResetting    = 1 << 4, /// 重置中
    ZLBluetoothCapabilityUnsupported    = 1 << 5,/// 不支持
    ZLBluetoothCapabilityUnauthorized    = 1 << 6,/// 未授权
    ZLBluetoothCapabilityPoweredOff    = 1 << 7,/// 系统已关闭
    ZLBluetoothCapabilityPoweredOn    = 1 << 8,/// 系统已开启
};

//日历和提醒事件
typedef NS_ENUM(NSInteger,ZLEventAuthorizationStatus)
{
    ZLEventAuthorizationStatusNotDetermined = 0,
    ZLEventAuthorizationStatusRestricted,
    ZLEventAuthorizationStatusDenied,
    ZLEventAuthorizationStatusFullAccess,
    ZLEventAuthorizationStatusWriteOnly
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
- (void)requestWriteOnlyPermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
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


@protocol ZLBluetoothPermissionProtocol <ZLPermissionProtocol>
@required

+ (id<ZLBluetoothPermissionProtocol> )share;

- (ZLBluetoothCapabilities)getPermissionStatus;

- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                             failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure;

///系统权限关闭时，弹出系统窗口提示去设置开启蓝牙权限
- (void)requestPermissionShowPowerAlertWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                                           failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure;

- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end


@protocol ZLEventPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLEventPermissionProtocol> )share;
- (ZLEventAuthorizationStatus)getPermissionStatus;
/// 请求Full access权限
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure;
/// 仅请求Write only权限 ios    17+
- (void)requestWriteOnlyPermissionWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                                      failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure API_AVAILABLE(ios(17.0));

- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status,ZLPermissionType type))failure;
@end

@protocol ZLRemindersPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLRemindersPermissionProtocol> )share;
- (ZLEventAuthorizationStatus)getPermissionStatus;
/// 请求Full access权限
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure;

- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status,ZLPermissionType type))failure;
@end



@protocol ZLTrackingPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLTrackingPermissionProtocol> )share;
- (ZLAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end

@protocol ZLMediaLibraryPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLMediaLibraryPermissionProtocol> )share;
- (ZLAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end

@protocol ZLHealthPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLHealthPermissionProtocol> )share;
- (ZLHealthAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))failure;
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLHealthAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end

NS_ASSUME_NONNULL_END
