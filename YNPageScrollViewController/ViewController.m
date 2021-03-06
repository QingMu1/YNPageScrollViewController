//
//  ViewController.m
//  YNPageScrollViewController
//
//  Created by ZYN on 16/7/19.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "ViewController.h"
#import "YNBanTangDemoViewController.h"
#import "YNTestBaseViewController.h"
#import "YNTestOneViewController.h"
#import "YNTestFourViewController.h"
#import "YNTestTwoViewController.h"
#import "YNTestThreeViewController.h"
#import "SDCycleScrollView.h"
#import "YNJianShuDemoViewController.h"
#import "YNNavStyleViewDemoViewController.h"
#import "YNTopStyleViewController.h"
#import "MJRefresh.h"
#import "UIHomeViewControler.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate>

@property (nonatomic, strong) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@"YNBanTangDemoViewController",@"YNJianShuDemoViewController"
                   ,@"YNNavStyleViewDemo",@"YNTopStyleViewController",@"UIHomeViewControler"];
    
    self.title = @"Push控制器";
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = nil;
    if (indexPath.row == 0) {     //半塘Demo
        
        vc = [self getBanTangViewController];
        vc.hidesBottomBarWhenPushed = YES;
        
    }else if (indexPath.row == 1){//简书Demo
        
        vc = [self getJianShuDemoViewController];
        vc.hidesBottomBarWhenPushed = YES;
        
    }else if (indexPath.row == 2){//导航条样式Demo
        
        vc = [self getNavStyleViewDemoViewController];
        vc.hidesBottomBarWhenPushed = YES;
        
    }else if (indexPath.row == 3){//顶部样式Demo
        
        vc = [self YNTopStyleViewController];
        vc.hidesBottomBarWhenPushed = YES;
        
    }else{
        vc = [[UIHomeViewControler alloc]init];
        //        vc.hidesBottomBarWhenPushed = YES;
        
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//半塘Demo
- (UIViewController *)getBanTangViewController{
    
    YNTestOneViewController *one = [[YNTestOneViewController alloc]init];
    
    YNTestTwoViewController *two = [[YNTestTwoViewController alloc]init];
    
    YNTestThreeViewController *three = [[YNTestThreeViewController alloc]init];
    
    YNTestFourViewController *four = [[YNTestFourViewController alloc]init];
    
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.lineColor = [UIColor blackColor];
    configration.lineHeight = 4;
    configration.showConver = YES;
    configration.itemMaxScale = 1.2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.showNavigation = NO;//设置没有导航条
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    
    
    
    
    
    YNBanTangDemoViewController *vc = [YNBanTangDemoViewController pageScrollViewControllerWithControllers:@[one,two,three,four] titles:@[@"第一个界面",@"第二个界面",@"第三个界面",@"第四个界面"] Configration:configration];
    vc.dataSource = self;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.placeHoderView = footerView;
    
    
    //头部headerView
    UIView *headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 200)];
    //轮播器
    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 200) imageURLStringsGroup:imagesURLStrings];
    autoScrollView.delegate = self;
    
    [headerView2 addSubview:autoScrollView];
    vc.headerView = headerView2;
    
    
    return vc;
}



//简书Demo
- (UIViewController *)getJianShuDemoViewController{
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.lineLeftAndRightAddWidth = 10;//线条宽度增加
    configration.itemMaxScale = 1.2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor redColor];
    //设置平分不滚动   默认会居中
    configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
    
    configration.showGradientColor = NO;//取消渐变
    
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"最新收录",@"最新评论",@"热门",@"更多",@"第一个界面",@"第二个界面",@"第三个界面",@"第四个界面"] Configration:configration];
    // 头部是否能伸缩效果   要伸缩效果就不要有下拉刷新控件 默认NO*/
    vc.HeaderViewCouldScale = YES;
    
   
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    imageView.image = [UIImage imageNamed:@"mine_header_bg"];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap)]];
    
    
    //头像
    UIButton *icon = [[UIButton alloc]initWithFrame:CGRectMake(150, 30, 80, 80)];
    
    icon.tag = 100001;
    
    icon.backgroundColor = [UIColor redColor];
    
    icon.layer.cornerRadius = 40;
    
    [imageView addSubview:icon];
    
    
    //里面有默认高度 等ScrollView的高度 //里面设置了背景颜色与tableview相同
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    
    vc.pageIndex = 3;
    
    vc.placeHoderView = footerView;
    
    vc.headerView = imageView;
    
    vc.dataSource = self;
    
    
    //设置拉伸View
    UIImageView *imageViewScale = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    imageViewScale.image = [UIImage imageNamed:@"mine_header_bg"];
    
    vc.scaleBackgroundView = imageViewScale;
    
    //设置代理 监听伸缩
    vc.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        //        [vc reloadHeaderViewFrame];
    });
    
    
    return vc;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"轮播图 点击 Index : %zd",index);
}

- (void)imageViewTap{
    
    NSLog(@"----- imageViewTap -----");
    
}

//导航条样式Demo
- (UIViewController *)getNavStyleViewDemoViewController{
    
    
    //配置信息s
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleNavigation;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor redColor];
    configration.showConver = YES;
    
    YNNavStyleViewDemoViewController *vc = [YNNavStyleViewDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"最新收录",@"最新评论",@"热门",@"更多",@"新闻",@"搞笑视频",@"热门视频",@"有趣小事"] Configration:configration];
    
    vc.dataSource = self;
    return vc;
}

//顶部样式Demo
- (UIViewController *)YNTopStyleViewController{
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.itemLeftAndRightMargin = 30;
    configration.lineColor = [UIColor greenColor];
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleTop;//顶部
    configration.selectedItemColor = [UIColor blackColor];
    configration.showConver = YES;
    configration.showAddButton = YES;
    configration.converColor = [UIColor blueColor];
    
    YNTopStyleViewController *vc = [YNTopStyleViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"最新收录",@"最新评论",@"热门",@"更多",@"新闻",@"搞笑视频",@"热门视频",@"有趣小事"] Configration:configration];
    vc.dataSource = self;
    
    vc.addButtonAtion = ^(UIButton *btn, YNPageScrollViewController *vc) {
        NSLog(@"%@",btn);
        
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        [vc removePageScrollControllerWithIndex:vc.viewControllers.count - 1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [vc addPageScrollViewControllerWithTitle:@[@"测试"] viewController:@[[[YNTestOneViewController alloc] init]] inserIndex:vc.viewControllers.count - 1];
            [vc reloadYNPageScrollViewControllerLoadPage:nil];
        });
        
//        YNTestOneViewController *one = [[YNTestOneViewController alloc]init];
//        
//        YNTestTwoViewController *two = [[YNTestTwoViewController alloc]init];
//        
//        YNTestOneViewController *one1 = [[YNTestOneViewController alloc]init];
//        
//        YNTestTwoViewController *two1 = [[YNTestTwoViewController alloc]init];
//        
//        YNTestOneViewController *one2 = [[YNTestOneViewController alloc]init];
//        
//        YNTestTwoViewController *two2 = [[YNTestTwoViewController alloc]init];
//        [vc replaceTitleArray:@[@"测试",@"热门",@"最新收录",@"最新评论",@"更多",@"新闻",@"搞笑视频",@"热门视频",@"有趣小事"].mutableCopy];
//        [vc addPageScrollViewControllerWithTitle:@[@"我啊",@"测试咯阿萨德",@"我啊1",@"测试咯阿萨德1",@"我啊2",@"测试咯阿萨德2"] viewController:@[one,two,one1,two1,one2,two2] inserIndex:0];
        [vc reloadYNPageScrollViewControllerLoadPage:nil];
        
    });
    
    return vc;
    
}

#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}

- (NSArray *)getViewController{
    
    YNTestOneViewController *one = [[YNTestOneViewController alloc]init];
    
    YNTestTwoViewController *two = [[YNTestTwoViewController alloc]init];
    
    YNTestThreeViewController *three = [[YNTestThreeViewController alloc]init];
    
    YNTestFourViewController *four = [[YNTestFourViewController alloc]init];
    
    YNTestOneViewController *one1 = [[YNTestOneViewController alloc]init];
    
    YNTestTwoViewController *two1 = [[YNTestTwoViewController alloc]init];
    
    YNTestThreeViewController *three1 = [[YNTestThreeViewController alloc]init];
    
    YNTestFourViewController *four1 = [[YNTestFourViewController alloc]init];
    return @[one,two,three,four,one1,two1,three1,four1];
}

#pragma mark - YNPageScrollViewDelegate
/** 伸缩开始结束监听*/
- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController
      scrollViewHeaderScaleState:(BOOL)isStart {
    //这里处理方式不是特别好
    //1.在开始的时候需要手动隐藏背景图片,反之,相反.
    
    UIImageView *imageView =  (UIImageView *)pageScrollViewController.headerView;
    if (isStart) {
        imageView.image = nil;
    }else{
        imageView.image = [UIImage imageNamed:@"mine_header_bg"];
    }
    
    
}

/** 伸缩位置contentOffset*/
- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController
scrollViewHeaderScaleContentOffset:(CGFloat)contentOffset {
    NSLog(@"contentOffset : %f",contentOffset);
}



@end
