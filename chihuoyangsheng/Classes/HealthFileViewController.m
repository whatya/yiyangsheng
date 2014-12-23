//
//  HealthFileViewController.m
//  YangSheng-ios-3.0
//
//  Created by caoguochi on 14-3-23.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "HealthFileViewController.h"
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

@interface HealthFileViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,UIAlertViewDelegate,DatePicked>

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

@end

@implementation HealthFileViewController

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainBranch" bundle:nil];
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

    
    
    return cell;
}


- (IBAction)doneEditting:(UIButton *)sender
{
    [self completeCustomerInformation];
    [self.pinner startAnimating];
    CustomerCustomerServiceImplServiceSoapBinding *customerService = [[CustomerCustomerServiceImplServiceSoapBinding alloc] init];
    GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];

  //  CustomerhealthRecord *health = manager.healthRecord;
    
    //health.customerId = nil;
//    health.diseaseTypeCode  = nil;
//    health.dpac = nil;
//    health.drinkingFr = nil;
//    health.drinkingType = nil;
//    health.drugAllergyFlag = nil;
//    health.drugAllergySource = nil;
//    health.drunkenness = nil;
//    health.familialDiseaseCode = nil;
//    health.geneticDiseases = nil;
    //health._id = nil;
    
//    health.quitSmokingAge = nil;
//    health.relationship = nil;
//    health.smoking = nil;
//    health.smokingAge = nil;
//    health.smokingStatus = nil;
//    health.startDrinkingAge = nil;
//    health.stopDrinkingAge = nil;
//    health.stopDrinkingFlag = nil;
//    health.surgery = nil;
//    health.surgeryFlag = nil;
//    health.surgeryTime = nil;
//    health.transfusionFalg = nil;
//    health.transfusionReason = nil;
//    health.transfusionTime = nil;
//    health.traumaName = nil;
//    health.traumaName = nil;
    
    
    [customerService saveCustomerAsync:manager.customer
                                  arg1:manager.healthRecord
                                  arg2:nil
                                  arg3:nil
                              __target:self
                             __handler:@selector(savedCustomer:)];
    
}

- (void)savedCustomer:(id)obj
{
    NSString *saveResult = obj;
    if ([saveResult isEqualToString:@"0|成功"]) {
        [[self giveMeCustomerService] getCustomerByLoginNameAsync:[self globalSharedDataManager].customer.loginName
                                                         __target:self
                                                        __handler:@selector(gotCustomer:)];
    }else{
        [self.pinner stopAnimating];
        UIAlertView *regitsAlertView = [[UIAlertView alloc] initWithTitle:@"注册失败！"
                                                                  message:@"请检查网络后重试！"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil, nil];
        [regitsAlertView show];
    }
}

- (void)gotCustomer:(id)obj
{
    [self.pinner stopAnimating];
    Customercustomer *registCustomer = obj;
    if (registCustomer.loginName) {
        
        
        GloblalSharedDataManager *manager  = [GloblalSharedDataManager sharedDataManager];
        manager.customer = nil;
        manager.healthRecord = nil;
        manager.customer = registCustomer;
        manager.customer.constitutionName = [manager name_ForKey:manager.customer.constitution];
        
        [MealService fetchDictionaryFromServerWithBaseUrl:@"getCustomerInfo.ws" queryString:[NSString stringWithFormat:@"loginName=%@",registCustomer.loginName] callBack:^(id dictionary) {
            if ([dictionary isKindOfClass:[NSDictionary class]]) {
                if ([dictionary[@"healthRecord"] isKindOfClass:[NSDictionary class]]) {
                    CustomerhealthRecord *healthRecord = [[CustomerhealthRecord alloc] init];
                    [healthRecord setValuesForKeysWithDictionary:dictionary[@"healthRecord"]];
                    manager.healthRecord = healthRecord;
                }
                
            }
            
            [manager synchronousToUserDefaults];
            
        }];

        
        
        WhereAmI *location = [WhereAmI shareLoaction];
        location.currentLocation = @"主页";
        [self globalSharedDataManager]._id = registCustomer._id;
        [[self globalSharedDataManager] synchronousToUserDefaults];
        //注册结果
        UIAlertView *regitsAlertView = [[UIAlertView alloc] initWithTitle:@"注册成功!"
                                                                  message:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil, nil];
        [regitsAlertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[self giveMeAppDelegate] dismissLoginVC:nil];

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
//    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:111.0/255.0
//                                                                                                       green:78/255.0
//                                                                                                        blue:33/255.0
//                                                                                                       alpha:1], nil]
//                                                     forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, nil]];
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:111.0/255.0
//                                                                        green:78/255.0
//                                                                         blue:33/255.0
//                                                                        alpha:1];

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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"healthFile" ofType:@"plist"];
        NSDictionary *questionDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *allQuestionsFromDictionary = questionDic[@"allQuestions"];
        _allQuestions = [NSMutableArray arrayWithCapacity:allQuestionsFromDictionary.count];
        for (NSDictionary *question in allQuestionsFromDictionary){
            RegistModel *registModel = [[RegistModel alloc] init];
            [registModel setValuesForKeysWithDictionary:question];
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
