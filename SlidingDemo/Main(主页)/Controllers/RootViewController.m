//
//  ViewController.m
//  News
//
//  Created by hi on 15/10/15.
//  Copyright (c) 2015年 GML. All rights reserved.
//

#import "RootViewController.h"
#import "GMLLeftMenuView.h"
#import "BaseNavigationController.h"
//覆盖层按钮的tag
#define buttonTag 1200
@interface RootViewController ()<GMLLeftMenuViewDelegate>
{
    
}
//左边菜单栏
@property (nonatomic,weak)  GMLLeftMenuView *leftMenuView;
//当前显示的控制器
@property (nonatomic,strong) BaseNavigationController *showNavController;

@property (nonatomic,strong) UISwipeGestureRecognizer *leftSwipeGesture;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGesture];
    [self addBackgroundImage];
    [self setupLeftMenu];
    [self addChildControllers];
    
}

// 添加背景图片
- (void)addBackgroundImage
{
    UIImageView *backImag = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImag.image = [UIImage imageNamed:@"default_cover_gaussian"];
    [self.view addSubview:backImag];
}

// 添加左侧菜单栏
- (void)setupLeftMenu
{
    GMLLeftMenuView * leftMenuView = [[GMLLeftMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.65, self.view.height)];
    [self.view insertSubview:leftMenuView atIndex:1];
    self.leftMenuView = leftMenuView;
    self.leftMenuView.delegate = self;
    
}

// 添加自控制器
- (void)addChildControllers
{
    //2.添加订阅控制器
    UIViewController *news=[[UIViewController alloc]init];
    [self setupController:news title:@"新闻"];
    //2.添加订阅控制器
    UIViewController *read=[[UIViewController alloc]init];
    [self setupController:read title:@"订阅"];
    //3.图片
    UIViewController *imgVC=[[UIViewController alloc]init];
    [self setupController:imgVC title:@"图片"];
    //4.视频
    UIViewController *video=[[UIViewController alloc]init];
    [self setupController:video title:@"视频"];
    //5.跟帖
    UIViewController *reply=[[UIViewController alloc]init];
    [self setupController:reply title:@"跟帖"];
    //6.电台
    UIViewController *audio=[[UIViewController alloc]init];
    [self setupController:audio title:@"电台"];

}

- (void)setupController:(UIViewController *)subVC title:(NSString *)title
{
    if (self.childViewControllers.count >= 1) {
        subVC.view.backgroundColor = GMLRandomColor;
    }
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:subVC];
    subVC.title = title;
    subVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    subVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    [self addChildViewController:navi];
    //如果是首页 则添加首页view
    if(self.childViewControllers.count==1){
        self.showNavController=navi;
        [self.view addSubview:navi.view];
    }

}

- (void)leftClick:(id)sender
{
    self.leftMenuView.hidden = NO;
    [self.view bringSubviewToFront:self.leftMenuView];
    CGAffineTransform scaleform = CGAffineTransformMakeScale(0.9, 0.9);
    CGAffineTransform animation = CGAffineTransformTranslate(scaleform, -80, 0);
    self.leftMenuView.transform = animation;
    
    [UIView animateWithDuration:0.25 animations:^{
       
        self.leftMenuView.transform = CGAffineTransformIdentity;
        CGFloat naviH = ScreenHeight - 2 * LeftMenuButtonY;
        NSLog( @"naviH = %f",naviH);
        CGFloat scale = naviH/ScreenHeight; // 比例
        CGFloat leftMargin = ScreenWidth * (1 - scale) * 0.5;
        CGFloat translateX = (ScreenWidth * 0.65 -leftMargin) / scale;
        
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX, 0);
        self.showNavController.view.transform = translateForm;
      
        // 当
        if ([sender isKindOfClass:[UIButton class]]) {
            //4.创建一个按钮覆盖首页
            UIButton *cover=[[UIButton alloc]initWithFrame:self.showNavController.view.bounds];
            cover.tag=buttonTag; //设置按钮的tag
            [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.showNavController.view addSubview:cover];
        }
        
    }];
}

- (void)rightClick:(id)btn
{
    
}

- (void)coverClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.25 animations:^{
        //设置左边菜单的动画属性
        CGAffineTransform scaleform=CGAffineTransformMakeScale(0.9, 0.9);
        CGAffineTransform anim=CGAffineTransformTranslate(scaleform, -80, 0);
        self.leftMenuView.transform=anim;
        
        self.showNavController.view.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [btn removeFromSuperview]; //移除按钮
    }];
}

-(void)leftMenu:(GMLLeftMenuView *)leftMenu didSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    BaseNavigationController *lastNavi = self.childViewControllers[from];
    [lastNavi.view removeFromSuperview];
    
    BaseNavigationController *navi = self.childViewControllers[to];
    navi.view.transform = lastNavi.view.transform;
    [self.view addSubview:navi.view];
    self.showNavController = navi;
    [self coverClick:(UIButton *)[navi.view viewWithTag:buttonTag]];
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self leftClick:nil];
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        
    }
}

@end
