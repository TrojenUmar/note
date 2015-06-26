//
//  ViewController.h
//  NoteApp
//
//  Created by InfoEnum03 on 02/05/15.
//  Copyright (c) 2015 InfoEnum03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateNewViewController.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

}


@property (weak, nonatomic) IBOutlet UITableView *tableViewDisplay;

@end

