//
//  GMLLeftMenuView.h
//  NewDemo
//
//  Created by hi on 15/10/15.
//  Copyright (c) 2015年 GML. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  LeftMenuButtonY  50

@class GMLLeftMenuView;
@protocol GMLLeftMenuViewDelegate <NSObject>
@optional
-(void)leftMenu:(GMLLeftMenuView *)leftMenu didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface GMLLeftMenuView : UIView
@property (nonatomic,weak) id<GMLLeftMenuViewDelegate>delegate;
@end
