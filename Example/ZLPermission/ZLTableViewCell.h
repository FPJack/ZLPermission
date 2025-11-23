//
//  ZLTableViewCell.h
//  ZLPermission_Example
//
//  Created by Qiuxia Cui on 2025/11/23.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet ZLButton *button;
@property (nonatomic,copy)void (^requestPermission) (void);
@property (nonatomic,copy)void (^goSetting) (void);
@end

NS_ASSUME_NONNULL_END
