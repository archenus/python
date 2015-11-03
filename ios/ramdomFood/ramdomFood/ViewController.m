//
//  ViewController.m
//  ramdomFood
//
//  Created by jsong on 2015. 6. 18..
//  Copyright (c) 2015년 jsong. All rights reserved.
//

#import "ViewController.h"
#import "FoodListTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *ddayLabel;
@end

@implementation ViewController
- (void)viewDidLoad {
    _foodList = [[NSMutableArray alloc]init];
    [self openDB];
    [self createTableNamed:@"tb_food" withField1:@"food_nm"];
    [self getAllRowsFromTableNamed:@"tb_food"];
    sqlite3_close(db);
    

    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue; {
    //[self.view setNeedsDisplay];
    [self openDB];
    [self createTableNamed:@"tb_food" withField1:@"food_nm"];
    [self getAllRowsFromTableNamed:@"tb_food"];
    sqlite3_close(db);
}
/// DATABASE
- (NSString*) filePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}
-(void) openDB
{
    if(sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open.");
    }
}
-(void) createTableNamed:(NSString *)tableName withField1:(NSString *)field1
{
    char *err;

    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY);", tableName, field1];
    
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Table failed to create.");
    }
}
-(void) insertRecordIntoTableNamed:(NSString*)tableName withFiled1:(NSString*)field1 fieldValue:(NSString*)field1Value
{
    char *err;
    
    NSString* sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@') VALUES ('%@')", tableName, field1, field1Value];
    
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Error updating table.");
    }
}
-(void) getAllRowsFromTableNamed: (NSString*)tableName
{
    NSString* qsql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    //NSMutableArray* foodList = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
            char *field1 = (char*) sqlite3_column_text(statement, 0);
            NSString *field1Str;
            
            if(field1 == NULL) {
                field1Str = nil;
            }
            else {
                field1Str = [[NSString alloc]initWithUTF8String:field1];
                [_foodList addObject:field1Str];
                NSString* str = [[NSString alloc]initWithFormat:@"%@", field1Str];
                
                NSLog(@"str: %@", str);
            }
            
            

        }
        sqlite3_finalize(statement);
    }
}

// END DATABASE
- (IBAction)shuffle:(id)sender {
    //NSString* selected = list[arc4random() % [list count]];
    NSString* selected = _foodList[arc4random() % [_foodList count]];

    self.foodLabel.text = selected;
}

@end
