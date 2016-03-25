//
//  UITabBarController+SwipeGesture.h
//  TabBarController
//
//  Created by C360_liyanjun on 16/3/21.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (SwipeGesture)

//上一次选择的是哪一个按钮，为了切换动画准备
@property (nonatomic) NSUInteger preSelectedIndex;

//是否循环滑动
@property (nonatomic) BOOL swipeLoop;

//添加左右滑动手势
-(void)addSwipeGesture;

@end
