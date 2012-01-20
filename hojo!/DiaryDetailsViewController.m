//
//  DiaryDetailsViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "DiaryDetailsViewController.h"
#import "Player.h"


@implementation DiaryDetailsViewController{
    NSString *member;
}
@synthesize delegate;
@synthesize nameTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    //self.detailLabel.text = member;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (indexPath.section == 0)
		[self.nameTextField becomeFirstResponder];
}


- (IBAction)cancel:(id)sender
{
	[self.delegate diaryDetailsViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    Player *player = [[Player alloc] init];
    //player.name= self.nameTextField.text;
    //player.game=member;
	[self.delegate diaryDetailsViewController:self   
                                  didAddPlayer:player];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        NSLog(@"init DiaryDetailsViewCOntroller");
        member = @"Chess";
    }
    return self;
}
/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickMember"]) {
        MemberPickerViewController *memberPickerViewController = segue.destinationViewController;
        memberPickerViewController.delegate = self;
        memberPickerViewController.member = member;
    }
}*/
#pragma mark -MemberPickerViewControllerDelegate
-(void)memberPickerViewController:(MemberPickerViewController *)controller didSelectMember:(NSString *)themember
{
    member = themember;
    //self.detailLabel.text = game;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
