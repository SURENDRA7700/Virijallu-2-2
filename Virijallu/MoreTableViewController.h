//
//  MoreTableViewController.h
//  virijallu
//
//  Created by Vishal on 20/02/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"

@interface MoreTableViewController : UITableViewController <HeadViewDelegate>{
    NSInteger _currentSection;
    NSInteger _currentRow;
}
@property(nonatomic, strong) NSMutableArray* headViewArray;
@end
