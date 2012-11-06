//
//  User.m
//  TutorialStackMob
//
//  Created by Antonio Martinez on 24/10/2012.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self) {
        // assign local variables and do other init stuff here
    }
    
    return self;
}

@end

