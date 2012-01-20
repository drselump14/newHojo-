//
//  TakeHojoFromMap.m
//  hojo!
//
//  Created by slamet kristanto on 1/20/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "TakeHojoFromMap.h"
#import "AppDelegate.h"
#import "MyAnnotation.h"
#import "EditViewController.h"

@implementation TakeHojoFromMap
@synthesize myMapView;
@synthesize editMap,selectedHojo;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"圃場マップ", @"圃場マップ");
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
                                        userLocation.location.coordinate, 500, 500);
    [myMapView setRegion:region animated
                        :NO];
    
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
    
    [myMapView addAnnotation:myAnnotation1];
    [myMapView addAnnotation:myAnnotation2];
    [myMapView addAnnotation:myAnnotation3];
    [myMapView addAnnotation:myAnnotation4];
    
    [annotations addObject:myAnnotation1];
    [annotations addObject:myAnnotation2];
    [annotations addObject:myAnnotation3];
    [annotations addObject:myAnnotation4];
    
}
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
	
	
	//UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    UIButton* addButton=[UIButton buttonWithType:UIButtonTypeContactAdd];
	[addButton setTitle:annotation.title forState:UIControlStateNormal];
	[addButton addTarget:self
					action:@selector(addHojo:)
		  forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = addButton;
	
	
	return pinView;
}
-(IBAction)addHojo:(id)sender{
    selectedHojo=((UIButton*)sender).currentTitle;
    [delegate didReceiveWorkPlace:selectedHojo];
    [self.navigationController popViewControllerAnimated:YES];
    
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
