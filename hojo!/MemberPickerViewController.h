//
//  MemberPickerViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/14/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MemberPickerViewController;

@protocol MemberPIckerViewControllerDelegate <NSObject>
-(void)memberPickerViewController:(MemberPickerViewController *)controller didSelectMember:(NSString *)member;
@end

@interface MemberPickerViewController : UITableViewController

@property (nonatomic,strong)NSArray *member;
@property (nonatomic,weak) id <MemberPIckerViewControllerDelegate> delegate;


@end
