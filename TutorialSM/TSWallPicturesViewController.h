//
//  TSWallPicturesViewController.h
//  TutorialStackMob
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMob.h"

@interface TSWallPicturesViewController : UIViewController <NSFetchedResultsControllerDelegate>


@property (nonatomic, retain) IBOutlet UIScrollView *wallScroll;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) SMClient *client;

-(IBAction)uploadPressed:(id)sender;
-(IBAction)logoutPressed:(id)sender;

@end
