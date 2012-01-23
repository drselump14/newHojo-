//
//  MapDetailsViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/23/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "MapDetailsViewController.h"

@implementation MapDetailsViewController
@synthesize mapDetailArray,mapLabelArray;
@synthesize destinationCoordinate;
@synthesize locationManager;
@synthesize locationDelegate;

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
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //[locationManager stopUpdatingLocation];
    userLocationLat=newLocation.coordinate.latitude;
    userLocationLong=newLocation.coordinate.longitude;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"圃場の情報";
    CLLocationCoordinate2D coord;    
    coord.latitude = userLocationLat;
    coord.longitude = userLocationLong;
    
    //CLGeocoder
    if (locationManager==nil) {
        locationManager=[[CLLocationManager alloc] init];
    }
    locationManager.delegate=self; 
    //locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    mapDetail.delegate=self;
    mapDetail.dataSource=self;
    mapLabelArray=[[NSMutableArray alloc]initWithObjects:@"面積",@"作物",@"現状",@"生育期間", nil];
    mapDetailArray=[[NSMutableArray alloc]initWithObjects:@"20Ha",@"タマネギ",@"肥料散布",@"2012-1-24 ~ 2012-4-5", nil];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [mapLabelArray count];
    } else {
        return 1;
    }   
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"圃場の情報";
    } else {
        return nil;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        if (indexPath.section==1) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    if (indexPath.section==0) {
        cell.textLabel.text=[mapLabelArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=[mapDetailArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text=@"この圃場へ道順";
        cell.textLabel.textAlignment=UITextAlignmentCenter;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6lf,%1.6lf&daddr=%@",userLocationLat,userLocationLong,destinationCoordinate];
        NSLog(@"%@",googleMapsURLString);
        UIApplication *app=[UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:googleMapsURLString]];
    } 
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
