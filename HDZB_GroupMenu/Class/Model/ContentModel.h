//
//  ContentModel.h
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentModel : NSObject
//实体leftTageModel中的主键值
@property(assign,nonatomic)long tagID;

@property(assign,nonatomic)long roomID;
@property(copy,nonatomic)NSString *roomName;
@property(copy,nonatomic)NSString *roomImageUrl;
@end

NS_ASSUME_NONNULL_END
