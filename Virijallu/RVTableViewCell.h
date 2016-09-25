//
//  RVTableViewCell.h
//  virijallu
//
//  Created by Vishal on 28/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel* titleName;
@property(nonatomic, weak) IBOutlet UILabel* hosted;
@property(nonatomic, weak) IBOutlet UILabel* time;
@property(nonatomic, weak) IBOutlet UIImageView* prgImageView;

@end
