//
//  TestCollectionViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-17.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "TestCollectionViewCell.h"
#import "TestView.h"
#import "GloblalSharedDataManager.h"
#import "AppDelegate.h"
#import "WhereAmI.h"
#import "Util.h"
#import "PhysiqueChooseViewController.h"
#import "UpdateInformation.h"

@interface TestCollectionViewController ()<UICollectionViewDataSource,QuestionViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate,updateResult>

@property (nonatomic,strong) NSMutableDictionary *questionDictionary;

@property (weak, nonatomic) IBOutlet UIView *questionContainerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property(nonatomic,strong) NSString *constitutionResult;

@end

@implementation TestCollectionViewController

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.questionDictionary.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSString *questionSectionKey = [self.questionDictionary.allKeys objectAtIndex:section];
    NSArray *questionArray = self.questionDictionary[questionSectionKey][@"questionsKey"];
    return questionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestCollectionViewCell *cell = [collectionView
                                dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell"
                                forIndexPath:indexPath];
    NSString *questionSectionKey = [self.questionDictionary.allKeys objectAtIndex:indexPath.section];
    NSArray *questionArray = self.questionDictionary[questionSectionKey][@"questionsKey"];
    
    cell.questionView.delegate = self;
    cell.questionView.questionLabel.text = questionArray[indexPath.row][@"question"];
    cell.questionView.questionIndex = indexPath.row;
    cell.questionView.physiqueTypeKey = questionSectionKey;
    cell.questionView.optionSegementCotrol.selectedSegmentIndex  = [self.questionDictionary[questionSectionKey]
                                        [@"questionsKey"][indexPath.row][@"score"] intValue] - 1;
    [cell.questionView.optionSegementCotrol setTitle:questionArray[indexPath.row][@"options"][0] forSegmentAtIndex:0];
    [cell.questionView.optionSegementCotrol setTitle:questionArray[indexPath.row][@"options"][1] forSegmentAtIndex:1];
    [cell.questionView.optionSegementCotrol setTitle:questionArray[indexPath.row][@"options"][2] forSegmentAtIndex:2];
    [cell.questionView.optionSegementCotrol setTitle:questionArray[indexPath.row][@"options"][3] forSegmentAtIndex:3];
    [cell.questionView.optionSegementCotrol setTitle:questionArray[indexPath.row][@"options"][4] forSegmentAtIndex:4];
    
    return cell;
   
}

- (void)didSelectedAnScore:(NSNumber *)number
         inPhysiqueTypeKey:(NSString *)sectionIndex
             questionIndex:(NSInteger)index
{
    self.questionDictionary[sectionIndex][@"questionsKey"][index][@"score"] = number;
    
    
}
- (IBAction)submitToCalculate:(id)sender
{
    for (id key in self.questionDictionary){
        NSArray *questionsArray = self.questionDictionary[key][@"questionsKey"];
        int sumScore = 0;
        for (NSDictionary *question in questionsArray){
           sumScore += [question[@"score"] intValue];
        }
        self.questionDictionary[key][@"finalScore"] = @(sumScore);
        self.questionDictionary[key][@"transformScore"] =@(((sumScore - questionsArray.count)/(questionsArray.count*4.0))*100.0);
    }
    
    if (!([self.questionDictionary[@"平和质"][@"transformScore"] intValue] < 60)) {
        BOOL isPinhezhi = YES;
        for (id key in self.questionDictionary){
            if (!([self.questionDictionary[key][@"transformScore"] intValue] < 40)) {
                isPinhezhi = NO;
            }
        }
        if (isPinhezhi) {
            self.constitutionResult = @"平和质";
            UIAlertView *result= [[UIAlertView alloc] initWithTitle:@"您的体质为："
                                                            message:self.constitutionResult
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [result show];

        }
        
    }else{
        int temp = 0;
        for (id key in self.questionDictionary){
            if ([self.questionDictionary[key][@"transformScore"] intValue] > temp) {
                temp = [self.questionDictionary[key][@"transformScore"] intValue];
                self.constitutionResult = key;
            }
        }
        UIAlertView *result= [[UIAlertView alloc] initWithTitle:@"您的体质为："
                                                        message:self.constitutionResult
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [result show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    GloblalSharedDataManager *dataManager = [GloblalSharedDataManager sharedDataManager];
    NSString *tmp = [[self.constitutionResult componentsSeparatedByString:@" "] firstObject];
    
    WhereAmI *location = [WhereAmI shareLoaction];
    
    NSString *currentLocatoin = location.currentLocation;
    if ([currentLocatoin isEqualToString:@"随便看看"]) {
        dataManager.constitutionName = tmp;
        dataManager.constitution = [dataManager id_keyForName:tmp];
    }else{
        dataManager.customer.constitutionName = tmp;
        dataManager.customer.constitution = [dataManager id_keyForName:tmp];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDataString = [dateFormatter stringFromDate:[NSDate date]];
        dataManager.customer.testDate = currentDataString;
    }
    
    
    ////////////////////////////////////
    if (location.isUpdating) {
        PhysiqueChooseViewController *chooseVC = self.navigationController.viewControllers[0];
        [chooseVC dismisAndReloadParent];
    }else{
        if ([location.currentLocation isEqualToString:@"注册页面"] || [location.currentLocation isEqualToString:@"随便看看"]) {
            [self performSegueWithIdentifier:@"test done to addressVC" sender:self];
        }
        if ([location.currentLocation isEqualToString:@"主页"]) {
            UpdateInformation *updater = [[UpdateInformation alloc] init];
            updater.updater = self;
            [updater update];
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appdelegate dismissLoginVC:nil];
        }

    }
}

- (void)updatedWithCallBack:(NSString *)zeroOrOne
{

}

- (NSMutableDictionary *)questionDictionary
{
    if (!_questionDictionary) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"PhysiqueTypeQuestionList" withExtension:@"plist"];
        _questionDictionary = [[NSMutableDictionary alloc ] initWithContentsOfURL:url];
    }
    return _questionDictionary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.questionContainerView.layer.cornerRadius = 10;
    self.questionContainerView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.questionContainerView.layer.borderWidth = 1.0f;
    
    [self performSelector:@selector(hideTopAndBottomBars)
               withObject:self afterDelay:1];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.exitButton.selected = self.navigationController.isNavigationBarHidden;
    [self performSelector:@selector(hideTopAndBottomBars) withObject:self afterDelay:1];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTopAndBottomBars];
    
}

- (void)hideTopAndBottomBars
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)showTopAndBottomBars
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (IBAction)toggleTopAndBottomBarState:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [self showTopAndBottomBars];
    }else{
        [self hideTopAndBottomBars];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    NSArray *visibleRows = [self.collectionView visibleCells];
    UICollectionViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [self.collectionView indexPathForCell:lastVisibleCell];
    if (path.section == 8) {
        self.finishButton.enabled = YES;
    }
   
}

@end
