//
//  BaseFoodListViewController.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-27.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "BaseFoodListViewController.h"
#import "BaseFoodbaseFood.h"
#import "BaseFoodCell.h"
#import "BaseFoodDetailViewController.h"
#import "BaseFoodHeader.h"
#import "BaseFoodFooter.h"
#import "BaseFoodListByTypeViewController.h"
#import "MoreButton.h"
#import "MobileDB.h"

@interface BaseFoodListViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableDictionary *baseFoodList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BaseFoodListViewController

-(void)awakeFromNib
{
    [self getAllBaseFood];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allFoodKeys = self.baseFoodList.allKeys;
    NSArray *foods = self.baseFoodList[allFoodKeys[indexPath.section]];
    BaseFoodbaseFood *gotFoodItem = foods[indexPath.row];
    NSString *foodName = gotFoodItem.foodName;
    
    CGSize originalSize = [foodName sizeWithAttributes:nil];
    
    //CGSize newSize = CGSizeMake(originalSize.width+10, originalSize.height+10);
    
    CGSize newSize = CGSizeMake(60, originalSize.height+10);
    
    return newSize;
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *allFoodTypeKeys = self.baseFoodList.allKeys;
    NSString *foodType = allFoodTypeKeys[indexPath.section];
    NSArray *allFoodsFromFoodType = self.baseFoodList[foodType];
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        BaseFoodHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"baseFoodHeader" forIndexPath:indexPath];
        headerView.foodTypeLabel.text = foodType;
        headerView.totalSubCounts = allFoodsFromFoodType.count;
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        BaseFoodFooter *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BaseFoodFooter" forIndexPath:indexPath];
        footerview.showMoreButton.foodType = foodType;
        footerview.showMoreButton.hidden = allFoodsFromFoodType.count > 20 ? NO : YES;
        reusableview = footerview;
    }
    
    return reusableview;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allFoodKeys = self.baseFoodList.allKeys;
    NSArray *foods = self.baseFoodList[allFoodKeys[indexPath.section]];
    BaseFoodbaseFood *gotFoodItem = foods[indexPath.row];
    [gotFoodItem turnOnHighlight];
    
    BaseFoodCell *cell = (BaseFoodCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.foodTitleName setTextColor:[UIColor colorWithRed:111.0/255.0
                                                     green:78/255.0
                                                      blue:33/255.0
                                                     alpha:1]];
    
    [self performSegueWithIdentifier:@"BaseFoodDetailVC" sender:gotFoodItem];
}



#pragma mark - UICollectionView Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.baseFoodList.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSArray *allFoodKeys = self.baseFoodList.allKeys;
    NSArray *foods = self.baseFoodList[allFoodKeys[section]];
    
    NSInteger rowsCount = foods.count > 20 ? 20 : foods.count;
    
    return rowsCount;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fuck" forIndexPath:indexPath];
    NSArray *allFoodKeys = self.baseFoodList.allKeys;
    
    NSArray *foods = self.baseFoodList[allFoodKeys[indexPath.section]];
    BaseFoodbaseFood *gotFoodItem = foods[indexPath.row];
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"BaseFoodDetailVC"]) {
        BaseFoodDetailViewController *foodDetailVC = segue.destinationViewController;
        foodDetailVC.food = sender;
    }
    
    if ([segue.identifier isEqual:@"showByType"]) {
        MoreButton *button = sender;
        BaseFoodListByTypeViewController *listByType = segue.destinationViewController;
        listByType.foodTypeName = button.foodType;
    }
    
}


- (IBAction)showFoodDetail:(MoreButton *)sender
{
    [self performSegueWithIdentifier:@"showByType" sender:sender];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllBaseFood];
}

- (void)getAllBaseFood
{
    if (!_baseFoodList) {
        [[MobileDB dbInstance] allBaseFood:^(NSMutableDictionary *dictionary) {
            _baseFoodList = dictionary;
            [self.collectionView reloadData];
        }];
    }

}

@end
