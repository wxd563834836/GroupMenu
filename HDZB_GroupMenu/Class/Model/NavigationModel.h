//
//  NavigationModel.h
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavigationModel : NSObject
//ID值
@property(assign,nonatomic)long tagID;
//名称
@property(copy,nonatomic)NSString *tagName;

//图标地址（为后期可能带图标做准备）
@property(copy,nonatomic)NSString *tagImageUrl;

//这个来定位右边数据源滚动的位置
@property(assign,nonatomic) float offsetScorller;
@end

NS_ASSUME_NONNULL_END
