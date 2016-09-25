//
//  PlayListViewController.h
//  virijallu
//
//  Created by Srinivas on 09/09/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayListCell.h"
#import "DataHelper.h"
#import "AlbumViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface PlayListViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DataHelperDelegate>
{
    MBProgressHUD *progressHUD;
}
@property (strong, nonatomic) NSMutableArray *gridData;
@property (weak, nonatomic) IBOutlet UICollectionView *objCollection;
@end
