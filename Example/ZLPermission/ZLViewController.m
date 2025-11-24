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
#import <CoreMotion/CoreMotion.h>
#import <ZLPermission/ZLPermissionHealth.h>
#import "ZLTableViewCell.h"

@interface ZLViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *datas;
@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray  *arr = NSMutableArray.array;
    for (int i  = 0 ; i < 15; i ++) {
        [self.tableView registerNib:[UINib nibWithNibName:@"ZLTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%d",i]];
        [arr addObject:@(i)];
    }
    self.datas = arr;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
   
    
}
- (void)appDidBecomeActive{
    [self.tableView  reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = [NSString stringWithFormat:@"%ld",indexPath.row];
    ZLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    ZLPermissionType type = indexPath.row * 10;
    NSString *title = [self permissionName:type];
    cell.titleLab.text = title;
    ZLButtonType buttonType;
    cell.goSetting = ^{
        [self goSetting:type];
    };
    switch (type) {
        case ZLPermissionTypeLocation:
        {
            if (ZLPermission.location.getPermissionStatus == ZLLocationAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.location.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.location requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeCamera:
        {
            if (ZLPermission.camera.getPermissionStatus == ZLAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.camera.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.camera requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypePhoto:
        {
            if (ZLPermission.photo.getPermissionStatus == ZLPhotoAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.photo.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.photo requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeMicrophone:
        {
            if (ZLPermission.microphone.getPermissionStatus == ZLMicrophoneAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.microphone.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.microphone requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeNotification:
        {
            if (ZLPermission.notification.getPermissionStatus == ZLNotificationAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.notification.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.notification requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeBluetooth:
        {
            if (ZLPermission.bluetooth.getPermissionStatus == ZLBluetoothCapabilityNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.bluetooth.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.bluetooth requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeMediaLibrary:
        {
            if (ZLPermission.mediaLibrary.getPermissionStatus == ZLAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.mediaLibrary.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.mediaLibrary requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeCalendar:
        {
            if (ZLPermission.calendar.getPermissionStatus == ZLEventAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.calendar.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.calendar requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeReminders:
        {
            if (ZLPermission.reminders.getPermissionStatus == ZLEventAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.reminders.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.reminders requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeHealth:
        {
            
            HKQuantityTypeIdentifier distance = HKQuantityTypeIdentifierDistanceWalkingRunning;
            ZLHealthAuthorizationStatus status = [ZLPermission.health getPermissionStatusWithHKObjectType:distance];
            if (status == ZLHealthAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = status == ZLHealthAuthorizationStatusAuthorized ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.health requestPermissionWithWriteTypes:@[distance] readTypes:@[distance] success:^(NSArray<ZLHKRes *> * _Nonnull results) {
                    [self.tableView reloadData];
                } failure:^(NSArray<ZLHKRes *> * _Nonnull results) {
                    [self.tableView reloadData];
                }];
    
            };
            break;
        }
        case ZLPermissionTypeContacts:
        {
            
            if (ZLPermission.contacts.getPermissionStatus == ZLContactsAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.contacts.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.contacts requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeTracking:
        {
            if (ZLPermission.tracking.getPermissionStatus == ZLAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.tracking.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.tracking requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
//        case ZLPermissionTypeSiri:
//        {
//            if (ZLPermission.siri.getPermissionStatus == ZLSiriAuthorizationStatusNotDetermined) {
//                buttonType  = ZLButtonTypeNotDetermined;
//            }else {
//                buttonType = ZLPermission.siri.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
//            }
//            cell.requestPermission = ^{
//                [ZLPermission.siri requestPermissionWithSuccess:^{
//                    [tableView reloadData];
//                } failure:^{
//                    [tableView reloadData];
//                }];
//            };
//            break;
//        }
        case ZLPermissionTypeSpeechRecognizer:
        {
            if (ZLPermission.speechRecognizer.getPermissionStatus == ZLSpeechRecognizerAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.speechRecognizer.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.speechRecognizer requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        case ZLPermissionTypeMotion:
        {
            if (ZLPermission.motion.getPermissionStatus == ZLMotionAuthorizationStatusNotDetermined) {
                buttonType  = ZLButtonTypeNotDetermined;
            }else {
                buttonType = ZLPermission.motion.hasPermission ? ZLButtonTypeAuthorized : ZLButtonTypeDenied;
            }
            cell.requestPermission = ^{
                [ZLPermission.motion requestPermissionWithSuccess:^{
                    [tableView reloadData];
                } failure:^{
                    [tableView reloadData];
                }];
            };
            break;
        }
        default:
            break;
    }
    
    cell.button.type = buttonType;
    return cell;
}


- (void)requestHealthPermission {
#ifdef ZLPermissionRequestHealthEnabled
    [ZLPermissionHealth.share requestPermissionWithWriteTypes:@[
        HKQuantityTypeIdentifierDistanceWalkingRunning,
    ] readTypes:@[
        HKQuantityTypeIdentifierSwimmingStrokeCount
    ] success:^(NSArray<ZLHKRes *> * _Nonnull results) {
        NSLog(@"%@",results);
    } failure:^(NSArray<ZLHKRes *> * _Nonnull results) {
        NSLog(@"%@",results);
    }];
#endif
}
- (NSString *)permissionName:(ZLPermissionType)type {
    NSDictionary *dic = @{
        @(ZLPermissionTypeCamera):@"相机",
        @(ZLPermissionTypePhoto):@"相册",
        @(ZLPermissionTypeMicrophone):@"麦克风",
        @(ZLPermissionTypeLocation):@"定位",
        @(ZLPermissionTypeBluetooth):@"蓝牙",
        @(ZLPermissionTypeNotification):@"通知",
        @(ZLPermissionTypeMediaLibrary):@"媒体资料库",
        @(ZLPermissionTypeCalendar):@"日历",
        @(ZLPermissionTypeReminders):@"提醒事项",
        @(ZLPermissionTypeHealth):@"健康",
        @(ZLPermissionTypeContacts):@"通讯录",
        @(ZLPermissionTypeTracking):@"跟踪",
        @(ZLPermissionTypeSiri):@"Siri",
        @(ZLPermissionTypeSpeechRecognizer):@"语音识别",
        @(ZLPermissionTypeMotion):@"运动与健身",
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


@end
