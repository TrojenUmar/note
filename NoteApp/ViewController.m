//
//  ViewController.m
//  NoteApp
//
//  Created by InfoEnum03 on 02/05/15.
//  Copyright (c) 2015 InfoEnum03. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "CreateNewViewController.h"
#import "NotesTable.h"

@interface ViewController ()
{
    NSManagedObjectContext *context;
    NSMutableArray *fetchDataArray;
    NSInteger *deleteInterger;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Notes";
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    context =  appDelegate.managedObjectContext;
}

//- (NSManagedObjectContext *)managedObjectContext
//{
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    return appDelegate.managedObjectContext;
//}

- (NSInteger)tableView:(UITableViewCell *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fetchDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idendifire =@"cellIndentifier";
    CustomCell *cell =[tableView dequeueReusableCellWithIdentifier:idendifire];
    if (cell==Nil)
    {
        cell=[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifire];
    }
    
    NSManagedObject *entyrobject = [fetchDataArray objectAtIndex:indexPath.row];
    cell.labelCustomeCell.text= [entyrobject valueForKey:@"text"];
    
    // NSdate Arrangement in notes.........
    
    NSDateFormatter *todayDateFormatter=[[NSDateFormatter alloc]init];
    
    [todayDateFormatter setDateFormat:@"dd-MM-yy:hh:mm:ss"];
    
    
    NSDate *getDateCoreData=[entyrobject valueForKey:@"date"];
    
  // [__NSCFCalendar components:fromDate:toDate:options:] + 129

    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    NSCalendarUnit units=kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay;
    
    NSDate *currentDate=[NSDate date];
    
    // (NSDateComponents *)components:(NSCalendarUnit)unitFlags fromDate:(NSDate *)startingDate toDate:(NSDate *)resultDate options:(NSCalendarOptions)opts;
    NSDateComponents *components=[[NSDateComponents alloc]init];
    
    components =[calendar components:units fromDate:getDateCoreData toDate:currentDate options:0];
    
    NSLog(@"components--  %@",components);
     NSDateFormatter *todayTimeFormatter=[[NSDateFormatter alloc]init];
    cell.labelDate.text=[todayTimeFormatter stringFromDate:getDateCoreData];
    NSLog(@"components--  %@",cell.labelDate.text);
   
     
    if (components.day==0)
    {
       // NSDateFormatter *todayTimeFormatter=[[NSDateFormatter alloc]init];
        [todayTimeFormatter setDateFormat:@"hh:mm:ss"];
        cell.labelDate.text=[todayTimeFormatter stringFromDate:getDateCoreData];
        
    }
    else if(components.day==1)
    {
        cell.labelDate.text=@"Yesterday";
    }
    else if (components.day<=7)
    {
        NSDateFormatter *todayFormatter=[[NSDateFormatter alloc]init];
        [todayFormatter setDateFormat:@"EEEE"];
        cell.labelDate.text=[todayFormatter stringFromDate:getDateCoreData];
    }
    else
    {
        NSDateFormatter *OldFormatter=[[NSDateFormatter alloc]init];
        [OldFormatter setDateFormat:@"dd-MM-yy"];
        cell.labelDate.text=[OldFormatter stringFromDate:getDateCoreData];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"index path value---%@",indexPath);
    
    CreateNewViewController *creatEditViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewViewController"];
    
    
    NSManagedObject *rowSelected= [fetchDataArray objectAtIndex:indexPath.row];
    
    
    creatEditViewController.receiveRowSelected=rowSelected;
    
    [self.navigationController pushViewController:creatEditViewController animated:YES];
    
   // NSLog(@"selected row---%@",rowSelected);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        [context deleteObject:[fetchDataArray objectAtIndex:indexPath.row]];
        
        [fetchDataArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    
    NSError *error;
    if (![context save:&error])
    {
       // NSLog(@"CAN'T DELETE - %@",error.localizedDescription);
        return;
    }
    
    [tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    fetchDataArray=[[NSMutableArray alloc]init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"NotesTable"];
    //    fetchDataArray=[[[self managedObjectContext] executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    fetchDataArray  = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"Fetch DATA Array%@",fetchDataArray);
    
    
    //*for sorting array
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc]initWithKey:@"date" ascending:FALSE];
    [fetchDataArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    //*
    
    [self.tableViewDisplay reloadData];
    
}

@end
