//
//  CropsTableViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/19/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewDelegate; 
@interface CropsTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    id<EditViewDelegate> delegate;
    NSString *myCrop;
    IBOutlet UITableView *cropTable;
    NSArray *cropName;
    NSUInteger selectedIndex;
}

@property (nonatomic,retain) id<EditViewDelegate> delegate;
@property (nonatomic,retain) NSString *myCrop;


-(IBAction)dismissView:(id)sender;
@end
