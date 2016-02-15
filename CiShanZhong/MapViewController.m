//
//  MapViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/22.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "UIView+Common.h"
#import "UIViewController+RESideMenu.h"
#import "UIView+Common.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
#define APIKey  @"f281159c14e86c807eeabe0da137db63"

@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    
    CLLocation *_currentLocation;
    UIButton *_locationButton;
    
    UITableView *_tableView;
    NSArray *_poisArray;
    NSMutableArray *_annotations;
    
    UILongPressGestureRecognizer *_longPressGesture;
    MAPointAnnotation *_destinationPoint;
    NSArray *_pathPolylines;
    
    BOOL _isFollow;
    BOOL _isShowTraffic;
    BOOL _mapType;
    
    UIButton *_headButton;
    BOOL _isHidHeadButton;
}
@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.IDa = @"JGH";
    [self initMapView];
    [self createRightTable];
    [self initAttributes];
    [self initControls];
    [self  createSearch];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"地图";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:25];
    self.navigationItem.titleView = titleLabel;
}
- (void)createSearch {
        //配置用户Key
    [AMapSearchServices sharedServices].apiKey = APIKey;
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initTableView];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)initAttributes
{
    _annotations = [NSMutableArray array];
    _poisArray = nil;
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    
    _longPressGesture.delegate = self;
    _longPressGesture.minimumPressDuration = 0.5;
    _mapView.userInteractionEnabled = YES;
    [_mapView addGestureRecognizer:_longPressGesture];
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
    
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView] toCoordinateFromView:_mapView];
        if (_destinationPoint != nil) {
            // 清理
            [_mapView removeAnnotation:_destinationPoint];_destinationPoint = nil;
            
            [_mapView removeOverlays:_pathPolylines];
            _pathPolylines = nil;
        }
        _destinationPoint = [[MAPointAnnotation alloc] init];
        _destinationPoint.coordinate = coordinate;
        _destinationPoint.title = @"目的地";
        [_mapView addAnnotation:_destinationPoint];
    }
}
- (void)createRightTable {
    UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchbutton setBackgroundImage:[[UIImage imageNamed:@"SearchBarButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [searchbutton addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:searchbutton];
    searchbutton.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = barButtonItem1;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [backButton setBackgroundImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(touchesBack) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
- (void)touchesBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initTableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.scrollsToTop = NO;
        [self.view addSubview:_tableView];
    }
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _headButton.frame = CGRectZero;
        [self.view addSubview:_headButton];
    }
    
}
-(void)setIDa:(NSString *)IDa {
    _IDa = IDa;
    NSLog(@"%@",_IDa);
    [self searchAction:IDa];
    
}
- (void)searchAction:(NSString *)string {
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    
    request.keywords = string;
    request.sortrule = 0;
    request.requireExtension = YES;
    [_search AMapPOIAroundSearch:request];
}
//实现POI搜索对应的回调函数

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0) {
        
        NSLog(@"kkkkkkkkkkkkkkkkkk");
        return;
    }
    _poisArray = response.pois;
    _tableView.frame = CGRectMake(0, screenHeight()/2+100,screenWidth(),screenHeight()/2-100);
    [_tableView reloadData];
    _headButton.frame = CGRectMake(0, minY(_tableView)-30, screenWidth(), 30);
    [_headButton setImage:[UIImage imageNamed:@"IconArrowDown"] forState:UIControlStateNormal];
    _isHidHeadButton = YES;
    _headButton.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    [_headButton addTarget:self action:@selector(touchesHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
    
}
- (void)touchesHeadButton:(UIButton *)headButton {
    if (_isHidHeadButton) {
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, screenHeight(),screenWidth(),screenHeight()/2-100);
            [_tableView reloadData];
            _headButton.frame = CGRectMake(0, minY(_tableView)-30, screenWidth(), 30);
            [_headButton setImage:[UIImage imageNamed:@"IconArrowUp"] forState:UIControlStateNormal];
            
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, screenHeight()/2+100,screenWidth(),screenHeight()/2-100);
            _headButton.frame = CGRectMake(0, minY(_tableView)-30, screenWidth(), 30);
            [_headButton setImage:[UIImage imageNamed:@"IconArrowDown"] forState:UIControlStateNormal];
        }];
    }
    _headButton.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_headButton.bounds      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight    cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _headButton.bounds;
    maskLayer.path = maskPath.CGPath;
    _headButton.layer.mask = maskLayer;
    
    _isHidHeadButton = !_isHidHeadButton;
}
- (void)initControls{
    //定位按钮
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.frame = CGRectMake(20, CGRectGetHeight(_mapView.bounds) - 80, 40, 40);
    _locationButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin;
    _locationButton.backgroundColor = [UIColor whiteColor];
    _locationButton.layer.cornerRadius = 5;
    [_locationButton addTarget:self action:@selector(locateAction)
              forControlEvents:UIControlEventTouchUpInside];
    [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    [_mapView addSubview:_locationButton];
    
    UIButton *pathButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pathButton.frame = CGRectMake(screenWidth() - 50, CGRectGetHeight(_mapView.bounds) - 80, 40, 40);
    pathButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin;
    pathButton.backgroundColor = [UIColor whiteColor];
    [pathButton setImage:[UIImage imageNamed:@"path"] forState:UIControlStateNormal];
    [pathButton addTarget:self action:@selector(pathAction)
         forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:pathButton];
    
}
- (void)pathAction{
    
    if (_destinationPoint == nil || _currentLocation == nil || _search == nil)
    {
        NSLog(@"path search failed");
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"请长摁地图选择目的地"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *oAction = [UIAlertAction actionWithTitle:@"(⊙o⊙)哦" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:oAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    
    AMapWalkingRouteSearchRequest *walkRequest = [[AMapWalkingRouteSearchRequest alloc] init];
    // 设置为步⾏行路径规划
    
    walkRequest.origin = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude
                                                  longitude:_currentLocation.coordinate.longitude];
    walkRequest.destination = [AMapGeoPoint locationWithLatitude:_destinationPoint.coordinate.latitude
                                                       longitude:_destinationPoint.coordinate.longitude];
    [_search AMapWalkingRouteSearch:walkRequest];
}
#pragma mark - Helpers

- (void)locateAction
{
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        
        [_search AMapReGoecodeSearch:request];
    }
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length) {
        title = response.regeocode.addressComponent.province;
    }
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
}


#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    // 修改定位按钮状态
    if (mode == MAUserTrackingModeNone)
    {
        [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }
    else
    {
        [_locationButton setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //    NSLog(@"userLocation: %@", userLocation.location);
    _currentLocation = [userLocation.location copy];
}
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    // 选中定位annotation的时候进行逆地理编码查询
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        [self reGeoAction];
    }
}
- (void)initMapView {
    [MAMapServices sharedServices].apiKey = APIKey;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())];
    
    _mapView.delegate = self;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 86);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 86);
    _isShowTraffic = NO;
    _mapView.showTraffic = _isShowTraffic;
    _isFollow = YES;
    [_mapView setUserTrackingMode:_isFollow animated:YES];
    
    _mapView.mapType = _mapType?MAMapTypeSatellite:MAMapTypeStandard;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    [self Userfollow];
    
}
- (void)Userfollow {
    UIButton *loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loadButton.frame = CGRectMake(screenWidth()-45, 170, 35, 35);
    loadButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin;
    loadButton.backgroundColor = BLUECOLOR;
    loadButton.layer.cornerRadius = 5;
    [loadButton addTarget:self action:@selector(loadButtonButton)
         forControlEvents:UIControlEventTouchUpInside];
    [loadButton setImage:[UIImage imageNamed:@"DestinationMenuIcon2"] forState:UIControlStateNormal];
    [_mapView addSubview:loadButton];
    
    UIButton *tran3DButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tran3DButton.frame = CGRectMake(screenWidth()-45, 130, 35, 35);
    tran3DButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin;
    tran3DButton.backgroundColor = BLUECOLOR;
    tran3DButton.layer.cornerRadius = 5;
    [tran3DButton addTarget:self action:@selector(touchestran3DButton)
           forControlEvents:UIControlEventTouchUpInside];
    [tran3DButton setImage:[UIImage imageNamed:@"tran3D"] forState:UIControlStateNormal];
    [_mapView addSubview:tran3DButton];
    
}
- (void)touchestran3DButton {
    if (_mapType) {
        _mapView.mapType = MAMapTypeStandard;
    } else {
        _mapView.mapType = MAMapTypeSatellite;
    }
    _mapType = !_mapType;
}
- (void)loadButtonButton {
    _mapView.showTraffic = !_isShowTraffic;
    _isShowTraffic = !_isShowTraffic;
}
- (void)touchesMapButton {
    if (_isFollow) {
        [_mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];//不追踪
    }else {
        [_mapView setUserTrackingMode: MAUserTrackingModeFollowWithHeading animated:YES]; //地图跟着位置移动
    }
    _isFollow = !_isFollow;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0  blue:250/255.0 alpha:1.0];
    }else {
        cell.backgroundColor = [UIColor colorWithRed:176/255.0 green:226/255.0  blue:255/255.0 alpha:1.0];
    }
    
    
    AMapPOI *poi = _poisArray[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _poisArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    AMapPOI *poi = _poisArray[indexPath.row];
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    annotation.title = poi.name;
    annotation.subtitle = poi.address;
    [_mapView addAnnotation:annotation];
    [_annotations addObject:annotation];
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if (annotation == _destinationPoint)
    {
        static NSString *reuseIndetifier = @"startAnnotationReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView
                                                                       dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        //可以显示气泡
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"PinHotelNormal"];
        annotationView.centerOffset = CGPointMake(0, -20);
        //        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    return nil;
}
#pragma mark - AMapSearchDelegate

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request :%@, error :%@", request, error);
}
- (MAPolylineView *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    
    if ([overlay isKindOfClass:[overlay class]])
    {
        
        
        MAPolylineView *polylineView = [[MAPolylineView alloc]initWithOverlay:overlay];
        
        
        polylineView.lineWidth   = 4;
        polylineView.strokeColor = [UIColor magentaColor];
        return polylineView;
    }
    
    return nil;
}
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    
    if (response.count > 0)
    {
        [_mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;
        _pathPolylines = [self polylinesForPath:response.route.paths[0]];
        [_mapView addOverlays:_pathPolylines];
        
        [_mapView showAnnotations:@[_destinationPoint,_mapView.userLocation] animated:YES];
    }
}
- (NSArray *)polylinesForPath:(AMapPath *)path{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string coordinateCount:(NSUInteger *)coordinateCount parseToken:(NSString *)token

{
    if (string == nil)
    {
        return NULL;
    }
    if (token == nil)
    {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else
    {
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    return coordinates;
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
