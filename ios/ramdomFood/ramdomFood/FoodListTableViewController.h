//
//  FoodListTableViewController.h
//  ramdomFood
//
//  Created by jsong on 2015. 6. 21..
//  Copyright (c) 2015년 jsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface FoodListTableViewController : UITableViewController <UIGestureRecognizerDelegate> {
    sqlite3* db;
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

-(NSString*) filePath;
-(void) openDB;
-(void) createTableNamed:(NSString*)tableName withField1:(NSString*)field1;
-(void) getAllRowsFromTableNamed: (NSString*)tableName;

@end
