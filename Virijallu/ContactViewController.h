//
//  ContactViewController.h
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "DataHelper.h"


@interface ContactViewController : UIViewController <DataHelperDelegate>
{
    MBProgressHUD *progressHUD;
    
}
@property (nonatomic , weak) IBOutlet UILabel *aboutUS_Lable;
@end