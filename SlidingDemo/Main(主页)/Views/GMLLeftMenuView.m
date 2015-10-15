//
//  GMLLeftMenuView.m
//  NewDemo
//
//  Created by hi on 15/10/15.
//  Copyright (c) 2015年 GML. All rights reserved.
//

#import "GMLLeftMenuView.h"
#import "GMLLeftButton.h"


@interface GMLLeftMenuView ()
@property (nonatomic,strong) GMLLeftButton *selectedButton;
//存放按钮的数组
@property (nonatomic,strong) NSMutableArray *buttonArr;
//存放>的数组
@property (nonatomic,strong) NSMutableArray *arrowArr;
//背景滚动视图
@property (nonatomic,weak)  UIScrollView *backgroundScroll;
@end

@implementation GMLLeftMenuView

- (NSMutableArray *)buttonArr
{
    if (_buttonArr == nil) {
        _buttonArr = [NSMutableArray array];
        
    }
    return _buttonArr;
}

- (NSMutableArray *)arrowArr
{
    if (_arrowArr == nil) {
        _arrowArr = [NSMutableArray array];
    }
    return _arrowArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpScrollView];
        CGFloat alpha = 1.0;
        [self setupBtnWithIcon:nil title:@"news" bgColor:GMLColorRGBA(202, 68, 73, alpha)];
        [self setupBtnWithIcon:nil title:@"Subscribe" bgColor:GMLColorRGBA(190, 111, 69, alpha)];
        [self setupBtnWithIcon:nil title:@"photo" bgColor:GMLColorRGBA(76, 132, 190, alpha)];
        [self setupBtnWithIcon:nil title:@"video" bgColor:GMLColorRGBA(101, 170, 78, alpha)];
        [self setupBtnWithIcon:nil title:@"comment" bgColor:GMLColorRGBA(170, 172, 73, alpha)];
        [self setupBtnWithIcon:nil title:@"radio" bgColor:GMLColorRGBA(190, 62, 119, alpha)];
    }
    return self;
}

- (void)setUpScrollView
{
    UIScrollView *backgroundScroll = [[UIScrollView alloc] init];
    backgroundScroll.showsHorizontalScrollIndicator = NO;
    backgroundScroll.showsVerticalScrollIndicator = NO;
    backgroundScroll.contentSize = CGSizeMake(self.width,ScreenWidth);
    [self addSubview:backgroundScroll];
    self.backgroundScroll = backgroundScroll;
}

- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title bgColor:(UIColor *)bgColor
{
    GMLLeftButton *btn = [[GMLLeftButton alloc] init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundScroll addSubview:btn];
    
    // 设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setBackgroundColor:bgColor];
    
    btn.adjustsImageWhenHighlighted = NO;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    // 省略对按钮图片的设置
    [self.buttonArr addObject:btn];
    if (self.buttonArr.count == 1) {
        [self buttonClick:btn];
    }
    return btn;
    
}

- (void)buttonClick:(GMLLeftButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftMenu:didSelectedFrom:to:)]) {
        [self.delegate leftMenu:self didSelectedFrom:self.selectedButton.tag to:btn.tag];
        
    }
    self.selectedButton.selected=NO;
    btn.selected=YES;
    self.selectedButton= btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundScroll.frame = self.bounds;
    
    int btnCount = (int)self.buttonArr.count;
    CGFloat btnW = self.width;
    CGFloat btnH = 0;
    if (iPhone6 || iPhone6P || iPhone5) {
        btnH = 60;
    }else {
        btnH = 50;
    }
//    CGFloat arrowW =
    for (int i = 0; i < btnCount ; i++) {
        UIButton *btn = self.buttonArr[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH + LeftMenuButtonY;
        btn.tag = i;
        
    }
    
}

@end
