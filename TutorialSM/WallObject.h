//
//  WallObject.h
//  TutorialStackMob
//
//  Created by Antonio Martinez on 06/11/2012.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WallObject : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * createddate;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * sm_owner;
@property (nonatomic, retain) NSString * wallobject_id;

@end
