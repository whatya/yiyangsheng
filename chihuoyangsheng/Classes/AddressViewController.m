//
//  AddressViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-16.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "AddressViewController.h"
#import "GloblalSharedDataManager.h"
#import "AreaAreaServiceImplServiceSoapBinding.h"
#import "AppDelegate.h"

@interface AddressViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;



@property (weak, nonatomic) IBOutlet UIPickerView *addressPicker;

@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *addressLine;

@property (strong,nonatomic) NSDictionary *addressDictionary;
@property (nonatomic) NSUInteger provinceIndex;

@end

@implementation AddressViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *provinces = [self.addressDictionary allKeys];
    if (!provinces || provinces.count == 0) {
        return 0;
    }
    NSArray *cities = [self.addressDictionary objectForKey:provinces[self.provinceIndex]];
    if(component== 0)
    {
        return [provinces count];
    }
    else
    {
        return [cities count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    NSArray *provinces = [self.addressDictionary allKeys];
    if (!provinces || provinces.count == 0) {
        return nil;
    }
    NSArray *cities = [self.addressDictionary objectForKey:provinces[self.provinceIndex]];
    if(component == 0)
    {
        return [provinces objectAtIndex:row];
    }
    else
    {
        return [cities objectAtIndex:row];
    }
}

//确认选择地区
- (IBAction)affirmChooseAddress:(id)sender {
    
    GloblalSharedDataManager *dataManager = [GloblalSharedDataManager sharedDataManager];
    
    WhereAmI *loction = [WhereAmI shareLoaction];
    NSString *currentLocatoin = loction.currentLocation;
    if ([currentLocatoin isEqualToString:@"随便看看"]) {
        dataManager.province = self.provinceLabel.text;
        dataManager.provinceId = dataManager.provinceName_provinceID[self.provinceLabel.text];
        dataManager.cityName = self.cityLabel.text;
        dataManager.cityId = dataManager.cityName_cityID[self.cityLabel.text];
        
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate dismissLoginVC:nil];
        
        
    }else{
        dataManager.customer.province = self.provinceLabel.text;
        dataManager.customer.provinceId = dataManager.provinceName_provinceID[self.provinceLabel.text];
        //dataManager.customer.cityName = self.cityLabel.text;
        dataManager.customer.cityId = dataManager.cityName_cityID[self.cityLabel.text];
        [self performSegueWithIdentifier:@"show regist page" sender:nil];
    }
    
    


}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.provinceIndex = [self.addressPicker selectedRowInComponent:0];
    NSInteger cityComponentRow = [self.addressPicker selectedRowInComponent:1];

    NSArray *provinces = [self.addressDictionary allKeys];
    NSArray *cities = [self.addressDictionary objectForKey:provinces[self.provinceIndex]];
    
    self.provinceLabel.text = provinces[self.provinceIndex];
    self.cityLabel.text = cities[cityComponentRow];
   
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 

    
    self.addressView.layer.cornerRadius = 10;
    self.addressView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.addressView.layer.borderWidth = 1.0f;
    //_addressDictionary = [GloblalSharedDataManager sharedDataManager].addressDictionary;
    _addressDictionary =@{@"北京": @[@"北京"]} ;
}


- (void)setProvinceIndex:(NSUInteger)provinceIndex
{
    _provinceIndex = provinceIndex;
    [self.addressPicker reloadComponent:1];
}

@end
