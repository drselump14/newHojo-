//
//  Player.h
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic,copy) NSString *workName;
@property (nonatomic,copy) NSString *crop;
@property (nonatomic,copy) NSString *hojo;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *finishTime;
@property (nonatomic,copy) NSString *pestiside;
@property (nonatomic,copy) NSString *pestisideVolume;
@property (nonatomic,copy) NSString *pestisideDilution;
@property (nonatomic,copy) NSString *CarrierCount;

@end
