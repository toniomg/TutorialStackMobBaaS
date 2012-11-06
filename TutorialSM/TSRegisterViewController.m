//
//  TPRegisterViewController.m
//  TutorialParse
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TSRegisterViewController.h"
#import "TSWallPicturesViewController.h"
#import "TSAppDelegate.h"

#import "StackMob.h"
#import "User.h"

@interface TSRegisterViewController ()

@end


@implementation TSRegisterViewController

@synthesize userRegisterTextField = _userRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField;
@synthesize managedObjectContext = _managedObjectContext;

- (TSAppDelegate *)appDelegate {
    return (TSAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)dealloc{
    
    [_userRegisterTextField release];
    [_passwordRegisterTextField release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Sign Up";

    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userRegisterTextField = nil;
    self.passwordRegisterTextField = nil;
}


#pragma mark IB Actions

////Sign Up Button pressed
-(IBAction)signUpUserPressed:(id)sender
{
    User *newUser = [[User alloc] initIntoManagedObjectContext:[self.appDelegate managedObjectContext]];
    
    [newUser setValue:self.userRegisterTextField.text forKey:[newUser sm_primaryKeyField]];
    [newUser setPassword:self.passwordRegisterTextField.text];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        //Something bad has ocurred
        NSString *errorString = [error localizedDescription];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
        [errorAlertView release];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
       
    }
    
    [newUser release];

}

@end
