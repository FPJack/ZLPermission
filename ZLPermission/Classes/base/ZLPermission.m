//
//  ZLPermission.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermission.h"
static NSMutableDictionary *sharedInstances;
@implementation ZLBaseImpl

- (NSInteger)getPermissionStatus {
    return 0;
}
- (BOOL)hasPermission {
    return NO;
}
- (void)requestPermissionWithSuccess:(ZLSuccessCallback)success failure:(ZLFailureCallback)failure {
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
- (void)requestPermissionWithSuccess:(nonnull ZLSuccessCallback)success failureWithType:(nonnull ZLFailureTypeCallback)failure {
}
- (void)requestSuccess:(nonnull void (^)(void))success failure:(nonnull void (^)(void))failure {
    [self requestPermissionWithSuccess:^(BOOL isFirst, NSInteger status) {
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
+ (id<ZLCameraPermissionProtocol>)camera {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionCamera"];
    return (id<ZLCameraPermissionProtocol>)[cls share];
}
+ (id<ZLPhotoPermissionProtocol>)photo {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"GMPermissionPhoto"];
    return (id<ZLPhotoPermissionProtocol>)[cls share];
}
+ (id<ZLMicrophonePermissionProtocol>)microphone {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionMicrophone"];
    return (id<ZLMicrophonePermissionProtocol>)[cls share];
}
+ (id<ZLLocationPermissionProtocol>)location {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionLocation"];
    return (id<ZLLocationPermissionProtocol>)[cls share];
}
+ (id<ZLBluetoothPermissionProtocol>)bluetooth {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionBluetooth"];
    return (id<ZLBluetoothPermissionProtocol>)[cls share];
}
+ (id<ZLEventPermissionProtocol>)calendar {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionCalendar"];
    return (id<ZLEventPermissionProtocol>)[cls share];
}
+ (id<ZLRemindersPermissionProtocol>)reminders {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionReminders"];
    return (id<ZLRemindersPermissionProtocol>)[cls share];
}
+ (id<ZLTrackingPermissionProtocol>)tracking {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionTracking"];
    return (id<ZLTrackingPermissionProtocol>)[cls share];
}
+ (id<ZLMediaLibraryPermissionProtocol>)mediaLibrary {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionMediaLibrary"];
    return (id<ZLMediaLibraryPermissionProtocol>)[cls share];
}
+ (id<ZLHealthPermissionProtocol>)health {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionHealth"];
    return (id<ZLHealthPermissionProtocol>)[cls share];
}
+ (id<ZLNotificationPermissionProtocol>)notification {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionNotification"];
    return (id<ZLNotificationPermissionProtocol>)[cls share];
}
+ (id<ZLContactsPermissionProtocol>)contacts {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionContacts"];
    return (id<ZLContactsPermissionProtocol>)[cls share];
}
+ (id<ZLSiriPermissionProtocol>)siri {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionSiri"];
    return (id<ZLSiriPermissionProtocol>)[cls share];
}
+ (id<ZLSpeechRecognizerPermissionProtocol>)speechRecognizer {
    Class <ZLPermissionProtocol> cls = [self permissionModuleName:@"ZLPermissionSpeechRecognition"];
    return (id<ZLSpeechRecognizerPermissionProtocol>)[cls share];
}
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
