//
//  ViewController.m
//  Core Data Tutorial
//
//  Created by Raj Dhakate on 01/02/17.
//  Copyright © 2017 Raj Dhakate. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *listArray;
    AppDelegate *delegate;
    NSManagedObjectContext *context;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    listArray = [[NSMutableArray alloc]init];
    [self fetchItems];
    [self.tableView reloadData];
}

#pragma mark - Get Managed Context (Needed for core data to work)

- (NSManagedObjectContext *)managedObjectContext {
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    context = [[delegate persistentContainer]viewContext];
 
    NSLog(@"ManagedContext Created Successfully");
    
    return context;
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [listArray objectAtIndex:indexPath.row];

    return cell;
}


#pragma mark - Add Item to list

- (IBAction)addItem:(UIBarButtonItem *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Item" message:@"Enter Name of new item to add." preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Item Name";
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        UITextField *nameTextField = alert.textFields.firstObject;
        
        if (nameTextField.text != 0) {
            [self saveItemMethod:nameTextField.text];
        }
        
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];

}


#pragma mark - Save to Core Data

- (void) saveItemMethod:(NSString*)name {
    
    context = [self managedObjectContext];
    
    NSManagedObject *task = [[Item alloc]initWithContext:context];
    
    [task setValue:name forKey:@"name"];
    
    NSString *itemString = [task valueForKey:@"name"];
    
    [listArray addObject:itemString];
    
    [delegate saveContext];
    
    NSLog(@"Save successful");
    NSLog(@"%@", listArray);
    
}


#pragma mark - Fetch results 

- (void) fetchItems {
    
    context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    listArray = [[result valueForKey:@"name"] mutableCopy];
    
    NSLog(@"Fetch successful");
    NSLog(@"%@", listArray);
    
    [self.tableView reloadData];
}





@end
