//
//  ZLPermissionProtocol.h
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import <Foundation/Foundation.h>

#ifdef ZLPermissionRequestHealthEnabled
#import <HealthKit/HealthKit.h>
@class ZLHKRes;
#endif


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZLPermissionType)
{
#ifdef ZLPermissionRequestLocationEnabled
    ZLPermissionTypeLocation = 0,
#endif
#ifdef ZLPermissionRequestPhotosEnabled
    ZLPermissionTypePhoto = 10,
#endif
#ifdef ZLPermissionRequestCameraEnabled
    ZLPermissionTypeCamera = 20,
#endif
#ifdef ZLPermissionRequestMicrophoneEnabled
    ZLPermissionTypeMicrophone = 30,
#endif
#ifdef ZLPermissionRequestNotificationEnabled

    ZLPermissionTypeNotification = 40,
#endif
#ifdef ZLPermissionRequestBluetoothEnabled
    ZLPermissionTypeBluetooth = 50,
#endif
#ifdef ZLPermissionRequestMediaLibraryEnabled

    ZLPermissionTypeMediaLibrary = 60,
#endif
#ifdef ZLPermissionRequestCalendarEnabled
    ZLPermissionTypeCalendar = 70,
#endif
#ifdef ZLPermissionRequestRemindersEnabled

    ZLPermissionTypeReminders = 80,
#endif
#ifdef ZLPermissionRequestHealthEnabled

    ZLPermissionTypeHealth = 90,
#endif
#ifdef ZLPermissionRequestContactsEnabled

    ZLPermissionTypeContacts = 100,
#endif
#ifdef ZLPermissionRequestTrackingEnabled

    ZLPermissionTypeTracking = 110,
#endif
#ifdef ZLPermissionRequestSiriEnabled

    ZLPermissionTypeSiri = 120,
#endif
#ifdef ZLPermissionRequestSpeechEnabled

    ZLPermissionTypeSpeechRecognizer = 130,
#endif
#ifdef ZLPermissionRequestMotionEnabled

    ZLPermissionTypeMotion = 140,
#endif
};


typedef NS_ENUM(NSInteger,ZLAuthorizationStatus)
{
    ZLAuthorizationStatusNotDetermined = 0,
    ZLAuthorizationStatusDenied,
    ZLAuthorizationStatusRestricted,
    ZLAuthorizationStatusAuthorized
};

#ifdef ZLPermissionRequestPhotosEnabled
typedef NS_ENUM(NSInteger,ZLPhotoAuthorizationStatus)
{
    ZLPhotoAuthorizationStatusNotDetermined = 0,
    ZLPhotoAuthorizationStatusDenied,
    ZLPhotoAuthorizationStatusRestricted,
    ZLPhotoAuthorizationStatusAuthorized,
    ZLPhotoAuthorizationStatusLimited
};
#endif

#ifdef ZLPermissionRequestMicrophoneEnabled
typedef NS_ENUM(NSInteger,ZLMicrophoneAuthorizationStatus)
{
    ZLMicrophoneAuthorizationStatusNotDetermined = 0,
    ZLMicrophoneAuthorizationStatusDenied,
    ZLMicrophoneAuthorizationStatusAuthorized
};
#endif

#ifdef ZLPermissionRequestLocationEnabled
typedef NS_ENUM(NSInteger,ZLLocationAuthorizationStatus)
{
    ZLLocationAuthorizationStatusNotDetermined = 0,
    ZLLocationAuthorizationStatusRestricted ,
    ZLLocationAuthorizationStatusDenied ,
    ZLLocationAuthorizationStatusAlways ,
    ZLLocationAuthorizationStatusWhenInUse,
};
#endif

#ifdef ZLPermissionRequestHealthEnabled

typedef NS_ENUM(NSInteger,ZLHealthAuthorizationStatus)
{
    ZLHealthAuthorizationStatusNotDetermined = 0,
    ZLHealthAuthorizationStatusDenied ,
    ZLHealthAuthorizationStatusAuthorized ,
};
#endif
#ifdef ZLPermissionRequestBluetoothEnabled
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
#endif


#if defined(ZLPermissionRequestCalendarEnabled) || defined(ZLPermissionRequestRemindersEnabled)

//日历和提醒事件
typedef NS_ENUM(NSInteger, ZLEventAuthorizationStatus) {
    ZLEventAuthorizationStatusNotDetermined = 0,
    ZLEventAuthorizationStatusRestricted,
    ZLEventAuthorizationStatusDenied,
    ZLEventAuthorizationStatusFullAccess,
    ZLEventAuthorizationStatusWriteOnly
};

#endif

#ifdef ZLPermissionRequestNotificationEnabled

typedef NS_ENUM(NSInteger,ZLNotificationAuthorizationStatus)
{
    ZLNotificationAuthorizationStatusNotDetermined = 0,
    ZLNotificationAuthorizationStatusDenied,
    ZLNotificationAuthorizationStatusAuthorized ,
    ZLNotificationAuthorizationStatusProvisional,
    ZLNotificationAuthorizationStatusEphemeral
};
#endif

#ifdef ZLPermissionRequestContactsEnabled

typedef NS_ENUM(NSInteger,ZLContactsAuthorizationStatus)
{
    ZLContactsAuthorizationStatusNotDetermined = 0,
    ZLContactsAuthorizationStatusDenied,
    ZLContactsAuthorizationStatusRestricted,
    ZLContactsAuthorizationStatusAuthorized,
    ZLContactsAuthorizationStatusLimited ,/// iOS 18新增
};
#endif
#ifdef ZLPermissionRequestSiriEnabled

typedef NS_ENUM(NSInteger,ZLSiriAuthorizationStatus)
{
    ZLSiriAuthorizationStatusNotDetermined = 0,
    ZLSiriAuthorizationStatusDenied,
    ZLSiriAuthorizationStatusRestricted,
    ZLSiriAuthorizationStatusAuthorized,
};
#endif
#ifdef ZLPermissionRequestSpeechEnabled

typedef NS_ENUM(NSInteger,ZLSpeechRecognizerAuthorizationStatus)
{
    ZLSpeechRecognizerAuthorizationStatusNotDetermined = 0,
    ZLSpeechRecognizerAuthorizationStatusDenied,
    ZLSpeechRecognizerAuthorizationStatusRestricted,
    ZLSpeechRecognizerAuthorizationStatusAuthorized,
};
#endif
#ifdef ZLPermissionRequestMotionEnabled

typedef NS_ENUM(NSInteger,ZLMotionAuthorizationStatus)
{
    ZLMotionAuthorizationStatusNotDetermined = 0,
    ZLMotionAuthorizationStatusDenied,
    ZLMotionAuthorizationStatusRestricted,
    ZLMotionAuthorizationStatusAuthorized,
} API_AVAILABLE(ios(11.0));
#endif

typedef void(^ZLSuccessCallback)(BOOL isFirst,NSInteger status);
typedef void(^ZLFailureCallback)(BOOL isFirst,NSInteger status);
typedef void(^ZLFailureTypeCallback)(BOOL isFirstRequest,NSInteger status,ZLPermissionType type);



@protocol ZLPermissionProtocol <NSObject>
@required
+ (id<ZLPermissionProtocol> )share;
- (BOOL)hasPermission;
- (NSInteger)getPermissionStatus;
///失败成功返回
- (void)requestPermissionWithSuccess:(void(^)(void))success
                             failure:(void(^)(void))failure;
///失败返回权限状态
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(NSInteger))failure;
///失败成功都返回权限状态
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(NSInteger status))success
                                       failure:(void(^)(NSInteger status))failure;
///失败成功都返回权限状态并且返回是否是初次申请权限
- (void)requestPermissionStatusWithSuccess:(ZLSuccessCallback)success
                                   failure:(ZLFailureCallback)failure;
///失败成功都返回权限状态并且返回是否是第一次初次申请权限，以及失败的时候返回申请权限类型，方便统一失败处理
- (void)requestPermissionStatusWithSuccess:(ZLSuccessCallback)success
                           failureWithType:(ZLFailureTypeCallback)failure;
@end

#ifdef ZLPermissionRequestCameraEnabled
@protocol ZLCameraPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLCameraPermissionProtocol> )share;
- (ZLAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLAuthorizationStatus status))success
                                       failure:(void(^)(ZLAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestPhotosEnabled
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
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLPhotoAuthorizationStatus status))failure;

- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLPhotoAuthorizationStatus status))success
                                       failure:(void(^)(ZLPhotoAuthorizationStatus status))failure;
/// 请求读写权限
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
/// 仅请求写权限
- (void)requestWriteOnlyPermissionWithSuccess:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))success
                                      failure:(void(^)(BOOL isFirst, ZLPhotoAuthorizationStatus status))failure;
@end
#endif


#ifdef ZLPermissionRequestMicrophoneEnabled
@protocol ZLMicrophonePermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLMicrophonePermissionProtocol> )share;
- (ZLMicrophoneAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLMicrophoneAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLMicrophoneAuthorizationStatus status))success
                                       failure:(void(^)(ZLMicrophoneAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestLocationEnabled
@protocol ZLLocationPermissionProtocol <ZLPermissionProtocol>
@required
- (BOOL)systemLocationServicesEnabled;
- (ZLLocationAuthorizationStatus )getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLLocationAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLLocationAuthorizationStatus status))success
                                       failure:(void(^)(ZLLocationAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst, ZLLocationAuthorizationStatus status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestBluetoothEnabled
@protocol ZLBluetoothPermissionProtocol <ZLPermissionProtocol>
@required

+ (id<ZLBluetoothPermissionProtocol> )share;

- (ZLBluetoothCapabilities)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLBluetoothCapabilities status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLBluetoothCapabilities status))success
                                       failure:(void(^)(ZLBluetoothCapabilities status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                                   failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure;

///系统权限关闭时，弹出系统窗口提示去设置开启蓝牙权限
- (void)requestPermissionShowPowerAlertWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                                           failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure;

- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestCalendarEnabled
@protocol ZLEventPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLEventPermissionProtocol> )share;
- (ZLEventAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLEventAuthorizationStatus status))failure;

- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLEventAuthorizationStatus status))success
                                       failure:(void(^)(ZLEventAuthorizationStatus status))failure;
/// 请求Full access权限
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure;
/// 仅请求Write only权限 ios    17+
- (void)requestWriteOnlyPermissionWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                                      failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure API_AVAILABLE(ios(17.0));

- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status,ZLPermissionType type))failure;
@end
#endif


#ifdef ZLPermissionRequestRemindersEnabled

@protocol ZLRemindersPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLRemindersPermissionProtocol> )share;
- (ZLEventAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLEventAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLEventAuthorizationStatus status))success
                                       failure:(void(^)(ZLEventAuthorizationStatus status))failure;
/// 请求Full access权限
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))failure;

- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst, ZLEventAuthorizationStatus status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestTrackingEnabled
@protocol ZLTrackingPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLTrackingPermissionProtocol> )share;
- (ZLAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLAuthorizationStatus status))failure;

- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLAuthorizationStatus status))success
                                       failure:(void(^)(ZLAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif
#ifdef ZLPermissionRequestMediaLibraryEnabled
@protocol ZLMediaLibraryPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLMediaLibraryPermissionProtocol> )share;
- (ZLAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLAuthorizationStatus status))success
                                       failure:(void(^)(ZLAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestHealthEnabled
@protocol ZLHealthPermissionProtocol <NSObject>
@required
+ (id<ZLHealthPermissionProtocol>)share;
- (BOOL)isHealthDataAvailable;
- (ZLHealthAuthorizationStatus)getPermissionStatusWithHKObjectType:(HKQuantityTypeIdentifier)quantityTypeIdentifier;
- (void)requestPermissionWithWriteTypes:(NSArray<HKQuantityTypeIdentifier > *)writeTypes
                              readTypes:(NSArray<HKQuantityTypeIdentifier > *)readTypesadTypes
                                success:(void(^)(NSArray<ZLHKRes *> * results))success
                                failure:(void(^)(NSArray<ZLHKRes *> * results))failure;
@end
#endif

#ifdef ZLPermissionRequestNotificationEnabled
@protocol ZLNotificationPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLNotificationPermissionProtocol> )share;
- (ZLNotificationAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLNotificationAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLNotificationAuthorizationStatus status))success
                                       failure:(void(^)(ZLNotificationAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLNotificationAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLNotificationAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLNotificationAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif
#ifdef ZLPermissionRequestContactsEnabled
@protocol ZLContactsPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLContactsPermissionProtocol> )share;
- (ZLContactsAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLContactsAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLContactsAuthorizationStatus status))success
                                       failure:(void(^)(ZLContactsAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLContactsAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLContactsAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLContactsAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestSiriEnabled
@protocol ZLSiriPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLSiriPermissionProtocol> )share;
- (ZLSiriAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLSiriAuthorizationStatus status))failure;

- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLSiriAuthorizationStatus status))success
                                       failure:(void(^)(ZLSiriAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLSiriAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLSiriAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLSiriAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif

#ifdef ZLPermissionRequestSpeechEnabled
@protocol ZLSpeechRecognizerPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLSpeechRecognizerPermissionProtocol> )share;
- (ZLSpeechRecognizerAuthorizationStatus)getPermissionStatus;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLSpeechRecognizerAuthorizationStatus status))failure;
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLSpeechRecognizerAuthorizationStatus status))success
                                       failure:(void(^)(ZLSpeechRecognizerAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status))failure;
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure;
@end
#endif
#ifdef ZLPermissionRequestMotionEnabled
@protocol ZLMotionPermissionProtocol <ZLPermissionProtocol>
@required
+ (id<ZLMotionPermissionProtocol> )share;
- (BOOL)isActivityAvailable;
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(ZLMotionAuthorizationStatus status))failure API_AVAILABLE(ios(11.0));
- (void)requestPermissionOnlyStatusWithSuccess:(void(^)(ZLMotionAuthorizationStatus status))success
                                       failure:(void(^)(ZLMotionAuthorizationStatus status))failure API_AVAILABLE(ios(11.0));
- (ZLMotionAuthorizationStatus)getPermissionStatus API_AVAILABLE(ios(11.0));
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLMotionAuthorizationStatus status))success
                                   failure:(void(^)(BOOL isFirst, ZLMotionAuthorizationStatus status))failure API_AVAILABLE(ios(11.0));
- (void)requestPermissionStatusWithSuccess:(void(^)(BOOL isFirst, ZLMotionAuthorizationStatus status))success
                           failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure  API_AVAILABLE(ios(11.0));
@end
#endif
NS_ASSUME_NONNULL_END
