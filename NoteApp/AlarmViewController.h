//
//  AlarmViewController.h
//  NoteApp
//
//  Created by InfoEnum03 on 28/06/15.
//  Copyright (c) 2015 InfoEnum03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AlarmViewController : UIViewController
{
    UILocalNotification *notificationAlarm;
}
   
@property (strong, nonatomic) IBOutlet UIDatePicker *alarmDatePicker;
@property (strong, nonatomic) IBOutlet UILabel *labelAlarm;
@property (strong, nonatomic) NSDate *fireAlarmDate;
@end
