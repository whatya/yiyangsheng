//
//  BaseFoodListByTypeViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "BaseFoodListByTypeViewController.h"
#import "BaseFoodbaseFood.h"
#import "BaseFoodCell.h"
#import "BaseFoodDetailViewController.h"
#import "MobileDB.h"

@interface BaseFoodListByTypeViewController ()

@property (nonatomic,strong) NSMutableArray *baseFoodList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation BaseFoodListByTypeViewController

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseFoodbaseFood *gotFoodItem = self.baseFoodList[indexPath.row];
    NSString *foodName = gotFoodItem.foodName;
    
    CGSize originalSize = [foodName sizeWithAttributes:nil];
    
    //CGSize newSize = CGSizeMake(originalSize.width+10, originalSize.height+10);
    
    CGSize newSize = CGSizeMake(60, originalSize.height+20);
    
    return newSize;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseFoodbaseFood *gotFoodItem = self.baseFoodList[indexPath.row];
    
    [gotFoodItem turnOnHighlight];
    
    BaseFoodCell *cell = (BaseFoodCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.foodTitleName setTextColor:[UIColor colorWithRed:111.0/255.0
                                                     green:78/255.0
                                                      blue:33/255.0
                                                     alpha:1]];
    
    [self performSegueWithIdentifier:@"showFromTypeList" sender:gotFoodItem];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BaseFoodDetailViewController *foodDetailVC = segue.destinationViewController;
    foodDetailVC.food = sender;
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.baseFoodList.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fuck" forIndexPath:indexPath];
    BaseFoodbaseFood *gotFoodItem = self.baseFoodList[indexPath.row];
    
    NSString *temp = gotFoodItem.foodName;
    if (temp.length > 4) {
        temp =  [temp substringToIndex:4];
    }
    
    if([temp rangeOfString:@"("].location != NSNotFound){
        temp = [temp substringToIndex:[temp rangeOfString:@"("].location];
    }
    
    if([temp rangeOfString:@"（"].location != NSNotFound){
        temp = [temp substringToIndex:[temp rangeOfString:@"（"].location];
    }
    if([temp rangeOfString:@"【"].location != NSNotFound){
        temp = [temp substringToIndex:[temp rangeOfString:@"【"].location];
    }

    
    cell.foodTitleName.text = temp;
    
    if (gotFoodItem.shouldIHighlight) {
        [cell.foodTitleName setTextColor:[UIColor colorWithRed:111.0/255.0
                                                         green:78/255.0
                                                          blue:33/255.0
                                                         alpha:1]];
        
    }else{
        [cell.foodTitleName setTextColor:[UIColor colorWithRed:47.0/255.0
                                                         green:125/255.0
                                                          blue:196/255.0
                                                         alpha:1]];
    }

    
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[MobileDB dbInstance] allBaseFood:^(NSMutableDictionary *dictionary) {
        _baseFoodList = dictionary[self.foodTypeName];
    }];
}

-(void)setFoodTypeName:(NSString *)foodTypeName
{
    _foodTypeName = foodTypeName;
    [[MobileDB dbInstance] allBaseFood:^(NSMutableDictionary *dictionary) {
        _baseFoodList = dictionary[self.foodTypeName];
    }];
}

@end
