//
//  LoginViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/28/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryViewController.h"

@protocol DiaryViewDelegate;

@interface LoginViewController : UIViewController{
    IBOutlet UITextField *usernameField;
	IBOutlet UITextField *passwordField;
    UIAlertView *failedAlert;
    id<DiaryViewDelegate> delegate;
	//IBOutlet UIButton *loginButton;
    NSMutableArray *userNameArray,*passwordArray;
	IBOutlet UIActivityIndicatorView *loginIndicator;
}

@property (nonatomic, retain) UITextField *usernameField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIActivityIndicatorView *loginIndicator;
@property (nonatomic, retain) id<DiaryViewDelegate> delegate;


-(IBAction)Login:(id)sender;
-(IBAction)textFieldReturn:(id)sender;
@end
