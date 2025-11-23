//
//  ZLButton.h
//  ZLPermission_Example
//
//  Created by Qiuxia Cui on 2025/11/23.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ZLButtonType)
{
    ZLButtonTypeNotDetermined,
    ZLButtonTypeAuthorized,
    ZLButtonTypeDenied
};
@interface ZLButton : UIButton
@property (nonatomic,assign)ZLButtonType type;
@end

NS_ASSUME_NONNULL_END
