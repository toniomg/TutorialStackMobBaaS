//
//  TSRegisterViewController.h
//  TutorialStackMob
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSRegisterViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordRegisterTextField;


-(IBAction)signUpUserPressed:(id)sender;

@end
