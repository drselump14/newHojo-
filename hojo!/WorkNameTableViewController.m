//
//  WorkNameTableViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/18/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "WorkNameTableViewController.h"
//#import "AppDelegate.h"
#import "EditViewController.h"


@implementation WorkNameTableViewController{
    NSArray *workNames;
    NSUInteger selectedIndex;
}
@synthesize workName;
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
    self.title=@"作業名";
    WorkTable.delegate=self;
    WorkTable.dataSource=self;
    workNames=[NSArray arrayWithObjects:@"種まき",@"収穫",@"水やり",@"肥料散布",@"畝立て",@"定植",@"防除", @"もみすり"@"調整",@"選別",@"出荷",nil];
    selectedIndex=[workNames indexOfObject:self.workName];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [workNames count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[workNames objectAtIndex:indexPath.row];
    if (indexPath.row==selectedIndex) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (selectedIndex!=NSNotFound) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    selectedIndex=indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    NSString *theWork=[workNames objectAtIndex:indexPath.row];
    [delegate didReceiveWork:theWork];
    /*AppDelegate *theWorkData=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    theWorkData.workData=theWork;*/
    /*UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"tes" message:theWork delegate:self cancelButtonTitle:@"tes" otherButtonTitles: nil];
    [alert show];*/
    //[self.delegate workNameTableViewController:self didSelectWork:theWork];
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    workName=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
