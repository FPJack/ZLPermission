//
//  ZLHKRes.h
//  ZLPermission
//
//  Created by admin on 2025/11/21.
//

#import <Foundation/Foundation.h>
#import <ZLPermission/ZLPermissionProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLHKRes : NSObject
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, assign) ZLHealthAuthorizationStatus status;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, strong) NSError *error;
@end

NS_ASSUME_NONNULL_END
