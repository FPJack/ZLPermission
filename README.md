
# ZLPermission

iOS 快捷方便的权限申请库，支持 **15 种常用权限**，调用方式简单统一，同时保留各权限特有的状态码。  
定位、蓝牙支持多处同时申请共享同一次授权结果回调；健康数据、相册等权限提供专用 API。

[![CI Status](https://img.shields.io/travis/fanpeng/ZLPermission.svg?style=flat)](https://travis-ci.org/fanpeng/ZLPermission)
[![Version](https://img.shields.io/cocoapods/v/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)
[![License](https://img.shields.io/cocoapods/l/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)
[![Platform](https://img.shields.io/cocoapods/p/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)

<p align="center">
  <img src="https://github.com/FPJack/ZLPermission/blob/master/test.png" width="240" alt="ZLPermission Logo">
</p>

## 示例（以相机为例，其他权限调用方式完全一致）

> 注意：在使用前请确保已在 `Info.plist` 中添加对应的权限描述文案（`Privacy - XXX Usage Description`）。  
> Siri 权限需要付费的 Apple Developer 账号并在开发者门户开启相应功能。

```objc
#import <ZLPermission/ZLPermission.h>

// 1. 只关心成功或失败
[ZLPermission.camera requestPermissionWithSuccess:^{
    NSLog(@"相机权限授权成功");
} failure:^{
    NSLog(@"相机权限被拒绝");
}];

// 2. 失败时返回具体状态码
[ZLPermission.camera requestPermissionWithSuccess:^{
    NSLog(@"授权成功");
} failureWithStatus:^(ZLAuthorizationStatus status) {
    NSLog(@"授权失败，状态码：%ld", (long)status);
}];

// 3. 成功与失败都返回状态码
[ZLPermission.camera requestPermissionOnlyStatusWithSuccess:^(ZLAuthorizationStatus status) {
    NSLog(@"授权成功，状态：%ld", (long)status);
} failure:^(ZLAuthorizationStatus status) {
    NSLog(@"授权失败，状态：%ld", (long)status);
}];

// 4. 返回状态码 + 是否为首次申请
[ZLPermission.camera requestPermissionStatusWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
    NSLog(@"成功 - 首次申请：%d，状态：%ld", isFirst, (long)status);
} failure:^(BOOL isFirst, ZLAuthorizationStatus status) {
    NSLog(@"失败 - 首次申请：%d，状态：%ld", isFirst, (long)status);
}];

// 5. 最完整回调（失败时额外返回权限类型，方便统一处理）
[ZLPermission.camera requestPermissionStatusWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
    // success
} failureWithType:^(BOOL isFirst, NSInteger status, ZLPermissionType type) {
    NSLog(@"失败 - 首次：%d，状态：%ld，类型：%ld", isFirst, (long)status, (long)type);
}];

// 6. 直接获取当前权限状态（不触发系统弹框）
ZLAuthorizationStatus status = [ZLPermission.camera getPermissionStatus];
NSLog(@"当前相机权限状态：%ld", (long)status);

// 7. 快速判断是否已授权
BOOL authorized = [ZLPermission.camera hasPermission];
if (authorized) {
    // 可以直接使用相机
}
其他权限使用方式完全相同，只需替换 .camera 为对应权限即可：
Objective-C
ZLPermission.photo          // 相册
ZLPermission.location       // 定位（支持共享回调）
ZLPermission.microphone     // 麦克风
ZLPermission.notification   // 推送通知
ZLPermission.mediaLibrary   // 媒体库（Apple Music）
ZLPermission.bluetooth      // 蓝牙（支持共享回调）
ZLPermission.contacts       // 通讯录
ZLPermission.health         // 健康数据（特殊 API）
ZLPermission.calendar       // 日历
ZLPermission.motion         // 运动与健身
ZLPermission.reminders      // 提醒事项
ZLPermission.speechRecognition // 语音识别
ZLPermission.tracking       // App Tracking Transparency（iOS 14+）
ZLPermission.siri           // Siri
部分权限（如健康、蓝牙、定位、相册）提供额外的专用方法，详见对应头文件或子模块说明。

Requirements
iOS 9.0+
Xcode 12+
Swift 5 / Objective-C 兼容
Installation
CocoaPods（推荐）
Ruby
# 导入全部权限
pod 'ZLPermission'

# 按需导入（推荐，可大幅减小包体积）
pod 'ZLPermission/camera'
pod 'ZLPermission/photo'
pod 'ZLPermission/location'
pod 'ZLPermission/microphone'
pod 'ZLPermission/notification'
pod 'ZLPermission/mediaLibrary'
pod 'ZLPermission/bluetooth'
pod 'ZLPermission/contacts'
pod 'ZLPermission/health'
pod 'ZLPermission/calendar'
pod 'ZLPermission/motion'
pod 'ZLPermission/reminders'
pod 'ZLPermission/speechRecognition'
pod 'ZLPermission/tracking'
pod 'ZLPermission/siri'
执行安装：

Bash
pod install
Author
fanpeng, 2551412939@qq.com

ZLPermission is available under the MIT license. See the LICENSE file for more info.