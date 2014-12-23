//
//  PostMealTVC.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-8.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//


#import "PostMealTVC.h"
#import "HotelGetterViewController.h"
#import "FoodTypeGetterTVC.h"
#import "TimeGetterVC.h"
#import "POIAnnotation.h"
#import "MealService.h"
#import "NSData+HexImage.h"
#import "GloblalSharedDataManager.h"
#import "ProgressHUD.h"
#import "PriceInputVC.h"
#import "DescriptionInputVC.h"
#import "WhereAmI.h"

@interface PostMealTVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *hotelNameTextView;

@property (weak, nonatomic) IBOutlet UITextView *hotelAddressTextView;
@property (weak, nonatomic) IBOutlet UITextView *mealTimeTextView;
@property (weak, nonatomic) IBOutlet UITextView *uiniPriceTextView;
@property (weak, nonatomic) IBOutlet UITextView *foodTypeTextView;
@property (weak, nonatomic) IBOutlet UITextView *mealDescription;


@property (weak, nonatomic) IBOutlet UIButton *tapToAddImage;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImage;

@property (strong,nonatomic) POIAnnotation *annotation;
@property (strong,nonatomic) NSString *customerID;

@end

@implementation PostMealTVC


#pragma mark- 去掉弹出界面
- (IBAction)dismissSelf:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

#pragma mark- ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customerID = [GloblalSharedDataManager sharedDataManager].customer.get_id;
    //NSLog(@"customer id : %@",self.customerID);
}

#pragma mark- 按下确定按钮
- (IBAction)doneButtonClicked:(UIButton *)sender
{
    NSString *str = [WhereAmI shareLoaction].currentLocation;
    if ([str isEqualToString:@"随便看看"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请登录！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.hotelNameTextView.text.length == 0 ||
        [self.hotelNameTextView.text isEqualToString:@"必填"]||
        self.hotelAddressTextView.text.length == 0 ||
        [self.hotelAddressTextView.text isEqualToString:@"必填"] ||
        self.mealTimeTextView.text.length == 0 ||
        [self.mealTimeTextView.text isEqualToString:@"必填"] ||
        self.foodTypeTextView.text.length == 0 ||
        [self.foodTypeTextView.text isEqualToString:@"必填"]) {
        return;
    }
    
    [self postMeal];
}

#pragma mark- 发起饭局
- (void)postMeal
{
    
    
    
    [ProgressHUD show:@"提交数据中！"];
    NSData *imageData = UIImageJPEGRepresentation(self.hotelImage.image, 0.1);// UIImagePNGRepresentation(self.hotelImage.image);
    NSString* hexString = [imageData hexRepresentationWithSpaces_AS:NO];
    
    NSString *priceStirng = self.uiniPriceTextView.text;
    
    if ([priceStirng isEqualToString:@"请输入价格"]) {
        priceStirng = @"0.0";
    }
    
    NSString *mealDetailString = self.mealDescription.text;
    if ([mealDetailString isEqualToString:@"请输入饭局详情"]) {
        mealDetailString = @" ";
    }
    
    NSString *postParamJson = [NSString stringWithFormat: @"dinnerParty={'hotelName':'%@','hotelPic':'pinner.png','hotelAddr':'%@','dinnerTime':'%@','price':%f,'cookStyle':'%@','detail':'%@','longitude':%f,'latitude':%f,'creater':{'customerId':'%@','customerType':'0'}}&imgFile=%@",
                               self.hotelNameTextView.text,
                               self.hotelAddressTextView.text,
                               self.mealTimeTextView.text,
                               [priceStirng doubleValue],
                               self.foodTypeTextView.text,
                               mealDetailString,
                               self.annotation.coordinate.longitude,
                               self.annotation.coordinate.latitude,
                               self.customerID,hexString];
    
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"saveDinnerParty.ws?"
                                          queryString:postParamJson
                                             callBack:^(id callBack) {
                                                 NSString *success = callBack;
                                                 if ([success isEqualToString:@"0"]) {
                                                     [ProgressHUD showSuccess:@"饭局发起成功！"];
                                                     [self dismissViewControllerAnimated:YES completion:NULL];
                                                 }else{
                                                    [ProgressHUD showError:@"饭局发起失败"];
                                                     
                                                 }
                                             }];
}


#pragma mark- alertView 弹出框
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}



#pragma mark- unwind methods
-(IBAction)unwindToPostMeal:(UIStoryboardSegue *)segue
{
    HotelGetterViewController *hotel = segue.sourceViewController;
    self.annotation = hotel.anotationTemp;
    self.hotelNameTextView.text = self.annotation.title;
//    self.hotelAddressTextView.text = self.annotation.subtitle;
    
    NSString *provinceString = self.annotation.poi.province;
    NSString *districtString = self.annotation.poi.district;
    NSString *cityString = self.annotation.poi.city;
    
    NSString *fullAddress = [NSString stringWithFormat:@"%@%@%@%@",provinceString,cityString,districtString,self.annotation.subtitle];
    self.hotelAddressTextView.text = fullAddress;
}

-(IBAction)foodTypeBack:(UIStoryboardSegue *)segue
{
    FoodTypeGetterTVC *foodTypeTVC = segue.sourceViewController;
    self.foodTypeTextView.text = foodTypeTVC.foodType;
}

-(IBAction)dateBack:(UIStoryboardSegue *)segue
{
    TimeGetterVC *timeVC = segue.sourceViewController;
    self.mealTimeTextView.text = timeVC.dateString;
}

-(IBAction)descriptionBack:(UIStoryboardSegue *)segue
{
    DescriptionInputVC *descriptionInputVC = segue.sourceViewController;
    self.mealDescription.text = descriptionInputVC.descriptionInput;
}

-(IBAction)priceBack:(UIStoryboardSegue *)segue
{
    PriceInputVC *priceInputVC = segue.sourceViewController;
    self.uiniPriceTextView.text = priceInputVC.priceString;
}


#pragma mark - Image capture
- (IBAction)takePicture:(UIButton*)sender {
	UIActionSheet *sheet;
	sheet = [[UIActionSheet alloc] initWithTitle:nil
										delegate:self
							   cancelButtonTitle:@"取消"
						  destructiveButtonTitle:nil
							   otherButtonTitles:@"拍摄照片", @"选择照片", nil];
	
	[sheet showInView:self.navigationController.view];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addImage:(UITapGestureRecognizer *)sender
{
    UIActionSheet *sheet;
    sheet = [[UIActionSheet alloc] initWithTitle:nil
                                        delegate:self
                               cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"拍摄照片", @"选择照片", nil];
    
    [sheet showInView:self.navigationController.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
	UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.hotelImage.image = image;
    self.tapToAddImage.hidden = YES;

    
	[picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	switch (buttonIndex) {
		case 0: {
			if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
				imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
				[self presentViewController:imagePicker animated:YES completion:nil];
			}
		}
			break;
		case 1: {
			imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentViewController:imagePicker animated:YES completion:nil];
		}
			break;
		default:
			break;
	}
}

@end
