//
//  SponsorsTableViewController.h
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface SponsorsTableViewController : UIViewController<DataHelperDelegate , UITableViewDataSource , UITableViewDelegate>
{
    MBProgressHUD *progressHUD;

}
@property (nonatomic , weak) IBOutlet UITableView *tableView;
@end
