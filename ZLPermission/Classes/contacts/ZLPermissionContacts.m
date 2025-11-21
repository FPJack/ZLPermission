//
//  ZLPermissionContacts.m
//  ZLPermission
//
//  Created by admin on 2025/11/21.
//

#import "ZLPermissionContacts.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
@implementation ZLPermissionContacts
- (BOOL)hasPermission {
    ZLContactsAuthorizationStatus status = self.getPermissionStatus;
    return status == ZLContactsAuthorizationStatusAuthorized || status == ZLContactsAuthorizationStatusLimited;
}

- (ZLContactsAuthorizationStatus)parseStatus:(CNAuthorizationStatus)status {
    switch(status){
        case CNAuthorizationStatusNotDetermined:
            return ZLContactsAuthorizationStatusNotDetermined;
        case CNAuthorizationStatusRestricted:
            return ZLContactsAuthorizationStatusRestricted;
        case CNAuthorizationStatusDenied:
            return ZLContactsAuthorizationStatusDenied;
        case CNAuthorizationStatusAuthorized:
            return ZLContactsAuthorizationStatusAuthorized;
        case CNAuthorizationStatusLimited:
            return ZLContactsAuthorizationStatusLimited;
        default:
            return ZLContactsAuthorizationStatusDenied;
    }
}
- (ZLContactsAuthorizationStatus)getPermissionStatus {
    return [self parseStatus:[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]];
}
- (void)requestPermissionWithSuccess:(void(^)(BOOL isFirst, ZLContactsAuthorizationStatus status))success
                             failure:(void(^)(BOOL isFirst, ZLContactsAuthorizationStatus status))failure{
    ZLContactsAuthorizationStatus status = [self getPermissionStatus];
    switch (status)
    {
        case ZLContactsAuthorizationStatusAuthorized:
        {
            if (success) success(NO,status);
        }
            break;
        case ZLContactsAuthorizationStatusDenied:
        case ZLContactsAuthorizationStatusRestricted:
        {
            if (failure) failure(NO,status);
        }
            break;
        case ZLContactsAuthorizationStatusNotDetermined:
        {
            [[CNContactStore new] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted && error == nil) {
                        if (success) success(YES, [self getPermissionStatus]);
                    }else {
                        if (failure) failure(YES, [self getPermissionStatus]);
                    }
                });
            }];
        }
            break;
        case ZLContactsAuthorizationStatusLimited:
            if (success) success(NO,status);
            break;
    }
}

@end
