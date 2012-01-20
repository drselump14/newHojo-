//
//  DiaryDetailsViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberPickerViewController.h"

@class DiaryDetailsViewController;
@class Player;

@protocol DiaryDetailsViewControllerDelegate <NSObject>
- (void)diaryDetailsViewControllerDidCancel:
(DiaryDetailsViewController *)controller;
- (void)diaryDetailsViewController:
(DiaryDetailsViewController *)controller didAddPlayer:(Player *)player;
@end

@interface DiaryDetailsViewController : UITableViewController<MemberPIckerViewControllerDelegate>

@property (nonatomic, weak) id <DiaryDetailsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
