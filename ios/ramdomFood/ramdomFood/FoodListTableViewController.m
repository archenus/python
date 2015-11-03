//
//  FoodListTableViewController.m
//  ramdomFood
//
//  Created by jsong on 2015. 6. 21..
//  Copyright (c) 2015년 jsong. All rights reserved.
//

#import "FoodListTableViewController.h"
#import "FoodItem.h"
#import "AddItemViewController.h"

@interface FoodListTableViewController ()

@property NSMutableArray *foodItems;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FoodListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self openDB];
    [self createTableNamed:@"tb_food" withField1:@"food_nm"];
    [self getAllRowsFromTableNamed:@"tb_food"];
    sqlite3_close(db);
  //  [self loadInitialData];
    NSLog(@"count  : %lu", (unsigned long)[self.foodItems count]);


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [self.foodItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
      FoodItem* foodItem = self.foodItems[indexPath.row];
      cell.textLabel.text = foodItem.foodName;
    // Configure the cell...
    if(foodItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"val :%@", [[self.foodItems objectAtIndex:indexPath.row]foodName]);
        [self openDB];
        [self createTableNamed:@"tb_food" withField1:@"food_nm"];

        [self deleteCell:@"tb_food" withField1:@"food_nm" andField1Value:[[self.foodItems objectAtIndex:indexPath.row]foodName]];
        [self getAllRowsFromTableNamed:@"tb_food"];
        sqlite3_close(db);
        [self.tableView reloadData];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"tapped");
    FoodItem* tappedItem = [self.foodItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    [self openDB];
    [self createTableNamed:@"tb_food" withField1:@"food_nm"];
    [self getAllRowsFromTableNamed:@"tb_food"];
    sqlite3_close(db);
    [self.tableView reloadData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
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
    self.foodItems = nil;
    self.foodItems = [[NSMutableArray alloc]init];
    NSArray* list = @[@"매운 갈비찜", @"감자탕", @"순대국", @"파스타", @"햄버거", @"피자", @"짜장면", @"냉면"];
    [_foodItems arrayByAddingObjectsFromArray:list];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
            char *field1 = (char*) sqlite3_column_text(statement, 0);
            NSString* field1Str;
            
            if(field1 == NULL) {
                field1Str = nil;
            } else {
                field1Str = [[NSString alloc]initWithUTF8String:field1];
                FoodItem *item = [[FoodItem alloc]init];
                item.foodName = field1Str;
                [_foodItems addObject:item];
                
                NSString* str = [[NSString alloc]initWithFormat:@"%@", field1Str];
                
                NSLog(@"%@", str);
            }
        }
        sqlite3_finalize(statement);
    }
}
-(void) deleteCell:(NSString *)tableName withField1:(NSString *)field1 andField1Value:(NSString *)field1Value
{
    char *err;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@';", tableName,field1,field1Value];
                     
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Error updating table.");
    }
}
#pragma mark - gesture

@end
