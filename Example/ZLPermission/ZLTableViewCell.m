//
//  ZLTableViewCell.m
//  ZLPermission_Example
//
//  Created by Qiuxia Cui on 2025/11/23.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import "ZLTableViewCell.h"

@implementation ZLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tap {
    if (self.button.type ==  ZLButtonTypeDenied) {
        if (self.goSetting) {
            self.goSetting();
        }
    }else if (self.button.type == ZLButtonTypeNotDetermined) {
        if (self.requestPermission) {
            self.requestPermission();
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
