//
//  User.h
//  TutorialStackMob
//
//  Created by Antonio Martinez on 24/10/2012.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"

@interface User : SMUserManagedObject

@property (nonatomic, retain) NSString * username;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end