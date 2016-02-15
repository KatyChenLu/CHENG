//
//  DetailViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/28.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "DetailViewController.h"
#import "MMParallaxPresenter.h"
#import "UIView+Common.h"
#import <AFNetworking/AFNetworking.h>
#import "DetailModel.h"
//#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "ImageViewController.h"
#import "XSportLight.h"
#import "DBManager.h"
#import "JWCache.h"
#import "NSString+Tools.h"
#import <UMengSocial/UMSocial.h>

@interface DetailViewController () <XSportLightDelegate,UMSocialUIDelegate>{
    UIImageView *_navImage;
    UIImageView *_bnavImage;
    NSMutableArray *_textArray;
    UIImageView *_imageView;
    UIView *_navView;
    UIButton *_backButton;
    UIButton *_shareButton;
    UIButton *_heartButton;
    UIImageView *_bigImageView;
    UIView *_backgroundView;
    NSMutableArray *_finalArray;
    NSURL *_imageUrl;
}
@property (nonatomic, strong) UIImage *buttondeimage;
@property (weak, nonatomic) IBOutlet MMParallaxPresenter *scrollView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setFrame:CGRectMake(64, 0, self.view.frame.size.width, self.view.frame.size.height+64)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    _textArray = [NSMutableArray array];
      _finalArray = [NSMutableArray new];
    [self downLoad];
    [self createMyNavigation];
    
}
- (void)viewWillAppear:(BOOL)animated {
   
    [super viewWillAppear:animated];
    [self refreshDetailUI];
    self.navigationController.navigationBarHidden = YES;
     [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    static NSInteger num = 0;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"] && num == 0) {
//        NSLog(@"*********");
        [self createSportLight];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        num++;
    }
  
}

- (void)createSportLight {
    
    
    SportLight = [[XSportLight alloc]init];
    
    SportLight.messageArray = @[@"试试点击收藏吧~"];
    SportLight.rectArray = @[             
                             [NSValue valueWithCGRect:CGRectMake(screenWidth()-20,40,100,100)]
                             ];

    SportLight.delegate = self;
    
    [self presentViewController:SportLight animated:false completion:^{
        
    }];
    
}
-(void)XSportLightClicked:(NSInteger)index{
//    NSLog(@"%ld",(long)index);
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[SDImageCache sharedImageCache] clearMemory];
    
}
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
- (void)createMyNavigation {
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), 64)];
    _navImage = [[UIImageView alloc] init];
    _navImage.frame =CGRectMake(screenWidth()-75, 25, 70, 40);
    _bnavImage = [[UIImageView alloc] init];
    _bnavImage.frame = CGRectMake(3, 27, 35, 35);
//    _navImage.image = [[UIImage imageNamed:@"Navbar_mask"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _bnavImage.layer.cornerRadius = 15;
    _bnavImage.layer.masksToBounds = YES;
    _bnavImage.backgroundColor = BLUECOLOR;
    [_navView addSubview:_bnavImage];
    _navImage.layer.cornerRadius = 15;
    _navImage.layer.masksToBounds = YES;
    _navImage.backgroundColor = BLUECOLOR;
    [_navView addSubview:_navImage];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(5, 30, 30, 30);
    [_backButton setImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(touchBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backButton];
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _shareButton.frame = CGRectMake(screenWidth()-70, 30, 30, 30);
    [_shareButton setImage:[[UIImage imageNamed:@"ic_nav_share_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(touchShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_shareButton];
    
    _heartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _heartButton.frame = CGRectMake(screenWidth() - 35, 35, 25, 25);
    
    
    [_heartButton addTarget:self action:@selector(touchHeartButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_heartButton];

    [self.view addSubview:_navView];

}
-(void)touchShareButton:(UIButton *)button {
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"https://itunes.apple.com/cn/app/xin-cheng/id1076204765?l=zh&ls=1&mt=8";
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"我在心城app中发现了一个好看的游记:%@",self.ShareTitle];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56976f2467e58ecf2b001d97"
                                      shareText:@"abc"
                                     shareImage:[UIImage imageNamed:@"Icon－1024"]
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ]
                                       delegate:self];
    
    
}
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    if (fromViewControllerType == UMSViewControllerShareList) {
//        NSLog(@"ok");
    }
}
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToSina) {
        socialData.shareText = @"分享到新浪微博的文字内容";
    }
    else{
        socialData.shareText = @"分享到其他平台的文字内容";
    }
}
-(void)touchHeartButton:(UIButton *)button {
    BOOL isExistRecord = [[DBManager sharedManager] isExistAppForMid:_fModel.Mid];
    
    if (isExistRecord) {
        [[DBManager sharedManager] deleteModelForMid:_fModel.Mid];
        _heartButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _heartButton.alpha= 1.0;
        
//        [_heartButton setBackgroundImage:[UIImage imageNamed:] forState:UIControlStateNormal];
    } else {
        [[DBManager sharedManager] insertModel:_fModel];
        [UIView animateWithDuration:0.3 animations:^{
            [_heartButton setBackgroundImage:nil forState:UIControlStateNormal];
//            [_heartButton setBackgroundImage:[UIImage imageNamed:heartImageName] forState:UIControlStateNormal];
            _heartButton.transform = CGAffineTransformMakeScale(2.0, 2.0);
            
            _heartButton.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_heartButton setBackgroundImage:nil forState:UIControlStateNormal];
            [_heartButton setBackgroundImage:[UIImage imageNamed:@"ic_nav_black_heart_on"] forState:UIControlStateNormal];
            _heartButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            _heartButton.alpha= 1.0;
        }];
    }
    BOOL isExistRecord1 = [[DBManager sharedManager] isExistAppForMid:_fModel.Mid];
    [self setHeatButton:isExistRecord1];
}
- (void)setHeatButton:(BOOL)isFavourete {
    NSString *oFavourete = isFavourete?@"ic_nav_black_heart_on":@"ic_nav_heart_white_off";
      [_heartButton setBackgroundImage:[UIImage imageNamed:oFavourete] forState:UIControlStateNormal];
}
- (void)touchBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downLoad {
    NSString *detailUrl = [NSString stringWithFormat:DetailURL,_Id];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(detailUrl)];
    if (cacheeData) {
        DetailModel *model = [[DetailModel alloc]initWithData:cacheeData error:nil];
        [self performSelectorOnMainThread:@selector(asfasf:) withObject:model waitUntilDone:NO];
        [self refreshDetailUI];
        
    }else {
    
    [manager GET:detailUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        DetailModel *model = [[DetailModel alloc]initWithData:responseObject error:nil];
        [self performSelectorOnMainThread:@selector(asfasf:) withObject:model waitUntilDone:NO];
        [self refreshDetailUI];
        /**
         *  缓存
         */
        
        [JWCache setObject:responseObject forKey:MD5(detailUrl)];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    }
}
- (void)refreshDetailUI {
    BOOL isExistRecord = [[DBManager sharedManager] isExistAppForMid:_fModel.Mid];
    [self setHeatButton:isExistRecord];
}
- (void)asfasf:(DetailModel *)model
{
    NSInteger tripDaysNum = model.trip_days.count;
    
    for (int i = 0; i<tripDaysNum; i++) {
        TripDaysModel *tripDaysModel = model.trip_days[i];
        NSInteger nodesNum = tripDaysModel.nodes.count;
        for (int j = 0; j<nodesNum; j++) {
            NodesModel *nodesModel = tripDaysModel.nodes[j];
            NSInteger notesNum = nodesModel.notes.count;
            for (int k = 0; k<notesNum; k++) {
                NotesModel *notesModel = nodesModel.notes[k];
                NSString *strtext = notesModel.Ddescription;
                if (notesModel.photoUrl) {
                    NSString *strurl = notesModel.photoUrl;
                    [_textArray addObject:@[strurl,@"url"]];
                }else {
                    [_textArray addObject:@[strtext,@"text"]];
                }
            }
        }
        
    }
    
    NSInteger num = _textArray.count;
  
    if (num >= 50) {
        for (int i = 0;  i<50; i++) {
            _finalArray[i] = _textArray[i];
        }
    }
    
    CGRect rect =  CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    NSInteger m = 1;
    for (int n = 1; n<50; n++) {
        NSString *str0 = _textArray[n-1][1];
        NSString *str1 = _textArray[n][1];
        NSString *section = [NSString stringWithFormat:@"Section %ld",m];
        if ([str0 isEqualToString:@"text"] && [str1 isEqualToString:@"url"]) {
            //*******1
            MMParallaxPage *page = [[MMParallaxPage alloc] initWithScrollFrame:rect withHeaderHeight:0 withContentText:_textArray[n-1][0] andContextImage:[UIImage imageNamed:@"CategoryIcon10"]];
            
            [self.scrollView addParallaxPage:page];
            
        }else if ([str0 isEqualToString:@"text"] && [str1 isEqualToString:@"text"]) {
            //*****2
            MMParallaxPage *page = [[MMParallaxPage alloc] initWithScrollFrame:rect withHeaderHeight:0 withContentText:_textArray[n-1][0] andContextImage:[UIImage imageNamed:@"CategoryIcon10"]];
            [self.scrollView addParallaxPage:page];
            
            
        }else if ([str0 isEqualToString:@"url"] && [str1 isEqualToString:@"text"]) {
            //*****3
            MMParallaxPage *page = [[MMParallaxPage alloc] initWithScrollFrame:rect withHeaderHeight:300 withContentText:_textArray[n][0] andContextImage:[UIImage imageNamed:@"CategoryIcon10"]];
      
            UIButton *huhuButton = [UIButton buttonWithType:UIButtonTypeSystem];
            
            __weak DetailViewController *WeakSelf = self;
            [huhuButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_textArray[n-1][0]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                WeakSelf.buttondeimage = image;
//                   _imageUrl = imageURL;
            }];
            [huhuButton addTarget:self action:@selector(touchesImage:) forControlEvents:UIControlEventTouchUpInside];
            [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
            
            [page.headerView addSubview:huhuButton];
         
            [page.headerLabel setText:section];
            m++;
            
            [page setTitleAlignment:MMParallaxPageTitleBottomLeftAlignment];
            
            [self.scrollView addParallaxPage:page];
        }else if ([str0 isEqualToString:@"url"] && [str1 isEqualToString:@"url"]) {
            //*****4
            MMParallaxPage *page = [[MMParallaxPage alloc] initWithScrollFrame:rect withHeaderHeight:300 withContentText:nil andContextImage:nil];
            
           UIButton *huhuButton = [UIButton buttonWithType:UIButtonTypeSystem];
              __weak DetailViewController *WeakSelf = self;
            [huhuButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_textArray[n-1][0]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                  WeakSelf.buttondeimage = image;
//                _imageUrl = imageURL;
                
            }];
            [huhuButton addTarget:self action:@selector(touchesImage:) forControlEvents:UIControlEventTouchUpInside];
            
            [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
  
            [page.headerView addSubview:huhuButton];
            
            [page.headerLabel setText:section];
            m++;
            [page setTitleAlignment:MMParallaxPageTitleBottomLeftAlignment];
            
            [self.scrollView addParallaxPage:page];
            
        }
        
    }
    
    
}
- (void)touchesImage:(UIButton *)button {
    
    ImageViewController *ivc = [ImageViewController new] ;
    ivc.image = button.currentBackgroundImage;
    [ivc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:ivc animated:YES completion:^{
        self.view.backgroundColor = [UIColor clearColor] ;
    }];
    
    
    
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
