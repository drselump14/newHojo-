//
//  DiaryViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "DiaryViewController.h"
#import "Player.h"
#import "DiaryCell.h"
#import "MemberPickerViewController.h"
#import "EditViewController.h"
#import "AddDiaryViewController.h"

@implementation DiaryViewController

@synthesize players;
@synthesize editViewController;

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
    UIBarButtonItem *editButton =[[UIBarButtonItem alloc] initWithTitle:@"編集" style:UIBarButtonItemStyleBordered target:self action:@selector(EditTable:)];
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"送信" style:UIBarButtonItemStyleDone target:self action:@selector(SubmitTable:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
    [self.navigationItem setRightBarButtonItem:submitButton];
    badgeNumber=[players count];
    //selectedIndex = [member indexOfObject:self.member];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeNumber;
    NSString *myBadgeValue=[[NSString alloc]initWithFormat:@"%d",badgeNumber];
    if (badgeNumber==0) {
        self.navigationController.tabBarItem.badgeValue=nil;
    } else {
        self.navigationController.tabBarItem.badgeValue=myBadgeValue;
    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.players count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"今日の予定";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.players removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (cell.accessoryType==UITableViewCellAccessoryNone) {
            if ([UIApplication sharedApplication].applicationIconBadgeNumber>0) {
                [UIApplication sharedApplication].applicationIconBadgeNumber--;
                badgeNumber=badgeNumber-1;
                NSString *myBadgeValue=[[NSString alloc]initWithFormat:@"%d",badgeNumber];
                if (badgeNumber==0) {
                    self.navigationController.tabBarItem.badgeValue=nil;
                } else {
                    self.navigationController.tabBarItem.badgeValue=myBadgeValue;
                }
            }

        }
	}   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiaryCell *cell = (DiaryCell *)[tableView 
                                      dequeueReusableCellWithIdentifier:@"DiaryCell"];
	Player *player = [self.players objectAtIndex:indexPath.row];
    if ([player.workName isEqualToString:@"防除"]) {
        NSString *topLabel=[[NSString alloc]initWithFormat:@"%@(%@)",player.workName,player.crop];
        NSString *bottomLabel=[[NSString alloc]initWithFormat:@"%@(%@~%@) %@(%@/%@)",player.hojo,player.startTime,player.finishTime,player.pestiside,player.pestisideVolume,player.pestisideDilution];
        cell.textLabel.text = topLabel;
        cell.detailTextLabel.text = bottomLabel;
    }
    else if([player.workName isEqualToString:@"収穫"]){
        NSString *topLabel=[[NSString alloc]initWithFormat:@"%@(%@)",player.workName,player.crop];
        NSString *bottomLabel=[[NSString alloc]initWithFormat:@"%@(%@~%@) %@",player.hojo,player.startTime,player.finishTime,player.CarrierCount];
        cell.textLabel.text = topLabel;
        cell.detailTextLabel.text = bottomLabel;
    }
    else {
        NSString *topLabel=[[NSString alloc]initWithFormat:@"%@(%@)",player.workName,player.crop];
        NSString *bottomLabel=[[NSString alloc]initWithFormat:@"%@(%@~%@)",player.hojo,player.startTime,player.finishTime];
        cell.textLabel.text = topLabel;
        cell.detailTextLabel.text = bottomLabel;
    }
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [UIApplication sharedApplication].applicationIconBadgeNumber++;
        badgeNumber=badgeNumber+1;
        NSString *myBadgeValue=[[NSString alloc]initWithFormat:@"%d",badgeNumber];
        if (badgeNumber==0) {
            self.navigationController.tabBarItem.badgeValue=nil;
        } else {
            self.navigationController.tabBarItem.badgeValue=myBadgeValue;
        }
        
    }
    else if(cell.accessoryType==UITableViewCellAccessoryNone){
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        [UIApplication sharedApplication].applicationIconBadgeNumber--;
        badgeNumber=badgeNumber-1;
        NSString *myBadgeValue=[[NSString alloc]initWithFormat:@"%d",badgeNumber];
        if (badgeNumber==0) {
            self.navigationController.tabBarItem.badgeValue=nil;
        } else {
            self.navigationController.tabBarItem.badgeValue=myBadgeValue;
        }
    }

    
     
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddWork"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		DiaryDetailsViewController *diaryDetailsViewController = [[navigationController viewControllers] 
         objectAtIndex:0];
		diaryDetailsViewController.delegate = self;
	}
}*/

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (self.editViewController==nil) {
        EditViewController *detailViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
        self.editViewController=detailViewController;
    }
    editViewController.delegate=self;
    Player *editPlayer=[[Player alloc] init];
    editPlayer=[self.players objectAtIndex:indexPath.row];
    editViewController.editTableSignal=@"edit";
    editViewController.editTableRow=indexPath.row;
    editViewController.workName=editPlayer.workName;
    editViewController.cropName=editPlayer.crop;
    editViewController.workPlaceString=editPlayer.hojo;
    editViewController.startTimeString=editPlayer.startTime;
    editViewController.finishTimeString=editPlayer.finishTime;
    if ([editPlayer.workName isEqualToString:@"防除"]) {
        editViewController.pestiside=editPlayer.pestiside;
        editViewController.pestVolume=editPlayer.pestisideVolume;
        editViewController.pestDilution=editPlayer.pestisideDilution;
        NSLog(@"%@",editPlayer.workName);
    } else if([editPlayer.workName isEqualToString:@"収穫"]) {
        editViewController.carrierString=editPlayer.CarrierCount;
        NSLog(@"%@",editPlayer.workName);
    }
    [self.navigationController pushViewController:self.editViewController animated:YES];
}

- (IBAction) EditTable:(id)sender{
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self setEditing:NO animated:NO];
        //[self reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"編集"];
        UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"送信" style:UIBarButtonItemStyleDone target:self action:@selector(SubmitTable:)];
        [self.navigationItem setRightBarButtonItem:submitButton];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
        
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self setEditing:YES animated:YES];
        //[tblSimpleTable reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"完了"];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddTable:)];
        [self.navigationItem setRightBarButtonItem:addButton];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}
-(IBAction)SubmitTable:(id)sender{
    if (badgeNumber!=0) {
        NSString *alertMessage=[[NSString alloc]initWithFormat:@"%dつの項目がチェックされていないが、保存してもよろしいですか",badgeNumber];
        UIActionSheet *pictActionSheet=[[UIActionSheet alloc]initWithTitle:alertMessage delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:@"サーバーに送信" otherButtonTitles:nil];
        pictActionSheet.delegate=self;
        [pictActionSheet showInView:self.parentViewController.tabBarController.view];
    }
    else{
        NSString *alertMessage=[[NSString alloc]initWithString:@"保存してもよろしいですか"];
        UIActionSheet *pictActionSheet=[[UIActionSheet alloc]initWithTitle:alertMessage delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"サーバーに送信",nil];
        pictActionSheet.delegate=self;
        [pictActionSheet showInView:self.parentViewController.tabBarController.view];
    }
}

-(IBAction)AddTable:(id)sender{
    /*AddDiaryViewController *detailViewController = [[AddDiaryViewController alloc] initWithNibName:@"AddDiaryViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self presentModalViewController:detailViewController animated:YES];*/
    EditViewController *addTable=[[EditViewController alloc]initWithNibName:@"EditViewController" bundle:nil];
    addTable.delegate=self;
    [self.navigationController pushViewController:addTable animated:YES];
}
#pragma mark - PlayerDetailsViewControllerDelegate
-(void)didAddPlayer:(Player *)player{
    [self.players addObject:player];
	NSIndexPath *indexPath = 
    [NSIndexPath indexPathForRow:[self.players count] - 1 
                       inSection:0];
	[self.tableView insertRowsAtIndexPaths:
     [NSArray arrayWithObject:indexPath] 
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    badgeNumber=badgeNumber+1;
}
-(void)didEditPlayer:(Player *)player editRow:(NSInteger)row{
    [self.players replaceObjectAtIndex:row withObject:player];
    [self.tableView reloadData];
    
}
/*- (void)diaryDetailsViewControllerDidCancel:
(DiaryDetailsViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}*/


/*- (void)diaryDetailsViewController:
(DiaryDetailsViewController *)controller 
didAddPlayer:(Player *)player
{
	[self.players addObject:player];
	NSIndexPath *indexPath = 
    [NSIndexPath indexPathForRow:[self.players count] - 1 
                       inSection:0];
	[self.tableView insertRowsAtIndexPaths:
     [NSArray arrayWithObject:indexPath] 
                          withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}*/

@end
