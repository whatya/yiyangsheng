//
//  HotelGetterViewController.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-14.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "HotelGetterViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "GloblalSharedDataManager.h"

#import "PoiDetailViewController.h"
#import "CommonUtility.h"

@interface HotelGetterViewController ()
<MAMapViewDelegate,
AMapSearchDelegate,
UITableViewDataSource,
UITableViewDelegate,
UIActionSheetDelegate,
UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *BKview;
@property (weak, nonatomic) IBOutlet UITextField *keywordInput;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) NSArray *tips;

@property (nonatomic, strong)  CLLocationManager * locationManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *alphView;

@end

@implementation HotelGetterViewController
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.placeholder = nil;
    return YES;
}
- (IBAction)fire:(UIButton *)sender
{
    [self searchPoiByKeyword:self.keywordInput.text];
    [self.keywordInput resignFirstResponder];
    [self animateAlphview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchPoiByKeyword:textField.text];
    [textField resignFirstResponder];
    [self animateAlphview];
    return YES;
}


#pragma mark- viewDidLoad
- (IBAction)searchTips:(UITextField *)sender
{
    self.alphView.hidden = NO;
    [self searchTipsWithKey:sender.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.alphView.hidden = YES;
    [self initMapView];
    [self initSearch];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if (version >= 8.0) {
    self.locationManager =[[CLLocationManager alloc] init];
    
    [self.locationManager requestAlwaysAuthorization];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
    
    [self.locationManager requestWhenInUseAuthorization];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
    }
    self.mapView.showsUserLocation = YES;
    
    self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

}

#pragma mark- initialization

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.BKview.bounds];
    
    self.mapView.frame = self.BKview.bounds;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.delegate = self;
    
    [self.BKview addSubview:self.mapView];
    
    [self.BKview insertSubview:self.mapView atIndex:0];
    
//    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);

}

- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    self.search.delegate = self;
}


#pragma mark- searchBarVC delegate
/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    NSString *cityID = [GloblalSharedDataManager sharedDataManager].customer.getCityId;
    NSString *cityName =  [[GloblalSharedDataManager sharedDataManager] cityNameForKey:cityID];
    if ([cityName rangeOfString:@"市"].location != NSNotFound){
        cityName = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    }

    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city = @[cityName];
    [self.search AMapInputTipsSearch:tips];
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (!response.tips.count > 0) {
        self.alphView.hidden = YES;
        return;
    }
    self.tips = response.tips;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
    }
    
    AMapTip *tip = self.tips[indexPath.row];
    
    cell.textLabel.text = tip.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *tip = self.tips[indexPath.row];
    
    self.keywordInput.placeholder = tip.name;
    
    [self searchPoiByKeyword:tip.name];
    
    [self.keywordInput resignFirstResponder];
    
    [self animateAlphview];
}

- (void)animateAlphview
{
    CGPoint orignaCenter = self.alphView.center;
    CGPoint newCenter = CGPointMake(orignaCenter.x-2000, orignaCenter.y);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alphView.center = newCenter;
                     } completion:^(BOOL finished) {
                         self.alphView.hidden = YES;
                         self.alphView.center = orignaCenter;
                     }];

}

#pragma mark- searchDelegate

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id<MAAnnotation> annotation = view.annotation;
    
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
       // POIAnnotation *poiAnnotation = (POIAnnotation*)annotation;
        
        self.anotationTemp = (POIAnnotation*)annotation;
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:@"确认选择"
                                                  otherButtonTitles:@"查看详情", nil];
        [sheet showInView:self.view];
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"unwindToPostMeal" sender:self];
    }else if (buttonIndex == 1){
        PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
        detail.poi = self.anotationTemp.poi;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout            = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}

#pragma mark - AMapSearchDelegate

/* POI 搜索回调. */
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)respons
{
    //    if (request.searchType != self.searchType)
    //    {
    //        return;
    //    }
    
    if (respons.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:respons.pois.count];
    
    [respons.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        self.mapView.centerCoordinate = [poiAnnotations[0] coordinate];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:YES];
    }
}

/* 根据关键字来搜索POI. */
- (void)searchPoiByKeyword:(NSString*)keyWoard
{
    
    NSString *cityID = [GloblalSharedDataManager sharedDataManager].customer.getCityId;
    NSString *cityName =  [[GloblalSharedDataManager sharedDataManager] cityNameForKey:cityID];
    if ([cityName rangeOfString:@"市"].location != NSNotFound){
        cityName = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    }
    /* 清除存在的annotation. */
    [self.mapView removeAnnotations:self.mapView.annotations];
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    
    request.searchType          = AMapSearchType_PlaceKeyword;
    request.keywords            = keyWoard;
    request.city                = @[cityName];
    //request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    //request.radius = 1000000000;
    //request.types = @[@"050000"];
    request.requireExtension    = YES;
    [self.search AMapPlaceSearch:request];
}


@end
