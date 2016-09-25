//
//  CDSideBarController.m
//  CDSideBar
//
//  Created by Christophe Dellac on 9/11/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import "CDSideBarController.h"

@interface CDSideBarController ()
{
    UIView *tapGestureView;
    UITapGestureRecognizer *singleTap;
    NSArray *socialImages;
}
@end
@implementation CDSideBarController

@synthesize menuColor = _menuColor;
@synthesize isOpen = _isOpen;

#pragma mark - 
#pragma mark Init

- (CDSideBarController*)initWithTitleList:(NSArray*)titles widthOfSideMenu:(int)width
{
    _widthSideMenu = width;
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.frame = CGRectMake(0, 0, 40, 40);
    [_menuButton setImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateNormal];
    [_menuButton setImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateHighlighted];
    [_menuButton setImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateSelected];
    _menuButton.backgroundColor = [UIColor blackColor];
    _menuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _backgroundMenuView = [[UIView alloc] init];
    overLayView = [[UIView alloc] init];
    _menuColor = [UIColor whiteColor];
    _buttonList = [[NSMutableArray alloc] initWithCapacity:titles.count];
    _socialButtons =[[NSMutableArray alloc] initWithCapacity:3];
    

    int index = 0;
    for (NSString *title in [titles copy])
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //[button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(2.5, 10 + (38 * index), _widthSideMenu - 5, 35);
        button.tag = index;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(onMenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonList addObject:button];
        ++index;
    }
    
    return self;
}

- (void)insertMenuButtonOnView:(UIView*)view atPosition:(CGPoint)position
{
    // window == view
    
    _menuButton.frame = CGRectMake(position.x, position.y, _menuButton.frame.size.width, _menuButton.frame.size.height);
    [view addSubview:_menuButton];
    
    
    tapGestureView = view;
    
    [self tapGestureForView:view];
    
    for (UIButton *button in _buttonList)
    {
        [_backgroundMenuView addSubview:button];
    }
    
    overLayView.frame = CGRectMake(view.frame.size.width, 64, 320, view.frame.size.height-64);

    _backgroundMenuView.frame = CGRectMake(view.frame.size.width, 64, _widthSideMenu, view.frame.size.height-64);
    socialImages = @[@"linkedin",@"facebook",@"twitter"];
    //** social buttons **//
    int socialIndex = 0;
    for (int i = 0 ; i <= 2 ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20 +(40 * socialIndex),_backgroundMenuView.frame.size.height - 50 , 30, 30);
        button.tag = socialIndex;
        button.layer.cornerRadius = 15;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        [button setImage:[UIImage imageNamed:[socialImages objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onSocialNetworkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundMenuView addSubview:button];
        ++socialIndex;
    }
    _backgroundMenuView.backgroundColor = [UIColor blackColor];
    overLayView.backgroundColor = [UIColor clearColor];
    [view addSubview:overLayView];
    [view addSubview:_backgroundMenuView];
}

#pragma mark - Show

- (void)animateSpringWithView:(UIButton *)view idx:(NSUInteger)idx initDelay:(CGFloat)initDelay {
#if __IPHONE_OS_VERSION_SOFT_MAX_REQUIRED
    [UIView animateWithDuration:0.5
                          delay:(initDelay + idx*0.1f)
         usingSpringWithDamping:10
          initialSpringVelocity:50
                        options:0
                     animations:^{
                         view.layer.transform = CATransform3DIdentity;
                         view.alpha = 1;
                     }
                     completion:nil];
#endif
}

- (void)animateFauxBounceWithView:(UIButton *)view idx:(NSUInteger)idx initDelay:(CGFloat)initDelay {
    [UIView animateWithDuration:0.2
                          delay:(initDelay + idx*0.1f)
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseInOut
                     animations:^{
                         view.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1 animations:^{
                             view.layer.transform = CATransform3DIdentity;
                         }];
                     }];
}



- (void)tapGestureForView:(UIView*)view{
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)];
    [view addGestureRecognizer:singleTap];
}


#pragma mark -
#pragma mark Menu button action

- (void)dismissMenuWithSelection:(UIButton*)button
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:.2f
          initialSpringVelocity:10.f
                        options:0 animations:^{
                          //  button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                        }
                     completion:^(BOOL finished) {
                         [self dismissMenu];
                     }];
}

- (void)dismissMenu
{
    if (_isOpen)
    {
         for(UIGestureRecognizer *recognizer in [[UIApplication sharedApplication] keyWindow].gestureRecognizers)
        {
             [tapGestureView removeGestureRecognizer:recognizer];
         }
        
        _isOpen = !_isOpen;
       [self performDismissAnimation];
    }
}

- (void)showMenu
{
    if (!_isOpen)
    {
        [self tapGestureForView:tapGestureView];
        _isOpen = !_isOpen;
        [self performSelectorInBackground:@selector(performOpenAnimation) withObject:nil];
    }
    else if (_isOpen){
        [self dismissMenu];
    }
}

- (void)onMenuButtonClick:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(menuButtonClicked:)])
        [self.delegate menuButtonClicked:(int)button.tag];
    [self dismissMenuWithSelection:button];
}

- (void)onSocialNetworkButtonClicked:(UIButton*)button{
    
    if ([self.delegate respondsToSelector:@selector(onSocialNetworkButtonClicked:)])
        [self.delegate socialNetworkButtonClicked:(int)button.tag];

    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect pathFrame = CGRectMake(-CGRectGetMidX(button.bounds), -CGRectGetMidY(button.bounds), button.bounds.size.width, button.bounds.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:button.layer.cornerRadius];
        CAShapeLayer *circleShape = [CAShapeLayer layer];
        circleShape.path = path.CGPath;
        circleShape.position = button.center;
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.opacity = 0;
        circleShape.strokeColor = [UIColor blueColor].CGColor;
        circleShape.lineWidth = 2;
        [_backgroundMenuView.layer addSublayer:circleShape];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;
        
        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[scaleAnimation, alphaAnimation];
        animation.duration = 0.5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [circleShape addAnimation:animation forKey:nil];

        
    } completion:^(BOOL finished) {
        [NSThread sleepForTimeInterval:0.25f];

        [self dismissMenuWithSelection:button];
    }];
    
    
}

#pragma mark -
#pragma mark - Animations

- (void)performDismissAnimation
{
    [UIView animateWithDuration:0.4 animations:^{
//        _menuButton.alpha = 1.0f;
//        _menuButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        _backgroundMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        overLayView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);

    }];
}

- (void)performOpenAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
//            _menuButton.alpha = 0.0f;
//            _menuButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -90, 0);
            _backgroundMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -_widthSideMenu, 0);
            overLayView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -320, 0);
        }];
    });
    for (UIButton *button in _buttonList)
    {
        [NSThread sleepForTimeInterval:0.02f];
        dispatch_async(dispatch_get_main_queue(), ^{
            button.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 15, 0);
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                 usingSpringWithDamping:.3f
                  initialSpringVelocity:10.f
                                options:0 animations:^{
                                    button.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                                }
                             completion:^(BOOL finished) {
                             }];
        });
    }
}

@end
