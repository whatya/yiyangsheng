//
//  PhysiqueChooseViewController.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-11.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "PhysiqueChooseViewController.h"

#import "APLSectionInfo.h"
#import "APLSectionHeaderView.h"

#import "CustomTableViewCell.h"
#import "AppDelegate.h"
#import "SectionHeaderModel.h"
#import "SubItemModel.h"
#import "GloblalSharedDataManager.h"
#import "WhereAmI.h"
#import "Util.h"

static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@interface PhysiqueChooseViewController ()<UITableViewDataSource,UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *sectionInfoArray;
@property (nonatomic) NSIndexPath *pinchedIndexPath;
@property (nonatomic) NSInteger openSectionIndex;
@property (nonatomic) CGFloat initialPinchHeight;

@property (nonatomic) IBOutlet APLSectionHeaderView *sectionHeaderView;

@property (nonatomic) NSInteger uniformRowHeight;

@end

@implementation PhysiqueChooseViewController
#pragma mark -

#define DEFAULT_ROW_HEIGHT 80
#define HEADER_HEIGHT 43

- (IBAction)dismissMe:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (BOOL)canBecomeFirstResponder {
    
    return YES;
}
- (IBAction)confirmChoose:(UIButton *)sender {

    
    if (self.openSectionIndex > self.sectionHeaders.count) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"请选择一种体质！"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [error show];
        return;
    }else{
        SectionHeaderModel *currentSectionHeader = self.sectionHeaders[self.openSectionIndex];
        
        GloblalSharedDataManager *dataManager = [GloblalSharedDataManager sharedDataManager];
        NSString *constitutionNameTemp = [[currentSectionHeader.name componentsSeparatedByString:@"-"] firstObject];
        
        WhereAmI *loction = [WhereAmI shareLoaction];
        
        NSString *currentLocatoin = loction.currentLocation;
        
        if ([currentLocatoin isEqualToString:@"随便看看"]) {
            dataManager.constitutionName = constitutionNameTemp;
            dataManager.constitution = [dataManager id_keyForName:constitutionNameTemp];
        }else{
            dataManager.customer.constitutionName = constitutionNameTemp;
            dataManager.customer.constitution = [dataManager id_keyForName:constitutionNameTemp];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDataString = [dateFormatter stringFromDate:[NSDate date]];
            dataManager.customer.testDate = currentDataString;
        }
        if (!loction.isUpdating) {
            [self performSegueWithIdentifier:@"push to addressVC" sender:self];
        }else{
            //返回信息修改页面
            [self dismisAndReloadParent];
        }
        

    }
    
}

- (void)dismisAndReloadParent
{
    [self.basicInformationViewer reloadTableViews];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    UIImage *navBarImage = [[UIImage imageNamed:@"head_constitution_choose.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 50, 50)];
    [self.navigationController.navigationBar setBackgroundImage:navBarImage
                                                 forBarPosition:UIBarPositionTop
                                                     barMetrics:UIBarMetricsDefault];
    
    
  NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:111.0/255.0
                                                                                                     green:78/255.0
                                                                                                      blue:33/255.0
                                                                                                     alpha:1], nil]
                                                   forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    
    self.tableView.layer.cornerRadius = 10;
    
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;
    
	UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(handlePinch:)];
	[self.tableView addGestureRecognizer:pinchRecognizer];
    
    self.tableView.sectionHeaderHeight = HEADER_HEIGHT;
    self.uniformRowHeight = DEFAULT_ROW_HEIGHT;
    self.openSectionIndex = NSNotFound;
    
    UINib *sectionHeaderNib = [UINib nibWithNibName:@"SectionHeaderView" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:SectionHeaderViewIdentifier];
}



- (void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
    
	if ((self.sectionInfoArray == nil) ||
        ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tableView])) {
        
		NSMutableArray *infoArray = [[NSMutableArray alloc] init];
        
		for (SectionHeaderModel *play in self.sectionHeaders) {
            
			APLSectionInfo *sectionInfo = [[APLSectionInfo alloc] init];
			sectionInfo.sectionHeaderModel = play;
			sectionInfo.open = NO;
            
            NSNumber *defaultRowHeight = @(DEFAULT_ROW_HEIGHT);
			NSInteger countOfQuotations = [[sectionInfo.sectionHeaderModel subItems] count];
			for (NSInteger i = 0; i < countOfQuotations; i++) {
				[sectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
			}
            
			[infoArray addObject:sectionInfo];
		}
        
		self.sectionInfoArray = infoArray;
	}
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sectionHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	APLSectionInfo *sectionInfo = (self.sectionInfoArray)[section];
	NSInteger numStoriesInSection = [[sectionInfo.sectionHeaderModel subItems] count];
    
    return sectionInfo.open ? numStoriesInSection : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *QuoteCellIdentifier = @"CustomCell";
    
    CustomTableViewCell *cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:QuoteCellIdentifier];
    
    SectionHeaderModel *play = (SectionHeaderModel *)[(self.sectionInfoArray)[indexPath.section] sectionHeaderModel];
    cell.item = (play.subItems)[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    APLSectionHeaderView *sectionHeaderView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    
    APLSectionInfo *sectionInfo = (self.sectionInfoArray)[section];
    sectionInfo.headerView = sectionHeaderView;
    
    sectionHeaderView.titleLabel.text = sectionInfo.sectionHeaderModel.name;
    sectionHeaderView.section = section;
    sectionHeaderView.delegate = self;
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	APLSectionInfo *sectionInfo = (self.sectionInfoArray)[indexPath.section];
    return [[sectionInfo objectInRowHeightsAtIndex:indexPath.row] floatValue];
}


#pragma mark - SectionHeaderViewDelegate

- (void)sectionHeaderView:(APLSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
    
    if (sectionOpened == self.sectionHeaders.count-1) {
        [self performSegueWithIdentifier:@"toTestFromChoose" sender:self];
    }else{
        APLSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionOpened];
        
        sectionInfo.open = YES;
        
        NSInteger countOfRowsToInsert = [sectionInfo.sectionHeaderModel.subItems count];
        NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
            [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
        }
        
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        
        NSInteger previousOpenSectionIndex = self.openSectionIndex;
        if (previousOpenSectionIndex != NSNotFound) {
            
            APLSectionInfo *previousOpenSection = (self.sectionInfoArray)[previousOpenSectionIndex];
            previousOpenSection.open = NO;
            [previousOpenSection.headerView toggleOpenWithUserAction:NO];
            NSInteger countOfRowsToDelete = [previousOpenSection.sectionHeaderModel.subItems count];
            for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
                [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
            }
        }
        
        UITableViewRowAnimation insertAnimation;
        UITableViewRowAnimation deleteAnimation;
        if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
            insertAnimation = UITableViewRowAnimationTop;
            deleteAnimation = UITableViewRowAnimationBottom;
        }
        else {
            insertAnimation = UITableViewRowAnimationBottom;
            deleteAnimation = UITableViewRowAnimationTop;
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
        
        [self.tableView endUpdates];
        self.openSectionIndex = sectionOpened;

        
    }
    
}

- (void)sectionHeaderView:(APLSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
	APLSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionClosed];
    
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}


#pragma mark - Handling pinches

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchRecognizer {
    
    if (pinchRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint pinchLocation = [pinchRecognizer locationInView:self.tableView];
        NSIndexPath *newPinchedIndexPath = [self.tableView indexPathForRowAtPoint:pinchLocation];
		self.pinchedIndexPath = newPinchedIndexPath;
        
		APLSectionInfo *sectionInfo = (self.sectionInfoArray)[newPinchedIndexPath.section];
        self.initialPinchHeight = [[sectionInfo objectInRowHeightsAtIndex:newPinchedIndexPath.row] floatValue];
        
        [self updateForPinchScale:pinchRecognizer.scale atIndexPath:newPinchedIndexPath];
    }
    else {
        if (pinchRecognizer.state == UIGestureRecognizerStateChanged) {
            [self updateForPinchScale:pinchRecognizer.scale atIndexPath:self.pinchedIndexPath];
        }
        else if ((pinchRecognizer.state == UIGestureRecognizerStateCancelled) || (pinchRecognizer.state == UIGestureRecognizerStateEnded)) {
            self.pinchedIndexPath = nil;
        }
    }
}

- (void)updateForPinchScale:(CGFloat)scale atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath && (indexPath.section != NSNotFound) && (indexPath.row != NSNotFound)) {
        
		CGFloat newHeight = round(MAX(self.initialPinchHeight * scale, DEFAULT_ROW_HEIGHT));
        
		APLSectionInfo *sectionInfo = (self.sectionInfoArray)[indexPath.section];
        [sectionInfo replaceObjectInRowHeightsAtIndex:indexPath.row withObject:@(newHeight)];
        
        BOOL animationsEnabled = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [UIView setAnimationsEnabled:animationsEnabled];
    }
}


- (NSArray*)sectionHeaders
{
    if (_sectionHeaders == nil) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"headerArrays" withExtension:@"plist"];
        
        
        NSArray *dctionariesArrayFromPlist = [[NSArray alloc ] initWithContentsOfURL:url];
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[dctionariesArrayFromPlist count]];
        
        for (NSDictionary *dictionaryFromPlist in dctionariesArrayFromPlist) {
            
            SectionHeaderModel *sectionHeaderModel = [[SectionHeaderModel alloc] init];
            sectionHeaderModel.name = dictionaryFromPlist[@"headerName"];
            
            NSArray *containedItemsArrayFromPlist = dictionaryFromPlist[@"containedItems"];
            NSMutableArray *items = [NSMutableArray arrayWithCapacity:[containedItemsArrayFromPlist count]];
            
            for (NSDictionary *itemDictionary in containedItemsArrayFromPlist) {
                
                SubItemModel *itemModel = [[SubItemModel alloc] init];
                [itemModel setValuesForKeysWithDictionary:itemDictionary];
                
                [items addObject:itemModel];
            }
            sectionHeaderModel.subItems = items;
            
            [temp addObject:sectionHeaderModel];
        }
        _sectionHeaders = temp;
    }
    
    return _sectionHeaders;
    
}


@end
