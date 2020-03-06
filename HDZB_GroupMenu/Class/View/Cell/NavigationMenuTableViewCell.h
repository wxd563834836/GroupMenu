//
//  NavigationMenuCellTableViewCell.h
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationModel.h"
#import "SDAutoLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface NavigationMenuTableViewCell : UITableViewCell

@property(strong,nonatomic) NavigationModel *curLeftTagModel;
//是否被选中
@property(assign,nonatomic)BOOL hasBeenSelected;

@end

NS_ASSUME_NONNULL_END
