//
//  TSUploadImageViewController.m
//  TutorialStackMob
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "TSUploadImageViewController.h"
#import "StackMob.h"
#import "TSAppDelegate.h"

@interface TSUploadImageViewController ()

@end

@implementation TSUploadImageViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize imgToUpload = _imgToUpload;
@synthesize username = _username;
@synthesize commentTextField = _commentTextField;

- (TSAppDelegate *)appDelegate {
    return (TSAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)dealloc
{
    [_imgToUpload release];
    [_username release];
    [_commentTextField release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Upload";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendPressed:)] autorelease];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.imgToUpload = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark IB Actions

-(IBAction)selectPicturePressed:(id)sender
{
    
    //Open a UIImagePickerController to select the picture
    UIImagePickerController *imgPicker = [[[UIImagePickerController alloc] init] autorelease];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentModalViewController:imgPicker animated:YES];


}

-(IBAction)sendPressed:(id)sender
{
    [self.commentTextField resignFirstResponder];
    
    //Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;
//
//    
//    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];

    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];

    
    //Upload wall object
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"WallObject" inManagedObjectContext:self.managedObjectContext];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imgToUpload.image, 0.9);
    
    NSString *picData = [SMBinaryDataConversion stringForBinaryData:imageData name:@"someImage.jpg" contentType:@"image/jpg"];
    
    [newManagedObject setValue:picData forKey:@"photo"];
    [newManagedObject setValue:self.commentTextField.text forKey:@"comment"];
    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
            [errorAlertView release];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //Remove the activity indicator and enable the send button again
    
    [loadingSpinner stopAnimating];
    [loadingSpinner removeFromSuperview];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    
}

#pragma mark UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo 
{
    
    [picker dismissModalViewControllerAnimated:YES];
    
    //Place the image in the imageview
    self.imgToUpload.image = img;

    
}

#pragma mark Error View


-(void)showErrorView:(NSString *)errorMsg
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
    [errorAlertView release];
}


@end
