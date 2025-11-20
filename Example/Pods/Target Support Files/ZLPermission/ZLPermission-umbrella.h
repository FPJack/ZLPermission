#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZLPermission.h"
#import "ZLPermissionProtocol.h"
#import "ZLPermissionBluetooth.h"
#import "ZLPermissionCalendar.h"
#import "ZLPermissionCamera.h"
#import "ZLPermissionLocation.h"
#import "ZLPermissionMediaLibrary.h"
#import "ZLPermissionMicrophone.h"
#import "GMPermissionPhoto.h"
#import "ZLPermissionReminders.h"
#import "ZLPermissionTracking.h"

FOUNDATION_EXPORT double ZLPermissionVersionNumber;
FOUNDATION_EXPORT const unsigned char ZLPermissionVersionString[];

