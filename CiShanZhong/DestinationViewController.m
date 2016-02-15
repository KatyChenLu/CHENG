//
//  DestinationViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "DestinationViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "DestinationModel.h"
#import "UIView+Common.h"
#import "DestinatineCollectionViewCell.h"
#import "CollectionHeaderReusableView.h"
#import "CLSegmentControlView.h"
#import "DestinationDetailViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
@interface DestinationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate> {
    AFHTTPRequestOperationManager *_manager;
    UICollectionView *_collectionView;
    UICollectionView *_otherCollectionView;

    NSArray *_arr;
    NSMutableArray *_dataArray;
    NSMutableArray *_otherDataArray;

    CLSegmentControlView *_view;
    CGFloat _collectionViewOffet;
    CGFloat _lastOffset;
   
}
@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationTitle:@"攻略"];
    _arr = [NSArray new];
    _dataArray = [NSMutableArray new];
    _otherDataArray = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self downLoadFromNet];
    [self createSegmentControlView];
    [self createScrollView];
    [self createCollectionView];
    [self createBarButtons];
    
}
- (void)createSegmentControlView {
     _view= [[CLSegmentControlView alloc] initWithFrame:CGRectMake(0, 64, screenWidth(), 50)];
    _view.titles = @[@"国外",@"国内"];

     __weak typeof(self) weakSelf = self;
    [_view setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
//        NSLog(@"%ld",tag);
        [weakSelf.scrollView setContentOffset:CGPointMake(screenWidth()*tag, 0) animated:YES];
        
        
    }];
    [self.view addSubview:_view];
}
- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 114, screenWidth(), screenHeight()-40-50)];
    _scrollView.contentSize = CGSizeMake(screenWidth()*2, screenHeight()-40-64);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;

    [self.view addSubview:_scrollView];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    scrollView = _scrollView;
    CGFloat scrollViewOffsetX = _scrollView.contentOffset.x;
//    NSLog(@"%f",scrollViewOffsetX);
  static  NSInteger tag = 0;
    if (scrollViewOffsetX >= screenWidth()) {
        tag = 1;
    }else if (scrollViewOffsetX < screenWidth()) {
        tag = 0;
    }

    [_view refreshtTagOfButton:tag];
}
-(void)createCollectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight()-154) collectionViewLayout:[self createLayout]];
        _collectionView.backgroundColor = [UIColor clearColor];
        //        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        UINib *cellNib = [UINib nibWithNibName:@"DestinatineCollectionViewCell" bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"huhu"];
        
        UINib *headerNib = [UINib nibWithNibName:@"CollectionHeaderReusableView" bundle:nil];
        [_collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"huhuheader"];
        _collectionView.delegate = self;
        
        [_scrollView addSubview:_collectionView];
    }
    if (_otherCollectionView == nil) {
        _otherCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(screenWidth(), 0, screenWidth(), screenHeight()-154) collectionViewLayout:[self createLayout]];
        _otherCollectionView.backgroundColor = [UIColor clearColor];
        //        _collectionView.delegate = self;
        _otherCollectionView.dataSource = self;
        
        UINib *cellNib = [UINib nibWithNibName:@"DestinatineCollectionViewCell" bundle:nil];
        [_otherCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"huhu"];
        
        UINib *headerNib = [UINib nibWithNibName:@"CollectionHeaderReusableView" bundle:nil];
        [_otherCollectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"huhuheader"];
        _otherCollectionView.delegate = self;
        
        [_scrollView addSubview:_otherCollectionView];
    }
}
- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat padding = 5;
    CGFloat itemsWidth = screenWidth()/2-8;

    layout.itemSize = CGSizeMake(itemsWidth, itemsWidth*3/2);
    layout.sectionInset = UIEdgeInsetsMake(padding,padding/2,padding,padding/2);

    
    return layout;
}
- (void)downLoadFromNet {
    _manager = [AFHTTPRequestOperationManager manager];
         _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    _manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(DestinationURL)];
    if (cacheeData) {
        NSError *error = nil;
        _arr= [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        [self createData:_arr];
        
    }else {
    
    [_manager GET:DestinationURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        _arr= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        [self createData:_arr];
        /**
         *  缓存
         */
        
        [JWCache setObject:responseObject forKey:MD5(DestinationURL)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    }
}
- (void)createData:(NSArray *)arr {
    for (NSDictionary *dic in arr) {
        DestinationModel *model = [[DestinationModel alloc]initWithDictionary:dic error:nil];
     
        if ([model.category integerValue] < 10) {
            [_dataArray addObject:model];
        }else {
            [_otherDataArray addObject:model];
        }
    }
//    NSLog(@"%ld",_otherDataArray.count);
    [_collectionView reloadData];
    [_otherCollectionView reloadData];
}
//TODO:UICollectionViewDataSource回调方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
      static  NSInteger number = 0;
    if ([collectionView isEqual:_collectionView]) {
      number = _dataArray.count;
    }else if ([collectionView isEqual:_otherCollectionView]){
        number = _otherDataArray.count;
    }
    return number;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        DestinationModel *model = [DestinationModel new];
    if ([collectionView isEqual:_collectionView]) {
       model  = _dataArray[section];
    }else if ([collectionView isEqual:_otherCollectionView]){
        model = _otherDataArray[section];
    }

    return model.destinations.count;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    CollectionHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"huhuheader" forIndexPath:indexPath];
    DestinationModel *model = [DestinationModel new];
    if ([collectionView isEqual:_collectionView]) {
        model = _dataArray[indexPath.section];
    }else if ([collectionView isEqual:_otherCollectionView]) {
        model = _otherDataArray[indexPath.section];
    }
  
    NSInteger num = [model.category integerValue];
    
    [view updateTitle:num];
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(screenWidth(), 50);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DestinatineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"huhu" forIndexPath:indexPath];
    DestinationModel *model = [DestinationModel new];
    if ([collectionView isEqual:_collectionView]) {
        model = _dataArray[indexPath.section];
    }else if ([collectionView isEqual:_otherCollectionView]) {
        model = _otherDataArray[indexPath.section];
    }
    cell.model = model.destinations[indexPath.item];
//    NSLog(@"%ld",[model.destinations count]);
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //TODO:详情页面
    DestinationModel *model = [DestinationModel new];
    if ([collectionView isEqual:_collectionView]) {
        model = _dataArray[indexPath.section];
    }else if ([collectionView isEqual:_otherCollectionView]) {
        model = _otherDataArray[indexPath.section];
    }
    DestinationsModel *model1 =model.destinations[indexPath.item];

 
    DestinationDetailViewController *dvc = [DestinationDetailViewController new];
    dvc.hidesBottomBarWhenPushed = YES;
    dvc.Id = model1.Did;
//    dvc.title = [NSString stringWithFormat:@"%@攻略",model1.name_zh_cn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = [NSString stringWithFormat:@"%@攻略",model1.name_zh_cn];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:25];
    
    dvc.navigationItem.titleView = titleLabel;
//    dvc.title
//    NSLog(@"1111");
    [self.navigationController pushViewController:dvc animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _collectionView || scrollView == _otherCollectionView) {
        _collectionViewOffet = scrollView.contentOffset.y;
      
        if (_collectionViewOffet - _lastOffset > 20 && _collectionViewOffet > 0) {
            _lastOffset = _collectionViewOffet;
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.tabBar.frame = CGRectMake(0, screenHeight(), screenWidth(), 44);
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                
                _view.frame = CGRectMake(0, 0, screenWidth(), 50);
                _scrollView.frame = CGRectMake(0, 50, screenWidth(), screenHeight()-50);
                _collectionView.frame = CGRectMake(0, 0,  _scrollView.frame.size.width, _scrollView.frame.size.height);
                _otherCollectionView.frame = CGRectMake(screenWidth(), 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            }];
            
            
        }else if ((_lastOffset - _collectionViewOffet > 20) && (_collectionViewOffet <= scrollView.contentSize.height - scrollView.bounds.size.height-20)) {
            _lastOffset = _collectionViewOffet;
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.tabBar.frame = CGRectMake(0, screenHeight() - 44, screenWidth(), 44);
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                _view.frame = CGRectMake(0, 64, screenWidth(), 50);
                _scrollView.frame =  CGRectMake(0, 114, screenWidth(), screenHeight()-164);
                _collectionView.frame = CGRectMake(0, 0,  _scrollView.frame.size.width, _scrollView.frame.size.height);
                _otherCollectionView.frame = CGRectMake(screenWidth(), 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            }];
            
            
        }

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
