//
//  BaseNavigationController.m
//  News
//
//  Created by hi on 15/10/15.
//  Copyright (c) 2015年 GML. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController
+(void)initialize
{
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBarTintColor:[UIColor clearColor]];
    
    [naviBar setTintColor:[UIColor whiteColor]];
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    naviBar.shadowImage = [[UIImage alloc] init];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTintColor:[UIColor whiteColor]];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

@end
