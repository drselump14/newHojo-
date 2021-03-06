//
//  DiaryViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "DiaryViewController.h"
#import "Player.h"
#import "DiaryCell.h"
#import "MemberPickerViewController.h"
#import "EditViewController.h"
#import "AddDiaryViewController.h"
#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <unistd.h>

@implementation DiaryViewController

@synthesize players;
@synthesize editViewController;
//@synthesize responseData;

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
- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    
	NSLog(@"JSONsuccess");
	//NSArray* latestLoans = (NSArray*)[responseString JSONValue] ;
    NSArray* latestLoans=[NSJSONSerialization 
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions 
                          error:&error];   
    int i;
    for (i=0; i<[latestLoans count]; i++) {
        NSString *workNameJSON=[[latestLoans objectAtIndex:i]objectForKey:@"workname"];
        NSString *crop=[[latestLoans objectAtIndex:i]objectForKey:@"crop"];
        NSString *area=[[latestLoans objectAtIndex:i]objectForKey:@"area"];
        NSString *startTime1=[[latestLoans objectAtIndex:i]objectForKey:@"time11"];
        NSString *startTime2=[[latestLoans objectAtIndex:i]objectForKey:@"time12"];
        NSString *finishTime1=[[latestLoans objectAtIndex:i]objectForKey:@"time21"];
        NSString *finishTime2=[[latestLoans objectAtIndex:i]objectForKey:@"tiem22"];
        // NSLog(@"%@",workNameJSON);
        //choose a random loan
        if ([startTime1 integerValue]<10) startTime1=[NSString stringWithFormat:@"0%@",startTime1];
        if([startTime2 integerValue]<10)startTime2=[NSString stringWithFormat:@"0%@",startTime2];
        if([finishTime1 integerValue]<10)finishTime1=[NSString stringWithFormat:@"0%@",finishTime1];
        if([finishTime2 integerValue]<10)finishTime2=[NSString stringWithFormat:@"0%@",finishTime2];
        
        Player *player =[[Player alloc] init];
        player.workName=workNameJSON;
        player.crop=crop;
        player.hojo=area;
        player.startTime=[[NSString alloc]initWithFormat:@"%@:%@",startTime1,startTime2];
        player.finishTime=[[NSString alloc]initWithFormat:@"%@:%@",finishTime1,finishTime2];
        player.Check=@"NO";
        [players addObject:player];
    }
    badgeNumber=[players count];
    [self.tableView reloadData];
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeNumber;
    NSString *myBadgeValue=[[NSString alloc]initWithFormat:@"%d",badgeNumber];
    if (badgeNumber==0) {
        self.navigationController.tabBarItem.badgeValue=nil;
    } else {
        self.navigationController.tabBarItem.badgeValue=myBadgeValue;
    }
    
    [HUD hide:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    LoginViewController *loginController=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    loginController.delegate=self;
    [self presentModalViewController:loginController animated:YES];
    UIBarButtonItem *editButton =[[UIBarButtonItem alloc] initWithTitle:@"編集" style:UIBarButtonItemStyleBordered target:self action:@selector(EditTable:)];
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"送信" style:UIBarButtonItemStyleDone target:self action:@selector(SubmitTable:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
    [self.navigationItem setRightBarButtonItem:submitButton];
    /*NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://210.137.228.50/workers/1/onedays.json"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
    badgeNumber=[players count];
    players =[NSMutableArray arrayWithCapacity:20];
    //self.responseData = [NSMutableData data];
            
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
    Player *player=[self.players objectAtIndex:indexPath.row];
    if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [UIApplication sharedApplication].applicationIconBadgeNumber++;
        badgeNumber=badgeNumber+1;
        player.Check=@"NO";
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
        player.Check=@"YES";
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"サーバーに送信"]) {
        for (int i=0; i<[players count]; i++) {
            Player *player=[self.players objectAtIndex:i];
            NSDate* date=[NSDate date];
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *str=[formatter stringFromDate:date];
            NSLog(@"%@",str);
            if ([player.Check isEqualToString:@"YES"]) {
                NSArray *piecesOfStartTime=[player.startTime componentsSeparatedByString:@":"];
                NSString *time11=[piecesOfStartTime objectAtIndex:0];
                NSString *time12=[piecesOfStartTime objectAtIndex:1];
                NSArray *piecesOfFinishTime=[player.finishTime componentsSeparatedByString:@":"];
                NSString *time21=[piecesOfFinishTime objectAtIndex:0];
                NSString *time22=[piecesOfFinishTime objectAtIndex:1];
                //NSLog(@"%@ hahah %@",time11,time12);
                NSString *urlString=[[NSString alloc]initWithString:@"http://210.137.228.50/crops/3/diaries.json"];
                NSURL *url=[NSURL URLWithString:urlString];
                __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
                [request setPostValue:str forKey:@"diary[day]"];
                [request setPostValue:player.workName forKey:@"diary[worked]"];
                [request setPostValue:player.crop forKey:@"diary[sakumotsu]"];
                [request setPostValue:time11 forKey:@"diary[time11]"];
                [request setPostValue:time12 forKey:@"diary[time12]"];
                [request setPostValue:time21 forKey:@"diary[time21]"];
                [request setPostValue:time22 forKey:@"diary[time22]"];
                [request setPostValue:userNameString forKey:@"diary[worker]"];
                [request setCompletionBlock:^{
                    NSString *responseString=[request responseString];
                    NSLog(@"Response: %@", responseString);
                }];
                [request setFailedBlock:^{
                    NSError *error = [request error];
                    NSLog(@"Error: %@", error.localizedDescription);
                }];
                [request startAsynchronous];
            }
            
        }
        
        //NSLog(@"sent");
    } else {
        NSLog(@"Canceled");
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
-(void)getUser:(NSString *)user{
    NSLog(@"%@",user);
    //self.responseData=[NSMutableData data];
    NSString *urlString=[[NSString alloc]initWithFormat:@"http://210.137.228.50/workers/%@/onedays.json",user];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: 
                        [NSURL URLWithString:urlString]];
        [self performSelectorOnMainThread:@selector(fetchedData:) 
                               withObject:data waitUntilDone:YES];
    });
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading..";
	[HUD show:YES];
}
-(void)getUserName:(NSString *)userName{
    userNameString=userName;
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
