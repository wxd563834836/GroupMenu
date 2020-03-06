//
//  ContentMenuCollectionViewCell.h
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
#import "SDAutoLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContentMenuCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic)ContentModel *curNoHeadRightModel;

+(CGSize)ccellSize;
@end

NS_ASSUME_NONNULL_END
