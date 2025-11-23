# ZLPermission

同一套API方法支持iOS 15种权限申请(定位，蓝牙功能支持同时多处地方申请共享同一次结果回调)，健康权限例外，单独的一个API方法调用

[![CI Status](https://img.shields.io/travis/fanpeng/ZLPermission.svg?style=flat)](https://travis-ci.org/fanpeng/ZLPermission)
[![Version](https://img.shields.io/cocoapods/v/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)
[![License](https://img.shields.io/cocoapods/l/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)
[![Platform](https://img.shields.io/cocoapods/p/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)

## Example

    1.以相机为例只返回成功失败结果
    [ZLPermission.camera requestPermissionWithSuccess:^{
            
    } failure:^{
            
    }];
    
    2.失败返回失败状态码
    [ZLPermission.camera requestPermissionWithSuccess:^{
        
    } failureWithStatus:^(ZLAuthorizationStatus status) {
        
    }];
    
    3.成功失败返回都返回状态码
    [ZLPermission.camera requestPermissionOnlyStatusWithSuccess:^(ZLAuthorizationStatus status) {
        
    } failure:^(ZLAuthorizationStatus status) {
        
    }];
    
    4.成功失败返回都返回状态码以及返回是否是初次申请
    [ZLPermission.camera requestPermissionStatusWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
        
    } failure:^(BOOL isFirst, ZLAuthorizationStatus status) {
        
    }];
    
    5.成功失败返回都返回状态码以及返回是否是初次申请，失败还返回申请权限类型方便统一做失败结果处理
    [ZLPermission.camera requestPermissionStatusWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
        
    } failureWithType:^(BOOL isFirst, NSInteger status, ZLPermissionType type) {
        
    }];
    
    

## Requirements

## Installation

ZLPermission is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
  //一次性倒入
  pod 'ZLPermission'
  //按需导入
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

```

## Author

fanpeng, 2551412939@qq.com

## License

ZLPermission is available under the MIT license. See the LICENSE file for more info.
