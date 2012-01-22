//
//  MyReverseGeocoder.m
//  hojo!
//
//  Created by slamet kristanto on 1/22/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "MyReverseGeocoder.h"
#import "TouchXML.h"

@implementation MyReverseGeocoder

@synthesize city;

-(MyReverseGeocoder *)initWithLatitude:(NSString *)latitude initWithLongitude:(NSString *)longitude
{
    if (self = [super init])
    {
        
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/xml?latlng=%@,%@&sensor=true&language=en",latitude,longitude]] options:0 error:nil];
        NSArray *nodes = NULL;
        //  searching for piglet nodes
        nodes = [parser nodesForXPath:@"/GeocodeResponse/result/address_component/long_name" error:nil];
        
        for (CXMLElement *node in nodes) {
            int counter;
            for(counter = 0; counter < [node childCount]; counter++) {
                //city=[[node childAtIndex:counter] stringValue];
            }
        }
    }
    city=@"takamatsu";
    return self;
}


@end
