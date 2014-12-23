//
//  HealthRecordViewer.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "HealthRecordViewer.h"
#import "ItemsViewController.h"
#import "RegistModel.h"
#import "RegistCell.h"
#import "AppDelegate.h"
#import "CustomerCustomerServiceImplServiceSoapBinding.h"
#import "GloblalSharedDataManager.h"
#import "WhereAmI.h"
#import "FPPopoverController.h"
#import "DatePickerRegistiongViewController.h"
#import "MealService.h"
#import "UpdateInformation.h"

@interface HealthRecordViewer ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,UIAlertViewDelegate,DatePicked,updateResult>

{
    CGFloat offsetHeight;
    UITextField *currentTextField;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *allQuestions;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray *answerArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;

@property (strong,nonatomic) RegistCell *dateCell;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *upperRightButton;
@property (weak, nonatomic) IBOutlet UIButton *inforButton;

@property  (nonatomic) BOOL canEdit;
@end

@implementation HealthRecordViewer
- (IBAction)toogleEditable:(UIBarButtonItem*)sender
{
    self.canEdit = !self.canEdit;
    self.inforButton.hidden = !self.canEdit;
    sender.title = self
    .canEdit?@"取消编辑":@"编辑";
    self.inforButton.titleLabel.text = self.canEdit?@"确认修改":@"查看更多信息";
    [self.tableView reloadData];

}

#pragma mark- 获取健康档案
//- (void)fetchHealthRecord
//{
//    Customercustomer *user = [GloblalSharedDataManager sharedDataManager].customer;
//    CustomerhealthRecord *record = [GloblalSharedDataManager sharedDataManager].healthRecord;
//    if (record) {
//        [self fillQuestionsWithRecord:record];
//    }else{
//        [MealService fetchDictionaryFromServerWithBaseUrl:@"getCustomerInfo.ws"
//                                              queryString:[NSString stringWithFormat:@"loginName=%@",user.loginName] callBack:^(id dictionary) {
//                                                  [record setValuesForKeysWithDictionary:dictionary[@"healthRecord"]];
//                                                  [self fillQuestionsWithRecord:record];
//                                              }];
//
//    }
//    
//}
//
//- (void)fillQuestionsWithRecord:(CustomerhealthRecord*)record
//{
//    NSArray *answers = @[[self stringOrNil:record.smoking],
//                         [self stringOrNil:record.smokingStatus],
//                         [self stringOrNil:record.smokingAge],
//                         [self stringOrNil:record.quitSmokingAge],
//                         [self stringOrNil:record.drinkingFr],
//                         [self stringOrNil:record.dpac],
//                         [self stringOrNil:record.stopDrinkingFlag],
//                         [self stringOrNil:record.stopDrinkingAge],
//                         [self stringOrNil:record.startDrinkingAge],
//                         [self stringOrNil:record.drunkenness],
//                         [self stringOrNil:record.drinkingType],
//                         [self stringOrNil:record.drugAllergyFlag],
//                         [self stringOrNil:record.drugAllergySource],
//                         [self stringOrNil:record.diseaseTypeCode],
//                         [self stringOrNil:record.surgeryFlag],
//                         [self stringOrNil:record.surgery],
//                         [self stringOrNil:record.surgeryTime],
//                         [self stringOrNil:record.traumaName],
//                         [self stringOrNil:record.traumaTime],
//                         [self stringOrNil:record.transfusionFalg],
//                         [self stringOrNil:record.transfusionReason],
//                         [self stringOrNil:record.transfusionTime],
//                         [self stringOrNil:record.familialDiseaseCode],
//                         [self stringOrNil:record.relationship],
//                         [self stringOrNil:record.geneticDiseases]];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"healthFile" ofType:@"plist"];
//    NSDictionary *questionDic = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSArray *allQuestionsFromDictionary = questionDic[@"allQuestions"];
//    _allQuestions = [NSMutableArray arrayWithCapacity:allQuestionsFromDictionary.count];
//    for (int i = 0; i < allQuestionsFromDictionary.count; i++) {
//        NSDictionary *question = allQuestionsFromDictionary[i];
//        RegistModel *registModel = [[RegistModel alloc] init];
//        [registModel setValuesForKeysWithDictionary:question];
//        registModel.answerString = answers[i];
//        [_allQuestions addObject:registModel];
//    }
//    
//    [self.tableView reloadData];
//    
//}

- (NSString*)stringOrNil:(NSString*)incomingString
{
    return incomingString?incomingString:@"";
}

- (void)didPickedADateString:(NSString *)dateString
{
    self.dateCell.registModel.answerString = dateString;
    self.dateCell.answerTextField.text = dateString;
}

-(void)popover:(id)sender
{
    UIButton *button = sender;
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    
    id registCell = button.superview.superview;
    if (version >= 8.0) {
        registCell = button.superview;
    }
    self.dateCell = registCell;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PersionalInfoManager" bundle:nil];
    DatePickerRegistiongViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"datePickerForRegistionVC"];
    controller.delegate = self;
    
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
    popover.delegate = controller;
    
    popover.border = NO;
    popover.tint = FPPopoverWhiteTint;
    popover.contentSize = CGSizeMake(260,210);
    popover.arrowDirection = FPPopoverArrowDirectionRight;
    [popover presentPopoverFromView:sender];
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.allQuestions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.allQuestions) {
        cell.registModel = self.allQuestions[indexPath.row];
        cell.answerTextField.delegate = self;
        cell.answerTextField.text = ((RegistModel*)self.allQuestions[indexPath.row]).answerString;
        cell.nameLabel.text = ((RegistModel*)self.allQuestions[indexPath.row]).nameString;
        NSString *cellValue = [self cellValueForCellNameString:@"是否吸烟"];
        if ([cellValue isEqualToString:@"否"]) {
            
            if ([cell.nameLabel.text isEqualToString:@"日吸烟量(支)"]||
                [cell.nameLabel.text isEqualToString:@"开始吸烟年龄(岁)"]||
                [cell.nameLabel.text isEqualToString:@"戒烟年龄(岁)"]) {
                cell.userInteractionEnabled = NO;
            }else{
                cell.userInteractionEnabled = YES;
            }
        }
        
        
        if ([cellValue isEqualToString:@"是"]) {
            
            if ([cell.nameLabel.text isEqualToString:@"日吸烟量(支)"]||
                [cell.nameLabel.text isEqualToString:@"开始吸烟年龄(岁)"]||
                [cell.nameLabel.text isEqualToString:@"戒烟年龄(岁)"]) {
                cell.userInteractionEnabled = YES;
            }        }
        
        if ([cell.nameLabel.text rangeOfString:@"日期"].location != NSNotFound) {
            cell.answerTextField.enabled = NO;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
            button.tintColor = [UIColor orangeColor];
            [button addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = button;
        }else{
            cell.accessoryView = nil;
            cell.answerTextField.enabled = YES;
        }
    }
    
    
    cell.userInteractionEnabled = self.canEdit;
    return cell;
}


- (IBAction)doneEditting:(UIButton *)sender
{
    [self completeCustomerInformation];
    [self.pinner startAnimating];
    UpdateInformation *updater = [[UpdateInformation alloc] init];
    updater.updater = self;
    [updater update];
    
}

- (void)updatedWithCallBack:(NSString *)zeroOrOne
{
    if ([zeroOrOne isEqualToString:@"0"]) {
        [WhereAmI shareLoaction].isUpdating = NO;
        self.inforButton.hidden = YES;
        self.upperRightButton.title = @"编辑";
        self.canEdit = !self.canEdit;
    }
    [self.pinner stopAnimating];
}



- (AppDelegate*)giveMeAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;;
}

- (CustomerCustomerServiceImplServiceSoapBinding*)giveMeCustomerService
{
    return [[CustomerCustomerServiceImplServiceSoapBinding alloc] init];
}

- (GloblalSharedDataManager*)globalSharedDataManager
{
    return [GloblalSharedDataManager sharedDataManager];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!self.canEdit) {
        return;
    }
    RegistModel *tempRegistModel = (RegistModel *)_allQuestions[indexPath.row];
    self.answerArray = tempRegistModel.answerOptions;
    self.index = indexPath.row;
    
    if (tempRegistModel.answerType) {
        [self performSegueWithIdentifier:@"itemVC" sender:indexPath];
    }
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"itemVC"]) {
        
        if ([segue.destinationViewController isKindOfClass:[ItemsViewController class]]) {
            
            ItemsViewController *itemsVC = segue.destinationViewController;
            itemsVC.itemsArray = self.answerArray;
            
            itemsVC.setAnswer = ^(NSString *answer){
                
                RegistModel *currentRegistModel =(RegistModel *) self.allQuestions[self.index];
                currentRegistModel.answerString = answer;
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:sender atScrollPosition:UITableViewScrollPositionTop animated:YES];
                
                
            };
        }
    }else if ([segue.identifier isEqualToString:@"nextVC"]) {
    }
    
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGPoint pointToWindow = [textField convertPoint:textField.frame.origin toView:nil];
    CGFloat keyboard_y = self.view.frame.size.height - 290;
    offsetHeight = pointToWindow.y > keyboard_y ? pointToWindow.y - keyboard_y : 0;
    if (offsetHeight != 0) {
        [UIView animateKeyframesWithDuration:0.3
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionLayoutSubviews
                                  animations:^{
                                      self.tableView.center = CGPointMake(self.tableView.center.x,
                                                                          self.tableView.center.y - offsetHeight );
                                  } completion:nil];
    }
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    id temp = textField.superview.superview.superview;
    if (version >= 8.0) {
        temp = textField.superview.superview;
    }
    RegistCell *inputCell = temp;
    if ([[self numberNames] containsObject:inputCell.nameLabel.text] && ![self isAllNumbers:textField.text]) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示！"
                                                             message:@"请输入数字!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"重新输入"
                                                   otherButtonTitles:nil, nil];
        inputCell.answerTextField.text = @"";
        [errorAlert show];
        return;
    }
    
    RegistCell *cell = (RegistCell*)textField.superview.superview.superview;
    if (version >= 8.0) {
        cell = (RegistCell*)textField.superview.superview;
    }

    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    RegistModel *currentRegistModel =(RegistModel *) self.allQuestions[cellIndexPath.row];
    currentRegistModel.answerString = textField.text;
    cell.answerTextField.text = textField.text;
    
    
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:cellIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (offsetHeight != 0) {
        [UIView animateKeyframesWithDuration:0.3
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionLayoutSubviews
                                  animations:^{
                                      self.tableView.center = CGPointMake(self.tableView.center.x,
                                                                          self.tableView.center.y + offsetHeight);
                                  } completion:nil];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WhereAmI shareLoaction].registLocation = @"健康档案";
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
    [WhereAmI shareLoaction].registLocation = @"健康档案";
}

- (NSArray *)allQuestions
{
    if (!_allQuestions) {
        CustomerhealthRecord *record = [GloblalSharedDataManager sharedDataManager].healthRecord;
        NSArray *answers = @[[self stringOrNil:record.smoking],
                             [self stringOrNil:record.smokingStatus],
                             [self stringOrNil:record.smokingAge],
                             [self stringOrNil:record.quitSmokingAge],
                             [self stringOrNil:record.drinkingFr],
                             [self stringOrNil:record.dpac],
                             [self stringOrNil:record.stopDrinkingFlag],
                             [self stringOrNil:record.stopDrinkingAge],
                             [self stringOrNil:record.startDrinkingAge],
                             [self stringOrNil:record.drunkenness],
                             [self stringOrNil:record.drinkingType],
                             [self stringOrNil:record.drugAllergyFlag],
                             [self stringOrNil:record.drugAllergySource],
                             [self stringOrNil:record.diseaseTypeCode],
                             [self stringOrNil:record.surgeryFlag],
                             [self stringOrNil:record.surgery],
                             [self stringOrNil:record.surgeryTime],
                             [self stringOrNil:record.traumaName],
                             [self stringOrNil:record.traumaTime],
                             [self stringOrNil:record.transfusionFalg],
                             [self stringOrNil:record.transfusionReason],
                             [self stringOrNil:record.transfusionTime],
                             [self stringOrNil:record.familialDiseaseCode],
                             [self stringOrNil:record.relationship],
                             [self stringOrNil:record.geneticDiseases]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"healthFile" ofType:@"plist"];
        NSDictionary *questionDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *allQuestionsFromDictionary = questionDic[@"allQuestions"];
        _allQuestions = [NSMutableArray arrayWithCapacity:allQuestionsFromDictionary.count];
        for (int i = 0; i < allQuestionsFromDictionary.count; i++) {
            NSDictionary *question = allQuestionsFromDictionary[i];
            RegistModel *registModel = [[RegistModel alloc] init];
            [registModel setValuesForKeysWithDictionary:question];
            registModel.answerString = answers[i];
            [_allQuestions addObject:registModel];
        }

        
    }
    return _allQuestions;
}

- (void)completeCustomerInformation
{
    NSString *ageGroup = [self globalSharedDataManager].ageGroup;
    NSString *ageGroupName = @"青年";
    if ([ageGroup isEqualToString:@"20以下"] ) {
        ageGroupName = @"少年";
    }else if ([ageGroup isEqualToString:@"20~30"] ){
        ageGroupName = @"青春期";
    }else if ([ageGroup isEqualToString:@"30~40"] ){
        ageGroupName = @"成熟期";
    }else if ([ageGroup isEqualToString:@"40~50"] ){
        ageGroupName = @"壮实期";
    }else if ([ageGroup isEqualToString:@"50~60"] ){
        ageGroupName = @"稳健期";
    }else if ([ageGroup isEqualToString:@"60以上"] ){
        ageGroupName = @"老年期";
    }
    [self globalSharedDataManager].customer.ageGroupName = ageGroupName;
    [self globalSharedDataManager].customer.ethnic = [[self globalSharedDataManager] id_keyForName:[self globalSharedDataManager].customer.ethnicName];
    [self globalSharedDataManager].customer.areaName = [self globalSharedDataManager].cityName;
    
    
}


- (void)changeCellValue:(NSString*)stringValue inCellLabelString:(NSString*)lableString
{
    for(RegistModel *model in self.allQuestions){
        if ([model.nameString isEqualToString:lableString]) {
            model.answerString = stringValue;
            [self.tableView reloadData];
            break;
        }
    }
}

#pragma mark-根据名词获取cell的值
- (NSString*)cellValueForCellNameString:(NSString*)nameString
{
    for(RegistModel *model in self.allQuestions){
        if ([model.nameString isEqualToString:nameString]) {
            return model.answerString;
        }
    }
    return @"";
}



- (BOOL)isAllNumbers:(NSString*)inputString
{
    int counOfPoint = 0;
    for (int i = 0; i < inputString.length; i++) {
        char c = [inputString characterAtIndex:i];
        if (c == '.') {
            counOfPoint ++;
        }
    }
    if (counOfPoint > 1) {
        return NO;
    }
    
    inputString = [[inputString stringByReplacingOccurrencesOfString:@"." withString:@""] stringByTrimmingCharactersInSet:
                   [NSCharacterSet decimalDigitCharacterSet]];
    if(inputString.length > 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (NSArray*)numberNames
{
    return @[@"日吸烟量(支)",@"开始吸烟年龄(岁)",@"戒烟年龄(岁)",@"日饮酒量(两)",@"戒酒年龄（岁）",@"开始饮酒年龄",@"醉酒次数",@"",@"",@"",@"",@""];
}
@end
