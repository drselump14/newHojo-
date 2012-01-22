//
//  ICB_WeatherConditions.m
//  LocalWeather
//
//  Created by Matt Tuzzolo on 9/28/10.
//  Copyright 2010 iCodeBlog. All rights reserved.
//

#import "ICB_WeatherConditions.h"
#import "TouchXML.h"

@implementation ICB_WeatherConditions

@synthesize currentTemp, condition, conditionImageURL, location, lowTemp, highTemp,humidity;

- (ICB_WeatherConditions *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
      
       CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/ig/api?weather=%@&hl=ja",query]] options:0 error:nil];
        
        condition         = [[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/condition" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue];        
        location          = [[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_information/city" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue];

        currentTemp       = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/temp_c" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        humidity       = [[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/humidity" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue];
        lowTemp           = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_conditions[2]/low" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];
        highTemp          = [[[[[parser nodesForXPath:@"/xml_api_reply/weather/forecast_conditions/high" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue] integerValue];

        conditionImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com%@", [[[[parser nodesForXPath:@"/xml_api_reply/weather/current_conditions/icon" error:nil] objectAtIndex:0] attributeForName:@"data"] stringValue]]];
    }

    return self;
}


@end
