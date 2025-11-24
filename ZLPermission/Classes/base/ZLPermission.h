//
//  ZLPermission.h
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import <Foundation/Foundation.h>
#import <ZLPermission/ZLPermissionProtocol.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZLBaseImpl : NSObject<ZLPermissionProtocol>
@end


@interface ZLPermission : NSObject
#ifdef ZLPermissionRequestCameraEnabled
+ (id<ZLCameraPermissionProtocol>)camera;
#endif
#ifdef ZLPermissionRequestPhotosEnabled
+ (id<ZLPhotoPermissionProtocol>)photo;
#endif
#ifdef ZLPermissionRequestMicrophoneEnabled
+ (id<ZLMicrophonePermissionProtocol>)microphone;
#endif
#ifdef ZLPermissionRequestLocationEnabled
+ (id<ZLLocationPermissionProtocol>)location;
#endif
#ifdef ZLPermissionRequestBluetoothEnabled
+ (id<ZLBluetoothPermissionProtocol>)bluetooth;
#endif
#ifdef ZLPermissionRequestCalendarEnabled
+ (id<ZLEventPermissionProtocol>)calendar;
#endif
#ifdef ZLPermissionRequestRemindersEnabled
+ (id<ZLRemindersPermissionProtocol>)reminders;
#endif
#ifdef ZLPermissionRequestTrackingEnabled
+ (id<ZLTrackingPermissionProtocol>)tracking;
#endif
#ifdef ZLPermissionRequestMediaLibraryEnabled

+ (id<ZLMediaLibraryPermissionProtocol>)mediaLibrary;
#endif
#ifdef ZLPermissionRequestHealthEnabled
+ (id<ZLHealthPermissionProtocol>)health;
#endif

#ifdef ZLPermissionRequestNotificationEnabled

+ (id<ZLNotificationPermissionProtocol>)notification;
#endif
#ifdef ZLPermissionRequestContactsEnabled

+ (id<ZLContactsPermissionProtocol>)contacts;
#endif
#ifdef ZLPermissionRequestSiriEnabled

+ (id<ZLSiriPermissionProtocol>)siri;
#endif
#ifdef ZLPermissionRequestSpeechEnabled

+ (id<ZLSpeechRecognizerPermissionProtocol>)speechRecognizer;
#endif
#ifdef ZLPermissionRequestMotionEnabled

+ (id<ZLMotionPermissionProtocol>)motion API_AVAILABLE(ios(11.0));
#endif
/// 跳转去设置界面开启权限
+ (void)goToAppSystemSetting;
/// 弹出提示框，提示用户去设置界面开启权限
+ (void)showAlertWithTitle:(NSString*)title
                       msg:(NSString*)message
                    cancel:(NSString*)cancel
                    setting:(NSString*)setting
                completion:(void(^)(void))completion;
@end

NS_ASSUME_NONNULL_END
