//
//  AddItemViewController.h
//  ramdomFood
//
//  Created by jsong on 2015. 6. 22..
//  Copyright (c) 2015년 jsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "FoodItem.h"

@interface AddItemViewController : UIViewController{
    sqlite3* db;
}

@property (strong, nonatomic) NSMutableArray* foodList;
@property FoodItem* foodItem;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

-(NSString*) filePath;
-(void) openDB;
-(void) createTableNamed:(NSString*)tableName withField1:(NSString*)field1;
-(void) getAllRowsFromTableNamed: (NSString*)tableName;
-(void) insertRecordIntoTableNamed:(NSString*)tableName withFiled1:(NSString*)field1 fieldValue:(NSString*)field1Value;
@end
