//
//  ZLPermissionBluetooth.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionBluetooth.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define kBluetoothFinishedNotification @"kZLBluetoothFinishedNotification"
#define kBluetoothStateChangeNotification @"kZLBluetoothStateChangeNotification"

@interface ZLPermissionBluetooth()<CBPeripheralManagerDelegate>
@property (nonatomic, strong) CBPeripheralManager *bluetoothMonitor;
@property (nonatomic, strong) CBPeripheralManager *showAlertbluetoothMonitor;
@end
@implementation ZLPermissionBluetooth
- (CBPeripheralManager *)bluetoothMonitor {
    @synchronized (self.class) {
        if (!_bluetoothMonitor) {
            _bluetoothMonitor = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
        }
        return _bluetoothMonitor;
    }
    
}
- (CBPeripheralManager *)showAlertbluetoothMonitor {
    @synchronized (self.class) {
        if (!_showAlertbluetoothMonitor) {
            _showAlertbluetoothMonitor = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:@(YES)}];
        }
        return _showAlertbluetoothMonitor;
    }
   
}
- (BOOL)hasPermission {
    ZLBluetoothCapabilities status = [self getPermissionStatus];
    return status == ZLBluetoothCapabilityAllowedAlways;
}
- (ZLBluetoothCapabilities)getPermissionStatus {
    ZLBluetoothCapabilities capabilities;
    if (@available(iOS 13.1, *)) {
        switch (CBManager.authorization) {
            case CBManagerAuthorizationNotDetermined:
            {
                capabilities = ZLBluetoothCapabilityNotDetermined;
            }
                break;
            case CBManagerAuthorizationRestricted:
            {
                capabilities = ZLBluetoothCapabilityRestricted;
            }
                break;
            case CBManagerAuthorizationDenied:
            {
                capabilities = ZLBluetoothCapabilityDenied;
            }
                break;
            case CBManagerAuthorizationAllowedAlways:
            {
                capabilities = ZLBluetoothCapabilityAllowedAlways;
            }
                break;
            default:
                break;
        }
        return capabilities;
    }else{
        switch ([CBPeripheralManager authorizationStatus]) {
            case CBPeripheralManagerAuthorizationStatusNotDetermined:
            {
                capabilities = ZLBluetoothCapabilityNotDetermined;
            }
                break;
            case CBPeripheralManagerAuthorizationStatusRestricted:
            {
                capabilities = ZLBluetoothCapabilityRestricted;
            }
                break;
            case CBPeripheralManagerAuthorizationStatusDenied:
            {
                capabilities = ZLBluetoothCapabilityDenied;
            }
                break;
            case CBPeripheralManagerAuthorizationStatusAuthorized:
            {
                capabilities = ZLBluetoothCapabilityAllowedAlways;
            }
                break;
            default:
                break;
        }
        return capabilities;
    }
}



- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                             failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure{
   [self permissionWithSuccess:success failure:failure];
    [self bluetoothMonitor];
}
- (void)permissionWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                      failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure{
    BOOL isFirstRequest = YES;
    __block NSObject* observer;
    observer = [NSNotificationCenter.defaultCenter addObserverForName:kBluetoothFinishedNotification object:self.bluetoothMonitor queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
        [NSNotificationCenter.defaultCenter removeObserver:observer];
        observer = nil;
        NSNumber *state = [notification.userInfo valueForKey:@"state"];
        if (state && ![state isKindOfClass:NSNumber.class]) return;
        int stateValue = state.intValue;
        NSInteger newStatus = [self getPermissionStatus];
        if (stateValue == ZLBluetoothCapabilityPoweredOn) {
            if (newStatus == ZLBluetoothCapabilityAllowedAlways) {
                if (success) success(isFirstRequest,newStatus|stateValue);
            }else {
                if (failure) failure(isFirstRequest,newStatus|stateValue);
            }
        }else {
            if (failure) failure(isFirstRequest,newStatus|stateValue);
        }
    }];
}

///系统权限关闭时，弹出系统窗口提示去设置开启蓝牙权限
- (void)requestPermissionShowPowerAlertWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                                           failure:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))failure{
    [self permissionWithSuccess:success failure:failure];
    [self showAlertbluetoothMonitor];
}
- (void)peripheralManagerDidUpdateState:(nonnull CBPeripheralManager *)peripheral {
    ZLBluetoothCapabilities capabilities ;
    switch (peripheral.state) {
        case CBManagerStateUnsupported:
        {
            capabilities = ZLBluetoothCapabilityUnsupported;
        }
            break;
        case CBManagerStateUnknown:{
            capabilities = ZLBluetoothCapabilityUnknown;
        }
            break;
        case CBManagerStateUnauthorized:{
            capabilities = ZLBluetoothCapabilityUnauthorized;
        }
            break;
        case CBManagerStateResetting: {
            capabilities = ZLBluetoothCapabilityResetting;
        }
            break;
        case CBManagerStatePoweredOff:{
            capabilities = ZLBluetoothCapabilityPoweredOff;
        }
            break;
        case CBManagerStatePoweredOn:{
            capabilities = ZLBluetoothCapabilityPoweredOn;
        }
            break;
        default:
            break;
    }
    [NSNotificationCenter.defaultCenter postNotificationName:kBluetoothFinishedNotification object:self.bluetoothMonitor userInfo:@{@"state":@(capabilities)}];
    _bluetoothMonitor = nil;
    _showAlertbluetoothMonitor = nil;
}
- (void)requestSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    [self requestPermissionWithSuccess:^(BOOL isFirst, ZLBluetoothCapabilities status) {
        if (success) success();
    } failure:^(BOOL isFirst, ZLBluetoothCapabilities status) {
        if (failure) failure();
    }];
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLBluetoothCapabilities status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirst, ZLBluetoothCapabilities status) {
        if (failure) failure(isFirst,status,ZLPermissionTypeBluetooth);
    }];
}
@end
