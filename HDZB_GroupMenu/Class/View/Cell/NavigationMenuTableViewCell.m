//
//  NavigationMenuCellTableViewCell.m
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "NavigationMenuTableViewCell.h"
@interface NavigationMenuTableViewCell()
@property(strong,nonatomic)UIView *leftColorView;
@property(strong,nonatomic)UILabel *nameLabel;
@end

//左边色彩条宽度
static const CGFloat leftColorViewWidth=3;
//文字字体大小
static const CGFloat textDefaultFontSize=15;
static const CGFloat textSelectedFontSize=18;

@implementation NavigationMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背影色
        self.backgroundColor=[UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        if (self.leftColorView==nil) {
            self.leftColorView=[[UIView alloc]init];
            self.leftColorView.backgroundColor=[UIColor blueColor];
            self.leftColorView.hidden=YES;
            [self.contentView addSubview:self.leftColorView];
            self.leftColorView.sd_layout
            .leftSpaceToView(self.contentView, 0)
            .topSpaceToView(self.contentView, 0)
            .bottomSpaceToView(self.contentView, 0)
            .widthIs(leftColorViewWidth);
        }
        
        if (self.nameLabel==nil) {
            self.nameLabel=[[UILabel alloc]init];
            self.nameLabel.font=[UIFont systemFontOfSize:textDefaultFontSize];
            self.nameLabel.textAlignment=NSTextAlignmentCenter;
            [self.nameLabel sizeToFit];
            [self.nameLabel setText:self.curLeftTagModel.tagName];
            [self.contentView addSubview:self.nameLabel];
//            self.nameLabel.sd_layout
//            .centerXEqualToView(self)
//            .centerYEqualToView(self)
//            .heightIs(20);
            self.nameLabel.sd_layout
            .leftSpaceToView(self.leftColorView, 3)
            .rightSpaceToView(self.contentView, 3)
            .centerYEqualToView(self.leftColorView)
            .heightIs(20);

        }
    }
    return self;
}

-(void)setHasBeenSelected:(BOOL)hasBeenSelected
{
    _hasBeenSelected=hasBeenSelected;
    if (_hasBeenSelected) {
        self.backgroundColor=[UIColor whiteColor];
        self.nameLabel.textColor=[UIColor greenColor];
        self.nameLabel.font=[UIFont systemFontOfSize:textSelectedFontSize];
        self.leftColorView.hidden=NO;
    }
    else
    {
        self.backgroundColor=[UIColor grayColor];
        self.nameLabel.textColor=[UIColor blackColor];
        self.nameLabel.font=[UIFont systemFontOfSize:textDefaultFontSize];
        self.leftColorView.hidden=YES;
    }
}

-(void)setCurLeftTagModel:(NavigationModel *)curLeftTagModel
{
    _curLeftTagModel=curLeftTagModel;
    self.nameLabel.text=_curLeftTagModel.tagName;
}
@end
