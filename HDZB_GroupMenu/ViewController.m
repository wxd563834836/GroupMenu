//
//  ViewController.m
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "ViewController.h"
#import "GroupMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *leftArray = [[NSMutableArray alloc] init];
    NSMutableArray *rightArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<10; i++) {
        
        //左边列表数据
        NavigationModel *item=[[NavigationModel alloc]init];
        item.tagID=i;
        item.tagName=[NSString stringWithFormat:@"第%d层",i];
        [leftArray addObject:item];
        
        //右边列表数据
        for (int j=0; j<55; j++) {
            ContentModel *model=[[ContentModel alloc]init];
            model.tagID=i;
            model.roomID=j;
            model.roomName=[NSString stringWithFormat:@"%d层房%d",i,j];
            model.roomImageUrl=[NSString stringWithFormat:@"room%d",j%5];
            [rightArray addObject:model];
        }
    }
    GroupMenuView *view=[[GroupMenuView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-300) leftArray:leftArray rightArray:rightArray];
    [self.view addSubview:view];
}


- (IBAction)btnClick:(id)sender {
    
    GroupMenuViewController *vc=[[GroupMenuViewController alloc] init];
    //测试数据
    NSMutableArray *leftArray = [[NSMutableArray alloc] init];
    NSMutableArray *rightArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<10; i++) {
        
        //左边列表数据
        NavigationModel *item=[[NavigationModel alloc]init];
        item.tagID=i;
        item.tagName=[NSString stringWithFormat:@"第%d层",i];
        [leftArray addObject:item];
        
        //右边列表数据
        for (int j=0; j<55; j++) {
            ContentModel *model=[[ContentModel alloc]init];
            model.tagID=i;
            model.roomID=j;
            model.roomName=[NSString stringWithFormat:@"%d层房%d",i,j];
            model.roomImageUrl=[NSString stringWithFormat:@"room%d",j%5];
            [rightArray addObject:model];
        }
    }
    vc.dataList=leftArray;
    vc.allRightDataList=rightArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)secondClick:(id)sender {
    
}
@end
