//
//  ContentMenuCollectionViewCell.m
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "ContentMenuCollectionViewCell.h"
@interface ContentMenuCollectionViewCell()
@property(strong,nonatomic)UIImageView *roomImageView;
@property(strong,nonatomic)UILabel *roomLabel;
@end
static const CGFloat collectionCellHeight=80;
static const CGFloat labelHeight=20;
@implementation ContentMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.roomImageView==nil) {
            self.roomImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-80-10*3)/3, collectionCellHeight-labelHeight)];
            self.roomImageView.contentMode=UIViewContentModeScaleAspectFill;
            self.roomImageView.clipsToBounds = YES;
            self.roomImageView.layer.masksToBounds = YES;
            self.roomImageView.layer.cornerRadius = 2.0;
            [self.contentView addSubview:self.roomImageView];
        }
        
        if (self.roomLabel==nil) {
            self.roomLabel=[[UILabel alloc]init];
            self.roomLabel.font=[UIFont systemFontOfSize:15];
            self.roomLabel.textAlignment=NSTextAlignmentCenter;
            [self.roomLabel sizeToFit];
            [self.roomLabel setText:self.curNoHeadRightModel.roomName];
            [self.contentView addSubview:self.roomLabel];
            self.roomLabel.sd_layout
            .topSpaceToView(self.roomImageView, 2)
            .leftSpaceToView(self.contentView, 3)
            .rightSpaceToView(self.contentView, 3)
            .heightIs(labelHeight);
        }
    }
    return self;
}

-(void)setCurNoHeadRightModel:(ContentModel *)curNoHeadRightModel
{
    _curNoHeadRightModel=curNoHeadRightModel;
    self.roomImageView.image=[UIImage imageNamed:_curNoHeadRightModel.roomImageUrl];
    self.roomLabel.text=_curNoHeadRightModel.roomName;
}


+(CGSize)ccellSize
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-80-10*3)/3,collectionCellHeight);
}
@end
