//
//  PersonalInfomationViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-16.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "BasicInformationViewer.h"
#import "ItemsViewController.h"
#import "RegistModel.h"
#import "RegistCell.h"
#import "WhereAmI.h"
#import "GloblalSharedDataManager.h"
#import "DropDownListView.h"
#import "WhereAmI.h"
#import "PhysiqueChooseViewController.h"
#import "PrintObject.h"
#import "UpdateInformation.h"


@interface BasicInformationViewer ()<kDropDownListViewDelegate,updateResult>{
    CGFloat offsetHeight;
    UITextField *currentTextField;
    NSArray *arryList;
    DropDownListView * Dropobj;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *upperRightButton;

@property (nonatomic) BOOL canEdit;

@property (strong, nonatomic) NSArray *answerArray;

@property (weak, nonatomic)   IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *allQuestions;

@property (assign, nonatomic) NSInteger index;

@property (assign,nonatomic) NSInteger mutipleSelectionIndex;
@property (weak, nonatomic) IBOutlet UIButton *inforButton;

@end

@implementation BasicInformationViewer

#pragma mark-更改按钮编辑状态
- (IBAction)toogleEditable:(UIBarButtonItem*)sender {
    self.canEdit = !self.canEdit;
    sender.title = self
    .canEdit?@"取消编辑":@"编辑";
    self.inforButton.titleLabel.text = self.canEdit?@"确认修改":@"查看更多信息";
    [self.tableView reloadData];
}

#pragma mark-tableview datasource
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
        cell.answerTextField.enabled = self.canEdit;
    }
    return cell;
}

#pragma mark - 点击行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     WhereAmI *whereAmI = [WhereAmI shareLoaction];
    if (!self.canEdit) {
        return;
    }
    
    RegistModel *tempRegistModel = (RegistModel *)self.allQuestions[indexPath.row];
    if (indexPath.row == 7) {
        whereAmI.isUpdating = YES;
        [self showBodyTest];
    }else if (indexPath.row == 8){
        return;
    }else if (indexPath.row == 9 || indexPath.row == 10){
        [self showAddressChoose];
    }else if (indexPath.row == 5) {
        self.mutipleSelectionIndex = 5;
        [self showPopUpWithTitle:@"饮食爱好" withOption:tempRegistModel.answerOptions xy:CGPointMake(16, 100) size:CGSizeMake(287, 330) isMultiple:YES];
    }else if (indexPath.row == 6) {
        self.mutipleSelectionIndex = 6;
        [self showPopUpWithTitle:@"食物过敏原" withOption:tempRegistModel.answerOptions xy:CGPointMake(16, 100) size:CGSizeMake(287, 330) isMultiple:YES];
    }else{
        self.answerArray = tempRegistModel.answerOptions;
        
        
        if (currentTextField) {
            [currentTextField resignFirstResponder];
        }
        
        if (tempRegistModel.answerType) {
            [self performSegueWithIdentifier:@"itemVC" sender:indexPath];
        }
        
    }
    
}

- (void)updatedWithCallBack:(NSString *)zeroOrOne
{
    if ([zeroOrOne isEqualToString:@"0"]) {
        [WhereAmI shareLoaction].isUpdating = NO;
        self.canEdit = NO;
        self.upperRightButton.title = @"编辑";
    }else{
        self.canEdit = YES;
        self.upperRightButton.title = @"取消编辑";
        self.inforButton.titleLabel.text = @"确认提交";
    }
    
}

#pragma mark- 导航到下一级
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *cellIndexPath = sender;
    if ([segue.identifier isEqualToString:@"itemVC"]) {
        
        if ([segue.destinationViewController isKindOfClass:[ItemsViewController class]]) {
            
            ItemsViewController *itemsVC = segue.destinationViewController;
            itemsVC.itemsArray = self.answerArray;
            
            itemsVC.setAnswer = ^(NSString *answer){
                RegistModel *currentRegistModel =(RegistModel *) self.allQuestions[cellIndexPath.row];
                if (cellIndexPath.row == 3) {
                    Customercustomer *user = [GloblalSharedDataManager sharedDataManager].customer;
                    //民族名称
                    NSString *ethnic = [[GloblalSharedDataManager sharedDataManager] id_keyForName:answer];
                    user.ethnic = ethnic;
                }
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
    RegistCell *selectedCell = temp;
    if (![self isAemail:textField.text] && [selectedCell.nameLabel.text isEqualToString:@"邮箱"]) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"提示！"
                                                        message:@"请输入正确的邮箱！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [error show];
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



#pragma mark- 下一步
- (IBAction)nextStep:(UIButton *)sender
{
    if (self.canEdit) {
        //
        UpdateInformation *updater = [[UpdateInformation alloc] init];
        updater.updater = self;
        [updater update];
    }else{
        //if ([self isValidForm]) {
            [self performSegueWithIdentifier:@"detailVC" sender:nil];
//        }else{
//            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示！"
//                                                                 message:@"请输入完整的注册信息！"
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"确定"
//                                                       otherButtonTitles:nil, nil];
//            [errorAlert show];
//        }

    }
}

#pragma mark 将对象转为字符串
- (NSString*)stringFromObj:(id)obj
{
    if ([NSJSONSerialization isValidJSONObject:obj])
        
    {
        
        NSError *error;
        
        //创超一个json从Data,NSJSONWritingPrettyPrinted指定的JSON数据产的空白，使输出更具可读性
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                            
                                                        options:NSJSONWritingPrettyPrinted
                            
                                                          error:&error];
        
        NSString *jsonString = [[NSString alloc]initWithData:jsonData
                                
                                                    encoding:NSUTF8StringEncoding];
        
        return jsonString;
    }
    return nil;
}

#pragma mark- viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WhereAmI shareLoaction].registLocation = @"基本信息";
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
    [WhereAmI shareLoaction].registLocation = @"基本信息";
}

#pragma mark- 从plist里面初始化数据
- (NSArray *)allQuestions
{
    Customercustomer *user = [GloblalSharedDataManager sharedDataManager].customer;
    //民族名称
    NSString *ethnicName = [[GloblalSharedDataManager sharedDataManager] name_ForKey:user.ethnic];
    
    //城市名称
    NSString *cityName = [[GloblalSharedDataManager sharedDataManager] cityNameForKey:user.cityId];
    
    NSArray *answers = @[[self stringOrNil: user.nickname],
                         [self stringOrNil:user.sex],
                         [self stringOrNil:user.ageGroup],
                         [self stringOrNil:ethnicName],
                         [self stringOrNil:user.email],
                         [self stringOrNil:user.dietHabit],
                         [self stringOrNil:user.allergen],
                         [self stringOrNil:user.constitutionName],
                         [self stringOrNil:user.testDate],
                         [self stringOrNil:user.province],
                         [self stringOrNil:cityName]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"personalInforForUpdating" ofType:@"plist"];
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
    return _allQuestions;
}

- (NSString*)stringOrNil:(NSString*)incomingStr{
    return incomingStr?incomingStr:@"";
}

#pragma mark- 邮箱验证
- (BOOL)isAemail:(NSString*)emailString
{
    if ([emailString rangeOfString:@"@"].location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark- 表单完整验证
- (BOOL)isValidForm
{
    BOOL validFlag = YES;
    for (RegistModel *model in self.allQuestions){
        if (model.answerString.length == 0 || model.answerString == nil) {
            validFlag = NO;
            break;
        }
    }
    return validFlag;
}




#pragma -mark 多选弹出框

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:111.0 G:78.0 B:33.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    
    NSString *connectedAnswerString = [ArryData componentsJoinedByString:@","];

    
    RegistModel *temp = self.allQuestions[self.mutipleSelectionIndex];
    temp.answerString = connectedAnswerString;
    [self.tableView reloadData];
    
    
}
- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }
}


- (void)DropDownPressed{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Country" withOption:arryList xy:CGPointMake(16, 58) size:CGSizeMake(287, 300) isMultiple:YES];
}

#pragma  -mark 刷新页面
- (void)reloadTableViews
{
    [self.tableView reloadData];
}

#pragma mark- 体质测试界面
- (void)showBodyTest
{
    UIStoryboard *loginBoard = [UIStoryboard storyboardWithName:@"MainBranch" bundle:nil];
    UINavigationController *test = [loginBoard instantiateViewControllerWithIdentifier:@"bodyTypeChoose"];
    PhysiqueChooseViewController *chooseVC = test.viewControllers[0];
    chooseVC.basicInformationViewer = self;
    [self presentViewController:test animated:YES completion:NULL];
    //[self.navigationController pushViewController:test animated:YES];
}

#pragma mark- 地址选择
- (void)showAddressChoose
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PersionalInfoManager" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProvinceChooseTVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
