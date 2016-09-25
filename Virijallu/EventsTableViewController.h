//
//  EventsTableViewController.h
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface EventsTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,DataHelperDelegate>{
    NSInteger _currentSection;
    NSInteger _currentRow;
    MBProgressHUD *progressHUD;
}
@property(nonatomic, weak) IBOutlet UITableView* tableView;
@property(nonatomic, weak) IBOutlet UILabel* heading;
@property(nonatomic, weak) IBOutlet UILabel* subtitle;

@property(nonatomic, strong) NSMutableArray* headViewArray;
@end
