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
+ (id<ZLCameraPermissionProtocol>)camera;
+ (id<ZLPhotoPermissionProtocol>)photo;
+ (id<ZLMicrophonePermissionProtocol>)microphone;
+ (id<ZLLocationPermissionProtocol>)location;
+ (id<ZLBluetoothPermissionProtocol>)bluetooth;
+ (id<ZLEventPermissionProtocol>)calendar;
+ (id<ZLRemindersPermissionProtocol>)reminders;
+ (id<ZLTrackingPermissionProtocol>)tracking;
+ (id<ZLMediaLibraryPermissionProtocol>)mediaLibrary;
+ (id<ZLHealthPermissionProtocol>)health;
+ (id<ZLNotificationPermissionProtocol>)notification;
+ (id<ZLContactsPermissionProtocol>)contacts;


+ (void)requestPermissionWithType:(ZLPermissionType)type success:(ZLSuccessCallback)success
                          failure:(ZLFailureTypeCallback)failure;
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
