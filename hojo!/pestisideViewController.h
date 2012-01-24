//
//  pestisideViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/24/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@protocol EditViewDelegate;

@interface pestisideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *pestisideTable;
    id<EditViewDelegate> delegate;
    NSMutableArray *pestisideArray;
    NSUInteger selectedIndex;
}

@property (nonatomic,retain) NSMutableArray *pestisideArray;
@property (nonatomic,retain) id<EditViewDelegate> delegate;

@end
