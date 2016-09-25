//
//  CDSideBarController.h
//  CDSideBar
//
//  Created by Christophe Dellac on 9/11/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CDSideBarControllerDelegate <NSObject>

- (void)menuButtonClicked:(int)index;
- (void)socialNetworkButtonClicked:(int)index;

@end

@interface CDSideBarController : NSObject
{
    
    UIView              *_backgroundMenuView;
    UIButton            *_menuButton;
    NSMutableArray      *_buttonList;
    NSMutableArray      *_socialButtons;

    UIView              *overLayView;
}

@property(nonatomic, assign) int widthSideMenu;
@property (nonatomic, retain) UIColor *menuColor;
@property (nonatomic, retain) NSMutableArray *titlesList;

@property (nonatomic) BOOL isOpen;

@property (nonatomic, retain) id<CDSideBarControllerDelegate> delegate;

- (CDSideBarController*)initWithTitleList:(NSArray*)titles widthOfSideMenu:(int)width;
- (void)insertMenuButtonOnView:(UIView*)view atPosition:(CGPoint)position;

- (void)dismissMenu;

@end
