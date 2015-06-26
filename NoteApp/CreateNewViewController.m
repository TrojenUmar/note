//
//  CreateNewViewController.m
//  NoteApp
//
//  Created by InfoEnum03 on 02/05/15.
//  Copyright (c) 2015 InfoEnum03. All rights reserved.
//

#import "CreateNewViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "NotesTable.h"
#import "AlarmViewController.h"

@interface CreateNewViewController ()
{
    NSMutableArray *fetchDataArray;
    NSInteger *deleteIndexInteger;
}

@property (strong, nonatomic) IBOutlet UITextView *textViewEdit;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonDoneAction;
@property (strong,nonatomic) NSDateFormatter *todayDateFormater;

@end


@implementation CreateNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
    self.textViewEdit.text=[self.receiveRowSelected valueForKey:@"text"];
    
    
    self.todayDateFormater=[[NSDateFormatter alloc]init];
    [self.todayDateFormater setDateFormat:@"EEEE,dd-MM-yy:hh:mm,a"];
}

- (IBAction)buttonDoneAction:(id)sender
{
    if (self.textViewEdit.text.length!=0)
    {
        if (self.receiveRowSelected)
        {
            [self.receiveRowSelected setValue:self.textViewEdit.text forKey:@"text"];
            [self.receiveRowSelected setValue:[NSDate date] forKey:@"date"];
           // [self.receiveRowSelected setValue:[NSDate date] forKey:@"alarm"];

        }
        else
        {
            NSManagedObject *notesTableEntry = [NSEntityDescription insertNewObjectForEntityForName:@"NotesTable" inManagedObjectContext:[self managedObjectContext]];
            
            [notesTableEntry setValue:self.textViewEdit.text forKey:@"text"];
            [notesTableEntry setValue:[NSDate date] forKey:@"date"];
           // [notesTableEntry setValue:[NSDate date] forKey:@"alarm"];

       }

        [[self managedObjectContext] save:nil];

        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Notes can not be null" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)buttonDeleteAction:(id)sender
{
    [[self managedObjectContext] deleteObject:self.receiveRowSelected];
    [[self managedObjectContext] save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

- (IBAction)newControllerbtn:(id)sender
{
    self.textViewEdit.text=@"";
    self.receiveRowSelected= nil;
    [self.textViewEdit becomeFirstResponder];
}

- (IBAction)shareButton:(id)sender
{
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[UIActivityTypePostToFacebook,UIActivityTypePostToFlickr,UIActivityTypePostToTwitter] applicationActivities:nil ];
    [self presentViewController:activityVC  animated:YES completion:nil];
}

@end
