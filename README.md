# ZLPermission
iOS快捷方便的权限申请库，支持常用的15种权限申请，方法调用简单统一的同时还保留了各个权限申请特有的状态码，定位,蓝牙功能支持同时多处地方申请共享同一次结果回调,健康数据权限申请查看特有的API方法调用

[![CI Status](https://img.shields.io/travis/fanpeng/ZLPermission.svg?style=flat)](https://travis-ci.org/fanpeng/ZLPermission)
[![Version](https://img.shields.io/cocoapods/v/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)
[![License](https://img.shields.io/cocoapods/l/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)
[![Platform](https://img.shields.io/cocoapods/p/ZLPermission.svg?style=flat)](https://cocoapods.org/pods/ZLPermission)


<p align="center">
  <img src="https://github.com/FPJack/ZLPermission/blob/master/test.png" width="200" alt="项目Logo">
</p>
## 例子
    以相机为例，其他权限申请一致,申请权限时确保plistInfo里面已添加了相对应的权限申请说明,siri权限申请需要付费开发者账号开通
```objc

    1.只返回成功失败结果
    
        [ZLPermission.camera requestPermissionWithSuccess:^{
                
        } failure:^{
                
        }];
    
    2.失败返回失败状态码
    
        [ZLPermission.camera requestPermissionWithSuccess:^{
            
        } failureWithStatus:^(ZLAuthorizationStatus status) {
            
        }];
    
    3.成功失败都返回状态码
    
        [ZLPermission.camera requestPermissionOnlyStatusWithSuccess:^(ZLAuthorizationStatus status) {
            
        } failure:^(ZLAuthorizationStatus status) {
            
        }];
    
    4.成功失败都返回状态码以及返回是否是初次申请
    
        [ZLPermission.camera requestPermissionStatusWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
            
        } failure:^(BOOL isFirst, ZLAuthorizationStatus status) {
            
        }];
    
    5.成功失败都返回状态码以及返回是否是初次申请，失败还返回申请权限类型方便统一做失败结果处理
    
        [ZLPermission.camera requestPermissionStatusWithSuccess:^(BOOL isFirst, ZLAuthorizationStatus status) {
            
        } failureWithType:^(BOOL isFirst, NSInteger status, ZLPermissionType type) {
            
        }];
    
    6.获取相对应的权限状态码
    
        [ZLPermission.camera getPermissionStatus];
    
    7.直接获取是否已授权
    
        [ZLPermission.camera hasPermission];

    8.差别权限申请查看相对应的API方法,例如（相册，蓝牙，定位，健康...）
```

    

    

## Requirements

## Installation

cocoapods 导入

```ruby

  一次性倒入
  pod 'ZLPermission'
  
  按需导入
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
