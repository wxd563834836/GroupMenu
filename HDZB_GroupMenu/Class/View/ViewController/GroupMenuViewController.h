//
//  GroupMenuViewController.h
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationModel.h"
#import "ContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GroupMenuViewController : UIViewController
//左边列表的数据源
@property (nonatomic, strong) NSMutableArray *dataList;
//右边列表数据源
@property(nonatomic,strong)NSMutableArray *allRightDataList;
@end

NS_ASSUME_NONNULL_END
