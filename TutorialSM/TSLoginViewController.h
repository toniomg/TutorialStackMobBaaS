//
//  TSLoginViewController.h
//  TutorialStackMob
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMClient;

@interface TSLoginViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UITextField *userTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) SMClient *client;

-(IBAction)signUpPressed:(id)sender;
-(IBAction)logInPressed:(id)sender;

@end
