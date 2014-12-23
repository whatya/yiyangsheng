//
//  FeedBackListViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-14.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "FeedBackListViewController.h"
#import "GuideSuggestionsServiceImplServiceSoapBinding.h"
#import "GLGSuggestionsServiceImplServiceSoapBinding.h"
#import "GloblalSharedDataManager.h"
#import "AppDelegate.h"
#import "KGFSuggestionsServiceImplServiceSoapBinding.h"

@interface FeedBackListViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *suggestionListWebView;
@property (strong,nonatomic) NSString* userID;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *writeButton;
@property (strong,nonatomic)KGFSuggestionsServiceImplServiceSoapBinding *suggestionManager;
@end

@implementation FeedBackListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.pinner startAnimating];
    GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];
    self.userID = manager.customer.get_id;
    
    WhereAmI *location = [WhereAmI shareLoaction];
    if ([location.currentLocation isEqualToString:@"随便看看"]) {
        self.writeButton.enabled = NO;
        [self.pinner stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆后可查看意见！" message:@"去登陆？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }else{
        self.writeButton.enabled = YES;
        [self fetchMySuggestions];
    }


}

- (void)fetchMySuggestions
{
    GLGSuggestionsServiceImplServiceSoapBinding *suggestionManager = [[GLGSuggestionsServiceImplServiceSoapBinding alloc] init];
    GLGsuggestions *params = [[GLGsuggestions alloc] init];
    params.customerId = self.userID;
    [suggestionManager findAsync:params __target:self __handler:@selector(gotSuggestionList:)];

}

- (void)gotSuggestionList:(id)obj
{
    GuidefindResponse *suggestionList = obj;
    
    NSArray *suggestonArray = [suggestionList.items sortedArrayUsingComparator:^NSComparisonResult(Guidesuggestions *obj1, Guidesuggestions *obj2) {
        NSInteger result = [obj1.getCreateTime compare:obj2.getCreateTime];
        switch (result) {
            case -1:
                return NSOrderedDescending;
                break;
            case 0:
                return NSOrderedSame;
                break;
            case 1:
                return NSOrderedAscending;
                break;
                
            default:
                return NSOrderedSame;
        }
        
    }];
    NSString *suggestionString = @"";
    for (Guidesuggestions *model in suggestonArray){
        NSString *content = @"";
        if ([model.getIsReply isEqualToString:@"1"]) {
            content = [NSString stringWithFormat:@"%@<div id=\"sugestionContent\"><p>%@</p></div> <div id=\"suggestionDate\"><p>%@</p><p>已回复</p></div><div id = \"line\"></div><div id=\"replyContent\">%@</div><div id = \"line\"></div><hr/>" ,suggestionString,model.getContent,model.getCreateTime,[self fetchReplyWithId:model.get_id]];

        }else{
            content = [NSString stringWithFormat:@"%@<div id=\"sugestionContent\"><p>%@</p></div> <div id=\"suggestionDate\"><p>%@</p><p>%@</p></div><div id = \"line\"></div><hr/>" ,suggestionString,model.getContent,model.getCreateTime,@""];
        }
        suggestionString = content;
    }
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"意见列表" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *newHtmlString = [htmlString stringByReplacingOccurrencesOfString:@"意见列表主体内容" withString:suggestionString];
    [self.suggestionListWebView loadHTMLString:newHtmlString baseURL:nil];
    [self.pinner stopAnimating];
}

- (NSString*)fetchReplyWithId:(NSString*)sugestionID
{
    NSError *error;
    KGFsuggestionsReply *reply = [self.suggestionManager getReplyBySuggestId:sugestionID __error:&error];
    if (error) {
        NSLog(@"获取回复出错：%@",error);
    }
    //NSLog(@"%@",reply.content);
    return  reply.content;
}

- (void)gotReplyString:(NSString*)replyString
{

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self exitHomePage];
    }
}

- (KGFSuggestionsServiceImplServiceSoapBinding*)suggestionManager
{
    if (!_suggestionManager) {
        _suggestionManager = [[KGFSuggestionsServiceImplServiceSoapBinding alloc] init];
    }
    return _suggestionManager;
}

- (void)exitHomePage
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate moveToLoginPage];
}

@end
