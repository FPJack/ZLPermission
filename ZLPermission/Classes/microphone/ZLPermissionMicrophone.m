//
//  ZLPermissionMicrophone.m
//  ZLPermission
//
//  Created by admin on 2025/11/20.
//

#import "ZLPermissionMicrophone.h"
#import <Photos/Photos.h>

@implementation ZLPermissionMicrophone
- (ZLMicrophoneAuthorizationStatus)parseStatus17:(AVAudioApplicationRecordPermission)status {
    switch(status){
        case AVAudioApplicationRecordPermissionUndetermined:
            return ZLMicrophoneAuthorizationStatusNotDetermined;
        case AVAudioApplicationRecordPermissionDenied:
            return ZLMicrophoneAuthorizationStatusDenied;
        case AVAudioApplicationRecordPermissionGranted:
            return ZLMicrophoneAuthorizationStatusAuthorized;
        default:
        return ZLMicrophoneAuthorizationStatusDenied;
    }
}
- (ZLMicrophoneAuthorizationStatus)getPermissionStatus{
    if (@available(iOS 17, *)) {
        return [self parseStatus17:AVAudioApplication.sharedInstance.recordPermission];
    } else {
        return [self parseStatus:AVAudioSession.sharedInstance.recordPermission];
    }
}

- (ZLMicrophoneAuthorizationStatus)parseStatus:(AVAudioSessionRecordPermission)status {
    switch(status){
        case AVAudioSessionRecordPermissionUndetermined:
            return ZLMicrophoneAuthorizationStatusNotDetermined;
        case AVAudioSessionRecordPermissionDenied:
            return ZLMicrophoneAuthorizationStatusDenied;
        case AVAudioSessionRecordPermissionGranted:
            return ZLMicrophoneAuthorizationStatusAuthorized;
        default:
        return ZLMicrophoneAuthorizationStatusDenied;
    }
}
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLMicrophoneAuthorizationStatusAuthorized;
}

- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLMicrophoneAuthorizationStatus status))failure{
    ZLMicrophoneAuthorizationStatus status = [self getPermissionStatus];
    if (status == ZLMicrophoneAuthorizationStatusNotDetermined) {
        if (@available(iOS 17, *)) {
            [AVAudioApplication requestRecordPermissionWithCompletionHandler:^(BOOL granted) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           if (granted) {
                               if (success) success(YES,self.getPermissionStatus);
                           }else {
                               if (failure) failure(YES,self.getPermissionStatus);
                           }
                       });
            }];
        } else {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (granted) {
                                if (success) success(YES,self.getPermissionStatus);
                            }else {
                                if (failure) failure(YES,self.getPermissionStatus);
                            }
                        });
            }];
        }
    }else if (status == ZLMicrophoneAuthorizationStatusDenied){
        if (failure) failure(NO,status);
    }else if (status == ZLMicrophoneAuthorizationStatusAuthorized){
        if (success) success(NO,status);
    }else {
        if (failure) failure(NO,status);
    }
}

@end
