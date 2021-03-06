//
//  SecondViewController.m
//  tabBarTest
//
//  Created by slamet kristanto on 1/4/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "MyAnnotation.h"
#import "MapDetailsViewController.h"

@implementation SecondViewController
@synthesize myMapView,toolBar;
@synthesize editMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"圃場マップ", @"圃場マップ");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) changeMapType: (id)sender
{
    if (myMapView.mapType == MKMapTypeStandard)
        myMapView.mapType = MKMapTypeHybrid;
    else
        myMapView.mapType = MKMapTypeStandard;
} 

- (void)mapView:(MKMapView *)mapView 
didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    self.myMapView.centerCoordinate = 
    userLocation.location.coordinate;
} 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.];
  
    myMapView.delegate = self;
    
    myMapView.showsUserLocation = YES;
    MKUserLocation *userLocation = myMapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 1500, 1500);
    [myMapView setRegion:region animated
    :NO];
    
    UIBarButtonItem *typeButton = 
    [[UIBarButtonItem alloc]
     initWithTitle: @"Type"
     style:UIBarButtonItemStyleBordered
     target: self
     action:@selector(changeMapType:)];
    
    NSArray *buttons = [[NSArray alloc] 
                        initWithObjects:typeButton, nil];
    
    toolBar.items = buttons;
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = 34.311141;
    theCoordinate1.longitude = 134.009161;
	
	CLLocationCoordinate2D theCoordinate2;
    theCoordinate2.latitude = 34.311442;
    theCoordinate2.longitude = 134.010211;
	
	CLLocationCoordinate2D theCoordinate3;
    theCoordinate3.latitude = 34.312966;
    theCoordinate3.longitude = 134.01123;
	
	CLLocationCoordinate2D theCoordinate4;
    theCoordinate4.latitude = 34.310919;
    theCoordinate4.longitude = 134.0105019;
    
    CLLocationCoordinate2D theCoordinate5;
    theCoordinate5.latitude = 34.080527;
    theCoordinate5.longitude = 133.649272;
	
	CLLocationCoordinate2D theCoordinate6;
    theCoordinate6.latitude = 34.07974;
    theCoordinate6.longitude = 133.647201;
	
	CLLocationCoordinate2D theCoordinate7;
    theCoordinate7.latitude = 34.084254;
    theCoordinate7.longitude = 133.652179;
	
	CLLocationCoordinate2D theCoordinate8;
    theCoordinate8.latitude = 34.083846;
    theCoordinate8.longitude = 133.649594;
    
    MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
    
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=@"体育";
	myAnnotation1.subtitle=@"高専のグラウンド";
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"前期研究";
	myAnnotation2.subtitle=@"村上研究室";
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"俺の部屋";
	myAnnotation3.subtitle=@"清雲寮";
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"後期研究";
	myAnnotation4.subtitle=@"重田研究室";
    
    MyAnnotation* myAnnotation5=[[MyAnnotation alloc] init];
    
	myAnnotation5.coordinate=theCoordinate5;
	myAnnotation5.title=@"圃場A";
	myAnnotation5.subtitle=@"井戸地区の南側";
	
	MyAnnotation* myAnnotation6=[[MyAnnotation alloc] init];
	
	myAnnotation6.coordinate=theCoordinate6;
	myAnnotation6.title=@"圃場B";
	myAnnotation6.subtitle=@"井戸地区の北側";
	
	MyAnnotation* myAnnotation7=[[MyAnnotation alloc] init];
	
	myAnnotation7.coordinate=theCoordinate7;
	myAnnotation7.title=@"圃場C";
	myAnnotation7.subtitle=@"井戸地区の西側";
	
	MyAnnotation* myAnnotation8=[[MyAnnotation alloc] init];
	
	myAnnotation8.coordinate=theCoordinate8;
	myAnnotation8.title=@"圃場D";
	myAnnotation8.subtitle=@"井戸地区の東側";
    
    [myMapView addAnnotation:myAnnotation1];
    [myMapView addAnnotation:myAnnotation2];
    [myMapView addAnnotation:myAnnotation3];
    [myMapView addAnnotation:myAnnotation4];
    [myMapView addAnnotation:myAnnotation5];
    [myMapView addAnnotation:myAnnotation6];
    [myMapView addAnnotation:myAnnotation7];
    [myMapView addAnnotation:myAnnotation8];
    
    [annotations addObject:myAnnotation1];
    [annotations addObject:myAnnotation2];
    [annotations addObject:myAnnotation3];
    [annotations addObject:myAnnotation4];
    [annotations addObject:myAnnotation5];
    [annotations addObject:myAnnotation6];
    [annotations addObject:myAnnotation7];
    [annotations addObject:myAnnotation8];
    
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark MKMapViewDelegate
/*
 - (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
 {
 return [kml viewForOverlay:overlay];
 }
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	NSLog(@"welcome into the map view annotation");
	
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
	// try to dequeue an existing pin view first
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
									 initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
	pinView.animatesDrop=YES;
	pinView.canShowCallout=YES;
	pinView.pinColor=MKPinAnnotationColorGreen;
	NSString *userLoc=[[NSString alloc]initWithFormat:@"%1.6lf,%1.6lf",annotation.coordinate.latitude,annotation.coordinate.longitude];
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:userLoc forState:UIControlStateNormal];
	[rightButton addTarget:self
					action:@selector(showDetails:) 
		  forControlEvents:UIControlEventTouchUpInside];
    //[rightButton performSelector:@selector(showDetails:getCooordinate:) withObject:annotation.
	pinView.rightCalloutAccessoryView = rightButton;
	
	
	return pinView;
}
-(void)showDetails:(id)sender{
    MapDetailsViewController *mapDetail=[[MapDetailsViewController alloc]initWithNibName:@"MapDetailsViewController" bundle:nil];
    mapDetail.destinationCoordinate=((UIButton*)sender).currentTitle;
    //mapDetail.destinationCoordinate=((UIButton*)sender).
    [self.navigationController pushViewController:mapDetail animated:YES];
}

@end
