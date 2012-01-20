//
//  WorkNameTableViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/18/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@protocol EditViewDelegate;

@interface WorkNameTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    id<EditViewDelegate> delegate;
    IBOutlet UITableView *WorkTable;
}

@property(strong,nonatomic) NSString *workName;
@property(retain,nonatomic) id<EditViewDelegate> delegate;
@end
