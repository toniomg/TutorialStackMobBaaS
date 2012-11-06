//
//  TSLoginViewController.m
//  TutorialStackMob
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TSLoginViewController.h"
#import "TSRegisterViewController.h"
#import "TSWallPicturesViewController.h"

#import "TSAppDelegate.h"

#import "StackMob.h"

#import "User.h"

@implementation TSLoginViewController

@synthesize userTextField = _userTextField, passwordTextField = _passwordTextField;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize client = _client;

- (TSAppDelegate *)appDelegate {
    return (TSAppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void)dealloc{
    
    [_userTextField release];
    [_passwordTextField release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Log In";
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
    
    self.client = [SMClient defaultClient];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userTextField = nil;
    self.passwordTextField = nil;
}


#pragma mark IB Actions

//Show the hidden register view
-(IBAction)signUpPressed:(id)sender
{

    TSRegisterViewController *registerVC = [[TSRegisterViewController alloc] initWithNibName:@"TSRegisterView" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
    [registerVC release];
    
}

//Login button pressed
-(IBAction)logInPressed:(id)sender
{

    [self.client loginWithUsername:self.userTextField.text password:self.passwordTextField.text onSuccess:^(NSDictionary *results) {
        NSLog(@"Login Success %@",results);
        //Open the wall
        TSWallPicturesViewController *wallVC = [[TSWallPicturesViewController alloc] initWithNibName:@"TSWallPicturesView" bundle:nil];
        [self.navigationController pushViewController:wallVC animated:NO];
        [wallVC release];
        
    } onFailure:^(NSError *error) {
        //Something bad has ocurred
        NSString *errorString = [error localizedDescription];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
        [errorAlertView release];
    }];
}

@end
