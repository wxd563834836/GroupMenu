//
//  ContentModel.m
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel
-(void)setTagID:(long)tagID{
    _tagID=tagID;
}
-(void)setRoomID:(long)roomID{
    _roomID=roomID;
}
-(void)setRoomName:(NSString *)roomName{
    _roomName=roomName;
}
-(void)setRoomImageUrl:(NSString *)roomImageUrl{
    _roomImageUrl=roomImageUrl;
}
@end
