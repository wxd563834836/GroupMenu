//
//  GroupMenuView.m
//  HDZB_GroupMenu
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "GroupMenuView.h"
#import "NavigationMenuTableViewCell.h"
#import "ContentMenuCollectionViewCell.h"
@interface GroupMenuView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UITableView *myTableView;

//右边列表的过滤数据源
@property(nonatomic,strong)NSMutableArray *rightdataList;

//当前被选中的ID值
@property(strong,nonatomic)NavigationModel *curSelectModel;
//右边列表
@property (strong, nonatomic) UICollectionView *myCollectionView;
//是否保持右边滚动时位置
@property(assign,nonatomic) BOOL isKeepScrollState;
@property(assign,nonatomic) BOOL isReturnLastOffset;
@property(assign,nonatomic) NSInteger selectIndex;
@end
//表格的宽度
static const CGFloat tableWidthSize=80;
//行的高度
static const CGFloat tableCellHeight=44;
//表格跟集合列表的空隙
static const CGFloat leftMargin =10;
@implementation GroupMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame leftArray:(NSMutableArray*)leftArray rightArray:(NSMutableArray*)rightArray{
    if(self=[super initWithFrame:frame]){
        _dataList=leftArray;
        _allRightDataList=rightArray;
        [self createUI];
    }
    return self;
}
//-(void)setDataList:(NSMutableArray *)dataList{
//    _dataList=dataList;
//}
//-(void)setAllRightDataList:(NSMutableArray *)allRightDataList{
//    _allRightDataList=allRightDataList;
//}
-(void)createUI{
    //初始化
    self.backgroundColor=[UIColor whiteColor];
    //    self.dataList=[[NSMutableArray alloc]init];
    self.rightdataList=[[NSMutableArray alloc]init];
    //    self.allRightDataList=[[NSMutableArray alloc]init];
    self.isReturnLastOffset=YES;
    //是否允许右位保持滚动位置
    self.isKeepScrollState=YES;
    //    //测试数据
    //    for (int i=0; i<10; i++) {
    //
    //        //左边列表数据
    //        NavigationModel *item=[[NavigationModel alloc]init];
    //        item.tagID=i;
    //        item.tagName=[NSString stringWithFormat:@"第%d层",i];
    //        [self.dataList addObject:item];
    //
    //        //右边列表数据
    //        for (int j=0; j<55; j++) {
    //            ContentModel *model=[[ContentModel alloc]init];
    //            model.tagID=i;
    //            model.roomID=j;
    //            model.roomName=[NSString stringWithFormat:@"%d层房%d",i,j];
    //            model.roomImageUrl=[NSString stringWithFormat:@"room%d",j%5];
    //            [self.allRightDataList addObject:model];
    //        }
    //    }
    
    //创建列表
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,tableWidthSize, kScreenHeight) style:UITableViewStylePlain];
        _myTableView.backgroundColor=[UIColor grayColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
        _myTableView.separatorColor= [UIColor colorWithRed:52.0f/255.0f green:53.0f/255.0f blue:61.0f/255.0f alpha:1];
        [_myTableView registerClass:[NavigationMenuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NavigationMenuTableViewCell class])];
        
        if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            self.myTableView.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            self.myTableView.separatorInset=UIEdgeInsetsZero;
        }
        [self addSubview:_myTableView];
    }
    
    //创建集合表格
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(tableWidthSize+leftMargin,64, kScreenWidth-tableWidthSize-2*leftMargin, kScreenHeight) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor=[UIColor whiteColor];
        self.myCollectionView.showsHorizontalScrollIndicator=NO;
        self.myCollectionView.showsVerticalScrollIndicator=NO;
        [self.myCollectionView registerClass:[ContentMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ContentMenuCollectionViewCell class])];
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
        [self addSubview:self.myCollectionView];
    }
    
    self.selectIndex=0;
    //默认选择第一个
    if (self.dataList.count>0) {
        self.curSelectModel=[self.dataList objectAtIndex:self.selectIndex];
        [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.myTableView reloadData];
        
        //右边数据加载
        [self predicateDataSoure];
    }
}
-(void)predicateDataSoure
{
    //过滤右边的集合数据
    NSPredicate *pre=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"tagID=%ld",self.curSelectModel.tagID]];
    self.rightdataList=[[self.allRightDataList filteredArrayUsingPredicate:pre] mutableCopy];
    [self.myCollectionView reloadData];
}
#pragma mark UITableViewDelegate/DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NavigationMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NavigationMenuTableViewCell class]) forIndexPath:indexPath];
    cell.curLeftTagModel = [self.dataList objectAtIndex:indexPath.section];
    cell.hasBeenSelected = (cell.curLeftTagModel==self.curSelectModel);
    
    //修改表格行默认分隔线存空隙的问题
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectIndex=indexPath.section;
    self.curSelectModel=[self.dataList objectAtIndex:indexPath.section];
    [self.myTableView reloadData];
    
    [self predicateDataSoure];
    //处理点击在滚动置顶的问题
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset=NO;
    
    if (self.isKeepScrollState) {
        [self.myCollectionView scrollRectToVisible:CGRectMake(0, self.curSelectModel.offsetScorller, self.myCollectionView.frame.size.width, self.myCollectionView.frame.size.height) animated:NO];
    }
    else{
        
        [self.myCollectionView scrollRectToVisible:CGRectMake(0, 0, self.myCollectionView.frame.size.width, self.myCollectionView.frame.size.height) animated:NO];
    }
}
#pragma mark UICollectionViewDelegate/Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.rightdataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ContentMenuCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ContentMenuCollectionViewCell class]) forIndexPath:indexPath];
    ContentModel *model=[self.rightdataList objectAtIndex:indexPath.row];
    ccell.curNoHeadRightModel=model;
    return ccell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [ContentMenuCollectionViewCell ccellSize];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ContentModel *model=[self.rightdataList objectAtIndex:indexPath.row];
    NSLog(@"你选择的%@",model.roomName);
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.myCollectionView]) {
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.myCollectionView]) {
        NavigationModel * item=self.dataList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.myCollectionView]) {
        NavigationModel * item=self.dataList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.myCollectionView] && self.isReturnLastOffset) {
        NavigationModel * item=self.dataList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
    }
}
@end
