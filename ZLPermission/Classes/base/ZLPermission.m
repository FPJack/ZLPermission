//
//  ZLPermission.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermission.h"
static NSMutableDictionary *sharedInstances;
static NSDictionary *permissionClassMap;
@implementation ZLBaseImpl

- (NSInteger)getPermissionStatus {
    return 0;
}
- (BOOL)hasPermission {
    return NO;
}
- (void)requestPermissionStatusWithSuccess:(ZLSuccessCallback)success failure:(ZLFailureCallback)failure {
    failure(YES,[self getPermissionStatus]);
}
+ (nonnull NSObject *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstances = [NSMutableDictionary dictionary];
    });
    @synchronized (self) {
        ZLBaseImpl *instance = sharedInstances[NSStringFromClass(self)];
        if (!instance) {
            instance = [[self alloc] init];
            sharedInstances[NSStringFromClass(self)] = instance;
        }
        return instance;
    }
}
- (void)requestPermissionStatusWithSuccess:(ZLSuccessCallback)success failureWithType:(ZLFailureTypeCallback)failure {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        permissionClassMap = @{
#ifdef ZLPermissionRequestCameraEnabled
            @"ZLPermissionCamera": @(ZLPermissionTypeCamera),
#endif
            
#ifdef ZLPermissionRequestPhotosEnabled
            @"ZLPermissionPhoto": @(ZLPermissionTypePhoto),
#endif
#ifdef ZLPermissionRequestMicrophoneEnabled
            @"ZLPermissionMicrophone": @(ZLPermissionTypeMicrophone),
#endif
#ifdef ZLPermissionRequestLocationEnabled
            @"ZLPermissionLocation": @(ZLPermissionTypeLocation),
#endif
#ifdef ZLPermissionRequestBluetoothEnabled

            @"ZLPermissionBluetooth": @(ZLPermissionTypeBluetooth),
#endif
            
#ifdef ZLPermissionRequestCalendarEnabled

            @"ZLPermissionCalendar": @(ZLPermissionTypeCalendar),
#endif
            
#ifdef ZLPermissionRequestRemindersEnabled
            @"ZLPermissionReminders": @(ZLPermissionTypeReminders),
#endif
#ifdef ZLPermissionRequestTrackingEnabled

            @"ZLPermissionTracking": @(ZLPermissionTypeTracking),
#endif
#ifdef ZLPermissionRequestMediaLibraryEnabled

            @"ZLPermissionMediaLibrary": @(ZLPermissionTypeMediaLibrary),
#endif
            @"ZLPermissionHealth": @(ZLPermissionTypeHealth),
#ifdef ZLPermissionRequestNotificationEnabled

            @"ZLPermissionNotification": @(ZLPermissionTypeNotification),
#endif
#ifdef ZLPermissionRequestContactsEnabled

            @"ZLPermissionContacts": @(ZLPermissionTypeContacts),
#endif
#ifdef ZLPermissionRequestSiriEnabled

            @"ZLPermissionSiri": @(ZLPermissionTypeSiri),
#endif
#ifdef ZLPermissionRequestSpeechEnabled

            @"ZLPermissionSpeechRecognition": @(ZLPermissionTypeSpeechRecognizer),
#endif
#ifdef ZLPermissionRequestMotionEnabled

            @"ZLPermissionMotion": @(ZLPermissionTypeMotion),
#endif
        };
    });
    NSNumber *typeNum = permissionClassMap[NSStringFromClass([self class])];
    [self requestPermissionStatusWithSuccess:success failure:^(BOOL isFirst, NSInteger status) {
        if (failure) failure(isFirst,status,typeNum.integerValue);
    }];
}
- (void)requestPermissionOnlyStatusWithSuccess:(void (^)(NSInteger))success failure:(void (^)(NSInteger))failure {
    [self requestPermissionStatusWithSuccess:^(BOOL isFirst, NSInteger status) {
        if (success) success(status);
    } failure:^(BOOL isFirst, NSInteger status) {
        if (failure) failure(status);
    }];
}
- (void)requestPermissionWithSuccess:(void(^)(void))success
                   failureWithStatus:(void(^)(NSInteger))failure{
    [self requestPermissionStatusWithSuccess:^(BOOL isFirst, NSInteger status) {
        if (success) success();
    } failure:^(BOOL isFirst, NSInteger status) {
        if (failure) failure(status);
    }];
}
- (void)requestPermissionWithSuccess:(nonnull void (^)(void))success failure:(nonnull void (^)(void))failure {
    [self requestPermissionStatusWithSuccess:^(BOOL isFirst, NSInteger status) {
        if (success) success();
    } failure:^(BOOL isFirst, NSInteger status) {
        if (failure) failure();
    }];
}
@end


@implementation ZLPermission
+(Class)permissionModuleName:(NSString *)moduleName {
    Class <ZLPermissionProtocol> cls = NSClassFromString(moduleName);
    #if DEBUG
    if (!cls) {
        NSString *msg = [NSString stringWithFormat:@"请确认已导入%@模块", moduleName];
        NSAssert(NO, msg);
    }
    #endif
    return cls;
}
#ifdef ZLPermissionRequestCameraEnabled
+ (id<ZLCameraPermissionProtocol>)camera {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionCamera"];
    return (id<ZLCameraPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestPhotosEnabled
+ (id<ZLPhotoPermissionProtocol>)photo {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionPhoto"];
    return (id<ZLPhotoPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestMicrophoneEnabled
+ (id<ZLMicrophonePermissionProtocol>)microphone {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionMicrophone"];
    return (id<ZLMicrophonePermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestLocationEnabled
+ (id<ZLLocationPermissionProtocol>)location {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionLocation"];
    return (id<ZLLocationPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestBluetoothEnabled
+ (id<ZLBluetoothPermissionProtocol>)bluetooth {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionBluetooth"];
    return (id<ZLBluetoothPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestCalendarEnabled
+ (id<ZLEventPermissionProtocol>)calendar {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionCalendar"];
    return (id<ZLEventPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestRemindersEnabled
+ (id<ZLRemindersPermissionProtocol>)reminders {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionReminders"];
    return (id<ZLRemindersPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestTrackingEnabled

+ (id<ZLTrackingPermissionProtocol>)tracking {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionTracking"];
    return (id<ZLTrackingPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestMediaLibraryEnabled

+ (id<ZLMediaLibraryPermissionProtocol>)mediaLibrary {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionMediaLibrary"];
    return (id<ZLMediaLibraryPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestHealthEnabled
+ (id<ZLHealthPermissionProtocol>)health {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionHealth"];
    return (id<ZLHealthPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestNotificationEnabled

+ (id<ZLNotificationPermissionProtocol>)notification {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionNotification"];
    return (id<ZLNotificationPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestContactsEnabled

+ (id<ZLContactsPermissionProtocol>)contacts {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionContacts"];
    return (id<ZLContactsPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestSiriEnabled

+ (id<ZLSiriPermissionProtocol>)siri {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionSiri"];
    return (id<ZLSiriPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestSpeechEnabled

+ (id<ZLSpeechRecognizerPermissionProtocol>)speechRecognizer {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionSpeechRecognition"];
    return (id<ZLSpeechRecognizerPermissionProtocol>)[cls share];
}
#endif
#ifdef ZLPermissionRequestMotionEnabled

+ (id<ZLMotionPermissionProtocol>)motion {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionMotion"];
    return (id<ZLMotionPermissionProtocol>)[cls share];
}
#endif
+ (void)goToAppSystemSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
+ (void)showAlertWithTitle:(NSString*)title
                       msg:(NSString*)message
                    cancel:(NSString*)cancel
                    setting:(NSString*)setting
                 completion:(void(^)(void))completion
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:action];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:setting style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (completion) completion();
        [self goToAppSystemSetting];
    }];
    [alertController addAction:okAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

@end
