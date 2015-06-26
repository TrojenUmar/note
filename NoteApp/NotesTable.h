//
//  NotesTable.h
//  NoteApp
//
//  Created by InfoEnum03 on 04/05/15.
//  Copyright (c) 2015 InfoEnum03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NotesTable : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic,retain) NSDate *alarm;

@end
