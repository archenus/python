//
//  AddItemViewController.m
//  ramdomFood
//
//  Created by jsong on 2015. 6. 22..
//  Copyright (c) 2015년 jsong. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self openDB];
    [self createTableNamed:@"tb_food" withField1:@"food_nm"];
    //[self getAllRowsFromTableNamed:@"tb_food"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)unwindToList:(UIStoryboardSegue *)segue; {
    sqlite3_close(db);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(sender != self.saveButton) return;
    if(self.textField.text.length > 0) {
        [self insertRecordIntoTableNamed:@"tb_food" withFiled1:@"food_nm" fieldValue:self.textField.text];
//        self.foodItem = [[FoodItem alloc] init];
//        self.foodItem.foodName = self.textField.text;
//        self.foodItem.completed = NO;
    }
}

#pragma mark - database
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
-(void) getAllRowsFromTableNamed: (NSString*)tableName
{
    NSString* qsql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    //NSMutableArray* foodList = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
            char *field1 = (char*) sqlite3_column_text(statement, 0);
            NSString* field1Str = nil;
            if(field1 == NULL) {
                NSLog(@"Null");
                field1Str = nil;
            } else {
                field1Str = [[NSString alloc]initWithUTF8String:field1];
                
                [_foodList addObject:field1Str];
                NSString* str = [[NSString alloc]initWithFormat:@"%@", field1Str];
                
                NSLog(@"%@", str);
            }

        }
        sqlite3_finalize(statement);
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
    sqlite3_close(db);
}

@end
