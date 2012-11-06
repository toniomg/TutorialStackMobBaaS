//
//  TSUploadImageViewController.h
//  TutorialStackMob
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TSUploadImageViewController : UIViewController <UIPickerViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UIImageView *imgToUpload;
@property (nonatomic, retain) IBOutlet UITextField *commentTextField;
@property (nonatomic, retain) NSString *username;

-(IBAction)selectPicturePressed:(id)sender;

@end
