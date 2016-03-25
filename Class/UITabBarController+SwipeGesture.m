//
//  UITabBarController+SwipeGesture.m
//  TabBarController
//
//  Created by C360_liyanjun on 16/3/21.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import "UITabBarController+SwipeGesture.h"
#import <objc/runtime.h>

@implementation UITabBarController (SwipeGesture)

static const void *temPreSelectedIndex = &temPreSelectedIndex;
static const void *temSwipeLoop = &temSwipeLoop;

@dynamic preSelectedIndex;
@dynamic swipeLoop;


-(void)addSwipeGesture
{
    //判断tabbar上的手势为空就创建
    if ([self.view.gestureRecognizers count] == 0)
    {
        //加左右滑手势
        UISwipeGestureRecognizer* leftSwipeRecognizer = nil;
        leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selectNextPage:)];
        [leftSwipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self.view addGestureRecognizer:leftSwipeRecognizer];
        
        UISwipeGestureRecognizer* rightSwipeRecognizer = nil;
        rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selectNextPage:)];
        [rightSwipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self.view addGestureRecognizer:rightSwipeRecognizer];
    }
    
     self.preSelectedIndex = self.selectedIndex;
}
//手势触发
-(void)selectNextPage:(UISwipeGestureRecognizer*)recognizer
{
    UIViewController* curViewC = self.selectedViewController;
    if ([curViewC isKindOfClass:[UINavigationController class]])
    {
        NSUInteger subCount = [((UINavigationController*)curViewC).viewControllers count];
        if (subCount > 1)
        {
            //pop
            if (recognizer.direction==UISwipeGestureRecognizerDirectionRight)
            {
                [((UINavigationController*)curViewC) popViewControllerAnimated:YES];
            }
            
            return;
        }
    }
    NSArray* ary = self.viewControllers;
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        if (!self.swipeLoop)
        {
            if (self.preSelectedIndex == (ary.count -1))
            {
                return;
            }
        }
        
        for (int iIndex = 1 ;iIndex < ary.count ;iIndex++)
        {
            NSUInteger nextIndex = (self.selectedIndex + iIndex)%ary.count;
            
            UIViewController *c = [ary objectAtIndex:nextIndex];
            BOOL couldClick = YES;
            if([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
            {
                couldClick = [self.delegate tabBarController:self shouldSelectViewController:c];
            }
            
            if (!couldClick)
            {
                continue;
            }
            else
            {
                
                [self achieveAnimation:self.selectedIndex toIndex:nextIndex recognizerDirection:UISwipeGestureRecognizerDirectionLeft];
                break;
            }
            
        }
    }
    else if(recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        
        if (!self.swipeLoop)
        {
            if (self.preSelectedIndex == 0)
            {
                return;
            }
        }
        
        for (int searchCount = 1; searchCount < ary.count; searchCount++)
        {
            NSUInteger nextIndex = (self.selectedIndex - searchCount + ary.count)%ary.count;
            UIViewController* c = [ary objectAtIndex:nextIndex];
            BOOL couldClick = YES;
            if([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
            {
                couldClick = [self.delegate tabBarController:self shouldSelectViewController:c];
            }
            if (!couldClick)
            {
                continue;
            }
            else
            {
                [self achieveAnimation:self.selectedIndex toIndex:nextIndex recognizerDirection:UISwipeGestureRecognizerDirectionRight];
                break;
            }
        }
    }
}

//截图方法，图片用来做动画
-(UIImage*)imageByCropping:(UIView*)imageToCrop toRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize pageSize = CGSizeMake(scale*rect.size.width, scale*rect.size.height) ;
    UIGraphicsBeginImageContext(pageSize);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    
    CGContextRef resizedContext =UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext,-1*rect.origin.x,-1*rect.origin.y);
    [imageToCrop.layer renderInContext:resizedContext];
    UIImage*imageOriginBackground =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageOriginBackground = [UIImage imageWithCGImage:imageOriginBackground.CGImage scale:scale orientation:UIImageOrientationUp];
    
    return imageOriginBackground;
}

//实现动画效果
-(void)achieveAnimation:(NSUInteger)originIndex toIndex:(NSUInteger)toIndex recognizerDirection:(UISwipeGestureRecognizerDirection)direction
{
    if (originIndex >= self.viewControllers.count)
    {
        return;
    }
    if (toIndex >= self.viewControllers.count)
    {
        return;
    }
    
    
    UIViewController* v1 = [self.viewControllers objectAtIndex:originIndex];
    UIViewController* v2 = [self.viewControllers objectAtIndex:toIndex];
    
    UIImage *image1 = [self imageByCropping:v1.view toRect:CGRectMake(0, 0, CGRectGetWidth(v1.view.frame), CGRectGetHeight(v1.view.frame)-CGRectGetHeight(self.tabBar.frame))];
    UIImage *image2 = [self imageByCropping:v2.view toRect:CGRectMake(0, 0, CGRectGetWidth(v1.view.frame), CGRectGetHeight(v1.view.frame)-CGRectGetHeight(self.tabBar.frame))];
    
    if (image1 == nil || image2 == nil)
    {
        return;
    }
    
    UIImageView* imageview1 = [[UIImageView alloc] initWithImage:image1];
    UIImageView* imageview2 = [[UIImageView alloc] initWithImage:image2];
    imageview1.backgroundColor = [UIColor whiteColor];
    imageview2.backgroundColor = [UIColor whiteColor];
    
    UIWindow* window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    CGRect rectV1 = [v1.view convertRect:CGRectMake(0, 0, CGRectGetWidth(v1.view.frame), CGRectGetHeight(v1.view.frame)-CGRectGetHeight(self.tabBar.frame)) toView:window];
    
    //set possion
    imageview1.frame = rectV1;
    imageview2.frame = rectV1;
    
    [window addSubview:imageview1];
    [window addSubview:imageview2];
    
    window.userInteractionEnabled = NO;
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (direction == UISwipeGestureRecognizerDirectionLeft)
    {
        //to left
        imageview2.center = CGPointMake(imageview1.center.x + screenWidth, imageview1.center.y);
    }
    else
    {
        //to right
        imageview2.center = CGPointMake(imageview1.center.x - screenWidth, imageview1.center.y);
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (direction == UISwipeGestureRecognizerDirectionLeft)
        {
            //to left
            imageview1.center = CGPointMake(imageview1.center.x - screenWidth, imageview1.center.y);
            imageview2.center = CGPointMake(imageview2.center.x - screenWidth, imageview1.center.y);
        }
        else
        {
            //to right
            imageview1.center = CGPointMake(imageview1.center.x + screenWidth, imageview1.center.y);
            imageview2.center = CGPointMake(imageview2.center.x + screenWidth, imageview1.center.y);
        }
        
        
    } completion:^(BOOL finished)
     {
         [imageview1 removeFromSuperview];
         [imageview2 removeFromSuperview];
         window.userInteractionEnabled = YES;
         
         self.selectedIndex = toIndex;
         self.preSelectedIndex = self.selectedIndex;
     }];
}

#pragma mark -setter and getter－

- (void)setPreSelectedIndex:(NSUInteger)preSelectedIndex
{
    objc_setAssociatedObject(self,temPreSelectedIndex,@(preSelectedIndex),OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)preSelectedIndex
{
    return [objc_getAssociatedObject(self, temPreSelectedIndex) integerValue];
}

- (void)setSwipeLoop:(BOOL)swipeLoop
{
    objc_setAssociatedObject(self, temSwipeLoop, @(swipeLoop), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)swipeLoop
{
    return [objc_getAssociatedObject(self, temSwipeLoop) boolValue];
}

#pragma mark -点击动画－
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.3f];
    [animation setType:kCATransitionPush];
    
    if (self.selectedIndex > self.preSelectedIndex)
    {
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.view layer]addAnimation:animation forKey:@"switchView"];
    }
    else if(self.selectedIndex < self.preSelectedIndex)
    {
        [animation setSubtype:kCATransitionFromLeft];
       
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.view layer]addAnimation:animation forKey:@"switchView"];
    }

     self.preSelectedIndex = self.selectedIndex;
}

@end
