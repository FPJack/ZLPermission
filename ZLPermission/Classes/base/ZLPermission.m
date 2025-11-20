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
//+ (id<GMPermissionPhotoProtocol>)photo{
//    Class<GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionPhoto");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionPhoto模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionPhotoProtocol>)[cls share];
//}
//+ (id<GMPermissionLocationProtocol>)location{
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionLocation");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionLocation模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionLocationProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)microphone {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionMicrophone");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionMicrophone模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)notification {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionNotification");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionNotification模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
//+ (id<GMPermissionBluetoothProtocol>)bluetooth{
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionBluetooth");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionBluetooth模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionBluetoothProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)mediaLibrary {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionMediaLibrary");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionMediaLibrary模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)calendar {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionCalendar");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionCalendar模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)reminders {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionReminders");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionReminders模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
//+ (id<GMPermissionHealthProtocol>)health {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionHealth");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionHealth模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionHealthProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)contacts {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionContacts");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionContacts模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
//+ (id<GMPermissionNetworkProtocol>)network {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionNetwork");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionNetwork模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionNetworkProtocol>)[cls share];
//}
//+ (id<GMPermissionProtocol>)tracking {
//    Class <GMPermissionProtocol> cls = NSClassFromString(@"GMPermissionTracking");
//    if (!cls) {
//    #if DEBUG
//            NSAssert(NO, @"请确认已导入GMPermissionTracking模块");
//    #endif
//        return nil;
//    }
//    return (id<GMPermissionProtocol>)[cls share];
//}
+ (void)requestPermissionWithType:(ZLPermissionType)type success:(ZLSuccessCallback)success
                          failure:(ZLFailureTypeCallback)failure {
    id<ZLPermissionProtocol> impl = nil;
    switch (type) {
        case ZLPermissionTypePhoto:
            impl = [self photo];
            break;
        case ZLPermissionTypeCamera:
            impl = [self camera];
            break;
        case ZLPermissionTypeLocation:
            impl = [self location];
            break;
        case ZLPermissionTypeMicrophone:
            impl = [self microphone];
            break;
        case ZLPermissionTypeNotification:
            break;
        case ZLPermissionTypeBluetooth:
            impl = [self bluetooth];
            break;
        case ZLPermissionTypeMediaLibrary:
            break;
        case ZLPermissionTypeCalendar:
            break;
        case ZLPermissionTypeReminders:
            break;
        case ZLPermissionTypeHealth:
            break;
        case ZLPermissionTypeContacts:
            break;
        case ZLPermissionTypeNetwork:
            break;
        case ZLPermissionTypeTracking:
            break;
        default:
            break;
    }
    if (!impl) return;
    [impl requestPermissionWithSuccess:success failure:^(BOOL isFirstRequest, NSInteger status) {
        if (failure) failure(isFirstRequest,status,type);
    }];
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
