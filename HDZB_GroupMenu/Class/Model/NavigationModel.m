//
//  NavigationModel.m
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "NavigationModel.h"

@implementation NavigationModel
-(void)setTagID:(long)tagID{
    _tagID=tagID;
}
-(void)setTagName:(NSString *)tagName{
    _tagName=tagName;
}
-(void)setTagImageUrl:(NSString *)tagImageUrl{
    _tagImageUrl=tagImageUrl;
}

@end
