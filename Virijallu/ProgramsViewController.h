//
//  ProgramsViewController.h
//  Virijallu
//
//  Created by Vishal on 07/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "MBProgressHUD.h"

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ProgramsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate,DataHelperDelegate>{
    NSInteger _currentSection;
    NSInteger _currentRow;
    MBProgressHUD *progressHUD;
}
@property(nonatomic, strong) NSMutableArray* headViewArray;
@property(nonatomic, weak) IBOutlet UITableView* tableView;



@end
