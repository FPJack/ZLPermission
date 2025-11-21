//
//  ZLPermissionSpeechRecognition.m
//  Pods
//
//  Created by admin on 2025/11/21.
//

#import "ZLPermissionSpeechRecognition.h"
#import <Speech/Speech.h>
@implementation ZLPermissionSpeechRecognition
- (BOOL)hasPermission {
    return self.getPermissionStatus == ZLSiriAuthorizationStatusAuthorized;
}
- (ZLSpeechRecognizerAuthorizationStatus)getPermissionStatus {
    return [self parseStatus:[SFSpeechRecognizer authorizationStatus]];
}
- (ZLSpeechRecognizerAuthorizationStatus)parseStatus:(SFSpeechRecognizerAuthorizationStatus)status {
    switch(status){
        case SFSpeechRecognizerAuthorizationStatusNotDetermined:
            return ZLSpeechRecognizerAuthorizationStatusNotDetermined;
        case SFSpeechRecognizerAuthorizationStatusDenied:
            return ZLSpeechRecognizerAuthorizationStatusDenied;
        case SFSpeechRecognizerAuthorizationStatusRestricted:
            return ZLSpeechRecognizerAuthorizationStatusRestricted;
        case SFSpeechRecognizerAuthorizationStatusAuthorized:
            return ZLSpeechRecognizerAuthorizationStatusAuthorized;
        default:
            return ZLSpeechRecognizerAuthorizationStatusDenied;
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status))failure {
    ZLSpeechRecognizerAuthorizationStatus status = [self getPermissionStatus];
    if (status == ZLSpeechRecognizerAuthorizationStatusNotDetermined) {
        if (@available(iOS 10.0, *)) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZLSpeechRecognizerAuthorizationStatus s = [self getPermissionStatus];
                    if (s == ZLSpeechRecognizerAuthorizationStatusAuthorized) {
                        if (success) success(YES,s);
                    } else {
                        if (failure) failure(YES,s);
                    }
                });
            }];
        } else {
            if (failure) failure(YES,ZLSpeechRecognizerAuthorizationStatusDenied);
        }
    } else if (status == ZLSpeechRecognizerAuthorizationStatusAuthorized) {
        if (success) success(NO,status);
    } else {
        if (failure) failure(NO,status);
    }
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status))success
                     failureWithType:(void(^)(BOOL isFirst,NSInteger status,ZLPermissionType type))failure{
    [self requestPermissionWithSuccess:success failure:^(BOOL isFirst, ZLSpeechRecognizerAuthorizationStatus status) {
        if (failure) failure(isFirst,status,ZLPermissionTypeSpeechRecognizer);
    }];
}
@end
