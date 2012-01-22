//
//  WorkInfoViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/21/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "WorkInfoViewController.h"
#import "ICB_WeatherConditions.h"
#import "MyReverseGeocoder.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@implementation WorkInfoViewController
@synthesize currentTempLabel,highTempLabel,lowTempLabel,conditionLabel,cityLabel,humidityLabel;
@synthesize conditionImageView;
@synthesize conditionImage;
@synthesize locationManager;
@synthesize locationDelegate;

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //[locationManager stopUpdatingLocation];
    userLocationLat=newLocation.coordinate.latitude;
    userLocationLong=newLocation.coordinate.longitude;
    NSString *userLat=[[NSString alloc]initWithFormat:@"%lf",userLocationLat];
    NSString *userLong=[[NSString alloc]initWithFormat:@"%lf",userLocationLong];
    NSLog(@"%@,%@",userLat,userLong);
    [self performSelector:@selector(showLatitude:showLongitude:) withObject:userLat withObject:userLong];
    /*CLGeocoder *geocoder=[[CLGeocoder alloc]init];
     [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error){
     
     for (CLPlacemark *placemark in placemarks) {
     test=[placemark locality];
     NSLog(@"%@",test);
     //[self performSelectorInBackground:@selector(showWeatherFor:) withObject:test];
     }
     
     }];*/
}
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

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    CLLocationCoordinate2D coord;    
    coord.latitude = userLocationLat;
    coord.longitude = userLocationLong;
    
    //CLGeocoder
    if (locationManager==nil) {
        locationManager=[[CLLocationManager alloc] init];
    }
    locationManager.delegate=self; 
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    /*CLGeocoder *geocoder=[[CLGeocoder alloc]init];
     [geocoder reverseGeocodeLocation:locationManager.location completionHandler:<#^(NSArray *placemarks, NSError *error)completionHandler#>{
     
     
     }];*/
    
    // Geocode coordinate (normally we'd use location.coordinate here instead of coord).
    // This will get us something we can query Google's Weather API with
    /*MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coord];
     geocoder.delegate = self;
     [geocoder start];*/
    //[geocoder reverseGeocodeLocation:coord completionHandler:^(NSArray *placemarks,NSError *error)];
    //weatherTable.delegate=self;
    //weatherTable.dataSource=self;
}
-(void)showLatitude:(NSString *)latitude showLongitude:(NSString *)longitude{
    MyReverseGeocoder *userLocation = [[MyReverseGeocoder alloc] initWithLatitude:latitude initWithLongitude:longitude];
    
    [self performSelectorOnMainThread:@selector(updateLocation:) withObject:userLocation waitUntilDone:NO];
}
- (void)showWeatherFor:(NSString *)query
{
    
    ICB_WeatherConditions *weather = [[ICB_WeatherConditions alloc] initWithQuery:query];
    
    self.conditionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:weather.conditionImageURL]];
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:weather waitUntilDone:NO];
    
    
}

// This happens in the main thread
- (void)updateUI:(ICB_WeatherConditions *)weather
{
    self.conditionImageView.image = self.conditionImage;
    
    [self.currentTempLabel setText:[NSString stringWithFormat:@"%d°C", weather.currentTemp]];
    [self.humidityLabel setText:weather.humidity];
    [self.highTempLabel setText:[NSString stringWithFormat:@"%d°C", weather.highTemp]];
    [self.lowTempLabel setText:[NSString stringWithFormat:@"%d°C", weather.lowTemp]];
    [self.conditionLabel setText:weather.condition];
    [self.cityLabel setText:weather.location];
    
}

-(void)updateLocation:(MyReverseGeocoder *)userCity
{
    NSLog(@"%@",userCity.city);
    //[self performSelectorInBackground:@selector(showWeatherFor:) withObject:userCity.city];
}
#pragma mark MKReverseGeocoder Delegate Methods
/*- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
 {
 
 [self performSelectorInBackground:@selector(showWeatherFor:) withObject:[placemark.addressDictionary objectForKey:@"ZIP"]];
 }
 
 - (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
 {    
 NSLog(@"reverseGeocoder:%@ didFailWithError:%@", geocoder, error);
 
 }*/

/*-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return 3;
 }
 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 if (section==0) {
 return @"気象情報";
 }
 }
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"WeatherCell"];
 cell.textLabel.text=@"tes";
 return cell;
 }
 */
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
