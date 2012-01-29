//
//  LoginViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/28/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize loginButton;
@synthesize loginIndicator;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    failedAlert=[[UIAlertView alloc]initWithTitle:@"エラー" message:@"ユーザーネムあるいはパスワードが間違っています" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    userNameArray=[[NSMutableArray alloc]initWithObjects:@"saito",@"takahashi",@"sato",@"kato", nil];
    passwordArray=[[NSMutableArray alloc]initWithObjects:@"murakami",@"murakami",@"murakami",@"murakami", nil];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)Login:(id)sender{
    //loginIndicator.hidden = FALSE;
	//[loginIndicator startAnimating];
    if ([usernameField.text isEqualToString:@"saito"]&&[passwordField.text isEqualToString:@"murakami"]) {
        [self dismissModalViewControllerAnimated:YES];
        [delegate getUser:@"1"];
    }
    else{
        [failedAlert show];
    }
}
-(IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
