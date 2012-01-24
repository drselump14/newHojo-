//
//  MemberPickerController.h
//  hojo!
//
//  Created by slamet kristanto on 1/24/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkInfoViewController.h"

@protocol WorkInfoViewControllerDelegate;

@interface MemberPickerController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *memberPickerTable;
    NSMutableArray *memberArray;
    id<WorkInfoViewControllerDelegate> delegate;
    NSUInteger selectedIndex;
}

@property (nonatomic,retain) id<WorkInfoViewControllerDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *memberArray;
@property (nonatomic,retain) NSString *member;
@end
