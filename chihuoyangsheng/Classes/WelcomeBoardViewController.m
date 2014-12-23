//
//  WelcomeBoardViewController.m
//  TherapeuticRegimen0.1
//
//  Created by Bob Zhang on 14-3-7.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

static NSString *kNameKey = @"nameKey";
static NSString *kImageKey = @"imageKey";

#import "WelcomeBoardViewController.h"
#import "BoardSlideViewController.h"

@interface WelcomeBoardViewController ()<UIScrollViewDelegate>

//图片滑动画布
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//页码进度指示器
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
//画布上所有图片的vcs
@property (nonatomic, strong) NSMutableArray *viewControllers;
//图片名称数组
@property (nonatomic,strong) NSArray *contentList;

@property (nonatomic) NSUInteger currentPageIndex;

@end

@implementation WelcomeBoardViewController

#pragma mark vc生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUInteger numberPages = self.contentList.count;
    //先初始化一个空的vc数组作位符,在需要的时候再替换掉
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    //每一页的宽度为scrollView的宽度
    //打开分页
    self.scrollView.pagingEnabled = YES;
    //修复3.5和4寸的屏幕适应
    self.scrollView.bounds = [UIScreen mainScreen ].bounds;
    //配置滑动区域
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * numberPages,//横向可滑动区域的的宽度
               CGRectGetHeight(self.scrollView.frame));//纵向可滑动的高度
    //关掉进度指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.pageControl.numberOfPages = numberPages;
    self.pageControl.currentPage = 0;
    
    //当初始化页码为0的时候将第一页和第二页加载
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

#pragma mark 根据页码加载视图
//加载vc的view到scrollView上
- (void)loadScrollViewWithPage:(NSUInteger)page
{
    self.currentPageIndex = page;
    //如果传入的页码大于总页数 返回
    if (page >= self.contentList.count)
        return;
    
    // 如果当前数组中的vc不为空的话就替换掉，避免重复更新
    BoardSlideViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainBranch"
                                                             bundle:nil];
        
        BoardSlideViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"BoardSlideVC"];
        myViewController.pageNumber = page;
        
        controller = myViewController;
        [self.viewControllers replaceObjectAtIndex:page
                                        withObject:controller];
    }
    
    // 将数组中的vc的view添加到scroll view中
    if (controller.view.superview == nil)//如果当前vc的父视图为空，则说明数组中的该vc没有添加到scroll view中
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;//根据页数来确定横向x的坐标的位置
        frame.origin.y = 0;
        controller.view.frame = frame;//改变vc的view的frame值
        
        //实现containerView的固定步骤
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:kImageKey]];
        controller.numberImage.bounds = self.scrollView.bounds;
        
    }
}

#pragma mark scrollView代理方法
//当上一页或下一页出现50%的时候同时加载左右两边的视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}

#pragma mark- lazy instantiation

//从plist文件中初始化图片名称数组
- (NSArray*)contentList
{
    if (!_contentList){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"slideImages" ofType:@"plist"];
        _contentList = [NSArray arrayWithContentsOfFile:path];
    }
    return _contentList;
}


- (IBAction)moveToLoginPage:(UITapGestureRecognizer *)sender
{
    if (self.currentPageIndex == self.contentList.count) {
        [self.delegate moveToLoginPage];
    }
}

@end

