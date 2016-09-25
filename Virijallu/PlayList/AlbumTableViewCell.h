//
//  AlbumTableViewCell.h
//  virijallu
//
//  Created by Srinivas on 09/09/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell
@property (strong, nonatomic) NSMutableDictionary *cellStatusDic;
@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
