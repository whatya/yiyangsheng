//
//  MealCell.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-6.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "MealCell.h"
#import <CoreLocation/CoreLocation.h>
#import "GloblalSharedDataManager.h"

@interface MealCell ()
@property (weak, nonatomic) IBOutlet AsycImageView *hotelImage;
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UITextView *hotelAddress;
@property (weak, nonatomic) IBOutlet UILabel *mealTime;
@property (weak, nonatomic) IBOutlet UILabel *mealFoodType;
@property (weak, nonatomic) IBOutlet UILabel *mealDistance;

@end

@implementation MealCell


- (void)setMealModel:(NSDictionary *)mealModel
{
    _mealModel = mealModel;
    //更新ui
    self.hotelImage.imageUrl = [NSString stringWithFormat:@"%@%@",serverImageUrl,self.mealModel[@"hotelPic"]];
    self.hotelName.text = self.mealModel[@"hotelName"];
    self.hotelAddress.text = self.mealModel[@"hotelAddr"];
    self.mealTime.text = [self.mealModel[@"dinnerTime"] substringToIndex:16];
    self.mealFoodType.text = self.mealModel[@"cookStyle"];

    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.mealModel[@"latitude"] doubleValue] longitude:[self.mealModel[@"longitude"] doubleValue]];
    if ([GloblalSharedDataManager sharedDataManager].GPSLocation) {
        int distance = (int)[location distanceFromLocation:[GloblalSharedDataManager sharedDataManager].GPSLocation];
        if(distance >= 1000){
            self.mealDistance.text =[NSString stringWithFormat:@"%d千米",distance/1000];
        }else{
            self.mealDistance.text =[NSString stringWithFormat:@"%d米",distance];
        }
       //
    }else{
        self.mealDistance.text = @"计算中..";
    }
   
}

@end
