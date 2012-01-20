//
//  AddDiaryViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/17/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDiaryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *addTable;
    IBOutlet UIBarItem *cancelButton;
    IBOutlet UIBarItem *saveButton;
    NSMutableArray *Label1,*Label2;
}
@property (nonatomic,strong) NSMutableArray *Label1,*Label2;
-(IBAction)didCancel:(id)sender;
-(IBAction)didSave:(id)sender;
@end
