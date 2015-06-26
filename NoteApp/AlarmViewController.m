//
//  AlarmViewController.m
//  NoteApp
//
//  Created by InfoEnum03 on 28/06/15.
//  Copyright (c) 2015 InfoEnum03. All rights reserved.
//

#import "AlarmViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
@interface AlarmViewController ()

@end

@implementation AlarmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.backItem.title=@"Cancel" ;
//    self.navigationController.toolbarHidden=YES;
    
    notificationAlarm=[[UILocalNotification alloc]init];
    
}

- (IBAction)buttonSetAlarmAction:(id)sender
{
 self.fireAlarmDate =self.alarmDatePicker.date;
    
    [notificationAlarm setFireDate:self.fireAlarmDate];
    
    notificationAlarm.timeZone = [NSTimeZone defaultTimeZone];
    notificationAlarm.applicationIconBadgeNumber = 2;
    
    notificationAlarm.soundName = UILocalNotificationDefaultSoundName;
    
    [notificationAlarm setAlertBody:@"Alarm Notification"];
    [notificationAlarm setAlertAction:@"go to app"];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notificationAlarm];
    
    /////***
    NSManagedObject *notesTableEntry = [NSEntityDescription insertNewObjectForEntityForName:@"NotesTable" inManagedObjectContext:[self managedObjectContext]];
    
    [notesTableEntry setValue:self.fireAlarmDate forKey:@"alarm"];
    [[self managedObjectContext] save:nil];
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}



@end
