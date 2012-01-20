//
//  DiaryCell.h
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *gameLabel;
@property (nonatomic,strong) IBOutlet UISwitch *mySwitch;

@end
