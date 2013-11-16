//
//  RecipeTableViewController.m
//  DorothyParker
//
//  Created by Janice Garingo on 10/15/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeDetailViewController.h"

@interface RecipeTableViewController ()

@property (nonatomic) NSString *imageBaseURL;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation RecipeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self styleElements];
    [self requestObjects];
}


- (void)styleElements
{
    self.view.backgroundColor = kUIColorCream;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor greenColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"novellabold" size:26.0], NSFontAttributeName, nil]];
}


- (void)requestObjects
{
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/plain"];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"recipes.json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"success");
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@" , error);
    }];
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if(!_fetchedResultsController)
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Recipe class])];
        
        fetchRequest.sortDescriptors = @[];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        NSError *error;
        
        self.fetchedResultsController.delegate = self;
        
        [self.fetchedResultsController performFetch:&error];
        
        NSAssert(!error, @"Error performing fetch request: ", error);
        
    }
    
    return _fetchedResultsController;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"recipeDetailSegue"])
    {
        RecipeDetailViewController *recipeDetailViewController = [segue destinationViewController];
        NSInteger currentRow = [self.tableView indexPathForSelectedRow].row;
        
        Recipe *selectedRecipe = [[self.fetchedResultsController fetchedObjects] objectAtIndex:currentRow];
        
        recipeDetailViewController.recipedescription = selectedRecipe.recipedescription;
        recipeDetailViewController.ingredients = selectedRecipe.ingredients; 
        recipeDetailViewController.thumbnail = [NSString stringWithFormat:@"%@%@", kBaseImageURL, selectedRecipe.thumbnail];
        recipeDetailViewController.thumbnailRetina = [NSString stringWithFormat:@"%@%@", kBaseImageURL, selectedRecipe.thumbnailretina];
        
    }
}


# pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


# pragma mark - UITableView delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Recipe *recipe = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *thumbnailURL = [NSString stringWithFormat:@"%@%@", kBaseImageURL, recipe.thumbnail];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    [recipeImageView setImageWithURL:[NSURL URLWithString:thumbnailURL]];
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:200];
    textLabel.text = recipe.title;
    textLabel.font = [UIFont fontWithName:@"Palatino" size:16.0];
    
    cell.backgroundColor = kUIColorCream;
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
