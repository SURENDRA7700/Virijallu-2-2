//
//  MVTableViewCell.h
//  virijallu
//
//  Created by Vishal on 28/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel* eventName;
@property(nonatomic, weak) IBOutlet UIImageView* eventImage;
@end
