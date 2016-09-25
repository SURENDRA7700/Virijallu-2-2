//
//  EVTableViewCell.h
//  virijallu
//
//  Created by Vishal on 28/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel* eventName;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

@end
