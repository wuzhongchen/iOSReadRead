//
//  BookStoreViewController.m
//  testtest
//
//  Created by hs on 2020/12/11.
//  Copyright © 2020 hs. All rights reserved.
//

#import "BookStoreViewController.h"
#import "MTitleButton.h"
#import "MaleChannelTableViewController.h"
#import "FemalChannelTableViewController.h"
#import "RankListTableViewController.h"
#import "CompletedTableViewController.h"
@interface BookStoreViewController () <UIScrollViewDelegate>
/** 标题栏view*/
@property (nonatomic, weak) UIView *titleView;
/** 选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
/** 下划线*/
@property (nonatomic, weak) UIView *underLine;
/** 装载所有子控制器view的scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation BookStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //为当前控制器添加子控制器
    [self configureChildrenViewControllers];
    
    //添加scrollView
    [self configureScrollView];
    
    //添加标题栏
    [self configureTitleView];
    
    //控制器view加载完毕时, 加载allViewController的view
    [self addChildViewIntoScrollView:0];
}

#pragma mark -----UIScrollViewDelegate-----

/**
 当停止减速, 即完全静止时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //通过偏移量拿到index, 可以通过该index获取到对应的按钮
    NSInteger index = scrollView.contentOffset.x / YYhScreenW;

    //方法一: 通过该index在titleView的数组中获取
    MTitleButton *button = self.titleView.subviews[index];

    //方法而: 通过该index, 调用viewWithTag:获取
    /*
     报错:-[UIView setSelected:]: unrecognized selector sent to instance 0x7fca6bc0b390.
     原因是向UIView发送了setSelected消息,但UIView中并没有该方法.
     
     分析报错原因:
     viewWithTag:该方法的实现是采用递归遍历, 先查询自己的tag, 再去查询自己子view的tag, 默认控件的tag为0, 而第一个按钮的tag值也为0,
     所有通过该方法传递出来的UIView并不是按钮, 而是titleView本身(UIView), 当该view作为参数传递给另一个需要接受按钮的方法中, 设置按钮
     相关方法时, 就会报找不到方法的错误.
     
     5   17_03_16_Budejie                    0x000000010491c0b6 -[YYHEssenceViewController titleButtonClick:] + 150
     6   17_03_16_Budejie                    0x000000010491ad2b -[YYHEssenceViewController scrollViewDidEndDecelerating:] + 331
     */

//    YYHTitleButton *button = [self.titleView viewWithTag:index];

    //调用点击按钮方法
    [self titleStatusChangeOnButton:button];

}
#pragma mark -----初始化子控件-----

/**
 为当前控制器添加所有子控制器
 */
- (void)configureChildrenViewControllers{
    [self addChildViewController:[[MaleChannelTableViewController alloc] init]];
    [self addChildViewController:[[FemalChannelTableViewController alloc] init]];
    [self addChildViewController:[[CompletedTableViewController alloc] init]];
    [self addChildViewController:[[RankListTableViewController alloc] init]];
}

/**
 设置ScrollView
 */
- (void)configureScrollView{
    
    //添加scrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.backgroundColor = [UIColor cyanColor];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4, self.view.bounds.size.height);




        //添加所有子控制器的view到scrollView
    //    [self configureChildrenViews];

    [self.view addSubview:self.scrollView];
}

/**
 设置标题栏view
 */
- (void)configureTitleView{
    //添加标题view
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    CGFloat titleViewW = self.view.readread_width;
    CGFloat titleViewH = 40;
    //设置titleView尺寸
    titleView.frame = CGRectMake(0, 64, titleViewW, titleViewH);
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];

    //为其添加子按钮
    [self addTitleButtons];

    [self.view addSubview:titleView];

    //添加下划线
    [self addUnderLine];
}

- (void)addUnderLine{
    //第一个按钮为选中状态
    MTitleButton *firstButton = self.titleView.subviews.firstObject;

    firstButton.selected = YES;
    self.selectedButton = firstButton;

    //创建下划线
    UIView *underLine = [[UIView alloc] init];
    //设置下划线位置
    underLine.readread_height = 2;
    underLine.readread_y = self.titleView.readread_height - underLine.readread_height;
    underLine.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    self.underLine = underLine;

    //通过按钮拿到label宽度
    [firstButton.titleLabel sizeToFit];
    underLine.readread_width = firstButton.titleLabel.readread_width;
    underLine.readread_centerX = firstButton.readread_centerX;


    [self.titleView addSubview:underLine];
}

- (void)addTitleButtons{
    NSArray *titleArray = @[@"男频", @"女频", @"完本", @"排行"];
    CGFloat buttonW = self.view.readread_width / 4;
    CGFloat buttonH = self.titleView.readread_height;

    for (int i = 0;  i < 4; i++) {
        MTitleButton *titleButton = [MTitleButton buttonWithType:UIButtonTypeCustom];

        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);

        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];

        //为按钮绑定tag
        titleButton.tag = i;

        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.titleView addSubview:titleButton];
    }
}


- (void)titleButtonClick: (MTitleButton *)titleButton{


    if (self.selectedButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HTitleButtonDidDoubleClickNotification" object:nil];
    }

    [self titleStatusChangeOnButton:titleButton];
}

/**
 添加第index处的按钮到scrollView
 */
- (void)addChildViewIntoScrollView: (NSInteger) index{
    UIView *childView = self.childViewControllers[index].view;

    if(childView.superview) return;

    childView.frame = CGRectMake(index * YYhScreenW, 0, YYhScreenW, YYHScreenH);
//    childView.frame = self.scrollView.bounds;

    [self.scrollView addSubview:childView];
}
#pragma mark -----点击标题按钮-----
- (void)titleStatusChangeOnButton:(MTitleButton *)titleButton{

    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;

    self.underLine.backgroundColor = [titleButton currentTitleColor];

    //点击标题后, 跳转到对应的控制器的view, 通过改变scrollView的的contentOffset
    NSUInteger index = titleButton.tag;

    //点击按钮时, 移动下划线的位置
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.readread_width = titleButton.titleLabel.readread_width;
        self.underLine.readread_centerX = titleButton.readread_centerX;


        self.scrollView.contentOffset = CGPointMake(index * YYhScreenW, self.scrollView.contentOffset.y);


    } completion:^(BOOL finished) {
        [self addChildViewIntoScrollView:index];
        // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
        for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
            UIViewController *childVc = self.childViewControllers[i];
            // 如果view还没有被创建，就不用去处理
            if (!childVc.isViewLoaded) continue;

            UIScrollView *scrollView = (UIScrollView *)childVc.view;
            if (![scrollView isKindOfClass:[UIScrollView class]]) continue;

            //        if (i == index) { // 是标题按钮对应的子控制器
            //            scrollView.scrollsToTop = YES;
            //        } else {
            //            scrollView.scrollsToTop = NO;
            //        }
            scrollView.scrollsToTop = (i == index);
        }
    }];
}
@end
