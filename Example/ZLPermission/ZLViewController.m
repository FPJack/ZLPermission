//
//  ZLViewController.m
//  ZLPermission
//
//  Created by fanpeng on 11/19/2025.
//  Copyright (c) 2025 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLPermission/ZLPermission.h>
#import <ZLPermission/ZLPermissionProtocol.h>
#import <ZLPermission/ZLPermissionCamera.h>
@interface ZLViewController ()

@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self requestCameraPermission];
    [self requestPhotoPermission];
}


- (void)requestCameraPermission {
    [ZLPermission.camera requestPermissionWithSuccess:self.successCallback failureWithType:self.failureCallback];
}
- (void)requestPhotoPermission {
    [ZLPermission.photo requestPermissionWithSuccess:self.successCallback failureWithType:self.failureCallback];
}
- (void(^) (BOOL,NSInteger))successCallback {
    return ^(BOOL isFirst, NSInteger status){
        NSLog(@"success isFirst:%d status:%ld", isFirst, (long)status);
    };
}
- (void(^) (BOOL,NSInteger,ZLPermissionType))failureCallback {
    return ^(BOOL isFirst, NSInteger status, ZLPermissionType type){
        NSLog(@"%@ failure isFirst:%d status:%ld",[self permissionName:type], isFirst, (long)status);
        [self goSetting:type];
    };
}
- (NSString *)permissionName:(ZLPermissionType)type {
    NSDictionary *dic = @{
        @(ZLPermissionTypeCamera):@"相机",
        @(ZLPermissionTypePhoto):@"相册",
    };
    return dic[@(type)];
}
- (void)goSetting:(ZLPermissionType)type {
    NSString *name = [self permissionName:type];
    NSString *title = [NSString stringWithFormat:@"没有%@权限",name];
    NSString *msg = [NSString stringWithFormat:@"前往设置页面，打开%@权限",name];
    [ZLPermission showAlertWithTitle:title msg:msg cancel:@"取消" setting:@"去打开" completion:^{
        [ZLPermission goToAppSystemSetting];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
