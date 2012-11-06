//
//  TSWallPicturesViewController.m
//  TutorialStackMob
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TSWallPicturesViewController.h"
#import "TSUploadImageViewController.h"
#import "TSAppDelegate.h"
#import "WallObject.h"

@interface TSWallPicturesViewController () {

}

@property (nonatomic, retain) NSArray *wallObjectsArray;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


-(void)getWallImages;
-(void)loadWallViews;
-(void)showErrorView:errorString;

@end

@implementation TSWallPicturesViewController

@synthesize wallObjectsArray = _wallObjectsArray;
@synthesize wallScroll = _wallScroll;
@synthesize activityIndicator = _loadingSpinner;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize client = _client;

- (TSAppDelegate *)appDelegate {
    return (TSAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)dealloc 
{
    [_wallObjectsArray release];
    [_wallScroll release];
    [_loadingSpinner release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Wall";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutPressed:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPressed:)] autorelease];
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.wallScroll = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //Put the activity indicator in the view
    self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [self.activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    
    //Reload the wall
    [self getWallImages];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Wall Load
//Load the images on the wall
-(void)loadWallViews
{
    //Clean the scroll view
    for (id viewToRemove in [self.wallScroll subviews]){
        
        if ([viewToRemove isMemberOfClass:[UIView class]])
            [viewToRemove removeFromSuperview];
    }

    
    //For every wall element, put a view in the scroll
    int originY = 10;
    
    //NSLog(@"%@", self.wallObjectsArray);
    
    for (WallObject *wallObject in self.wallObjectsArray){
        
        //Build the view with the image and the comments
        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(10, originY, self.view.frame.size.width - 20 , 300)];
    
        //Add the image
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[wallObject valueForKey:@"photo"]]]]];
        userImage.frame = CGRectMake(0, 0, wallImageView.frame.size.width, 200);
        [wallImageView addSubview:userImage];
        [userImage release];
        
//        //Add the info label (User and creation date)
        int creationTimestamp = [[wallObject valueForKey:@"createddate"] doubleValue]/1000;
        NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:creationTimestamp];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm dd/MM yyyy"];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, wallImageView.frame.size.width,15)];
        infoLabel.text = [NSString stringWithFormat:@"Uploaded by: %@, %@", [wallObject valueForKey:@"sm_owner"], [df stringFromDate:creationDate]];
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:9];
        infoLabel.textColor = [UIColor whiteColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:infoLabel];
        [infoLabel release];
        [df release];
//
//        //Add the comment
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, wallImageView.frame.size.width, 15)];
        commentLabel.text = [wallObject valueForKey:@"comment"];
        commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
        commentLabel.textColor = [UIColor whiteColor];
        commentLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:commentLabel];
        [commentLabel release];
        
        [self.wallScroll addSubview:wallImageView];
        [wallImageView release];
        

        originY = originY + wallImageView.frame.size.width + 20;

    }
    
    //Set the bounds of the scroll
    self.wallScroll.contentSize = CGSizeMake(self.wallScroll.frame.size.width, originY);
    
    
    //Remove the activity indicator
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    
}



#pragma mark Receive Wall Objects

//Get the list of images
-(void)getWallImages
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WallObject" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createddate"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error){
        //Remove the activity indicator
        [self.activityIndicator stopAnimating];
        [self.activityIndicator removeFromSuperview];

        //Show the error
        NSString *errorString = [error localizedDescription];
        [self showErrorView:errorString];
        
    }
    else{
        //Everything was correct, put the new objects and load the wall
        self.wallObjectsArray = nil;
        self.wallObjectsArray = [[[NSArray alloc] initWithArray:results] autorelease];
        [self loadWallViews];
    }

    [sortDescriptor release];
    [fetchRequest release];
}

#pragma mark IB Actions
-(IBAction)uploadPressed:(id)sender
{
    //Go to the upload view
    TSUploadImageViewController *uploadImageViewController = [[TSUploadImageViewController alloc] initWithNibName:@"TSUploadImageView" bundle:nil];
    [self.navigationController pushViewController:uploadImageViewController animated:YES];
    [uploadImageViewController release];
        
}


-(IBAction)logoutPressed:(id)sender
{
    //Logout user
    self.client = [SMClient defaultClient];
    [self.client logoutOnSuccess:^(NSDictionary *result) {
        NSLog(@"Success, you are logged out");
        [self.navigationController popViewControllerAnimated:NO];
    } onFailure:^(NSError *error) {
        NSLog(@"Logout Fail: %@",error);
    }];


    
}



#pragma mark Error Alert

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
}


@end
