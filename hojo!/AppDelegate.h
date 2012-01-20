//
//  AppDelegate.h
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *workData;
}

@property (strong, nonatomic) UIWindow *window;
@property (copy,readwrite) NSString *workData;

@end
