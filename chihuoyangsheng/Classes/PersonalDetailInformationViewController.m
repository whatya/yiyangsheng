//
//  PersonalDetailInformationViewController.m
//  YangSheng-ios-3.0
//
//  Created by caoguochi on 14-3-23.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "PersonalDetailInformationViewController.h"
#import "ItemsViewController.h"
#import "RegistModel.h"
#import "RegistCell.h"
#import "WhereAmI.h"

@interface PersonalDetailInformationViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>
{
    CGFloat offsetHeight;
    UITextField *currentTextField;
}

@property (strong, nonatomic) NSArray *answerArray;
@property (weak, nonatomic)   IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *allQuestions;
@property (assign, nonatomic) NSInteger index;
@end

@implementation PersonalDetailInformationViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allQuestions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.allQuestions) {
        cell.registModel = self.allQuestions[indexPath.row];
        cell.answerTextField.delegate = self;
        cell.answerTextField.text = ((RegistModel*)self.allQuestions[indexPath.row]).answerString;
        
        if ([cell.nameLabel.text isEqualToString:@"体重指数"]) {
            cell.answerTextField.enabled = NO;
        }else{
            cell.answerTextField.enabled = YES;
        }
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistModel *tempRegistModel = (RegistModel *)self.allQuestions[indexPath.row];
    self.answerArray = tempRegistModel.answerOptions;
    if (currentTextField) {
        [currentTextField resignFirstResponder];
    }
    if (tempRegistModel.answerType) {
        [self performSegueWithIdentifier:@"itemVC" sender:indexPath];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *cellIndexPath = sender;
    if ([segue.identifier isEqualToString:@"itemVC"]) {
        
        if ([segue.destinationViewController isKindOfClass:[ItemsViewController class]]) {
            
            ItemsViewController *itemsVC = segue.destinationViewController;
            itemsVC.itemsArray = self.answerArray;
            
            itemsVC.setAnswer = ^(NSString *answer){
                RegistModel *currentRegistModel =(RegistModel *) self.allQuestions[cellIndexPath.row];
                currentRegistModel.answerString = answer;
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:cellIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            };
            
        }
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
    
    if ([cell.nameLabel.text isEqualToString:@"身高(cm)"] || [cell.nameLabel.text isEqualToString:@"体重(kg)"]) {
        double height = [[self cellValueForCellNameString:@"身高(cm)"] doubleValue];
        double weight = [[self cellValueForCellNameString:@"体重(kg)"] doubleValue];
        double BMI = [self calculateBMIWiht:height andWeight:weight];
        [self changeCellValue:[NSString stringWithFormat:@"%.2f",BMI] inCellLabelString:@"体重指数"];
    }else{
        [self.tableView reloadData];
    }
    
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
    
    [WhereAmI shareLoaction].registLocation = @"基本信息";
    

    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;
}


- (NSArray *)allQuestions
{
    if (!_allQuestions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"personalDetail" ofType:@"plist"];
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


- (double)calculateBMIWiht:(double)height andWeight:(double)weight
{
    double BMI = 0.0;
    if (height>0&&weight>0) {
        BMI = weight/((height/100.0)*(height/100.0));
    }
    return BMI;
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [WhereAmI shareLoaction].registLocation = @"基本信息";
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
    return @[@"身份证号码",@"手机号码",@"身高(cm)",@"体重(kg)",@"血压"];
}

@end
