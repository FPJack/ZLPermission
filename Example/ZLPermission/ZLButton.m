//
//  ZLButton.m
//  ZLPermission_Example
//
//  Created by Qiuxia Cui on 2025/11/23.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import "ZLButton.h"

@implementation ZLButton

- (void)setType:(ZLButtonType)type{
    _type = type;
    if (type == ZLButtonTypeNotDetermined) {
        [self setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
        [self setTitle:@"申请" forState:UIControlStateNormal];
    }else if (type == ZLButtonTypeDenied){
        [self setTitle:@"已拒绝" forState:UIControlStateNormal];
        [self setTitleColor:UIColor.systemRedColor forState:UIControlStateNormal];
    }else {
        [self setTitle:@"已授权" forState:UIControlStateNormal];
        [self setTitleColor:UIColor.systemGreenColor forState:UIControlStateNormal];
    }
}
@end
