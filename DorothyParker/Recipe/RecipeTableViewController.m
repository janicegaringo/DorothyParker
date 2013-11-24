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
@property (nonatomic) BOOL firstRun;

@end

@implementation RecipeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self styleElements];
    
    NSString *isLoaded = [[NSUserDefaults standardUserDefaults] stringForKey:@"isLoaded"];
    if([isLoaded isEqualToString:@"YES"]) {
       // don't do anything if it's loaded
    }
    else {
        [self requestObjects];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)styleElements
{
    self.view.backgroundColor = kUIColorLtGrey;
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kUIColorMedGrey;
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                kNovellaFont, NSFontAttributeName,
                [UIColor whiteColor],NSForegroundColorAttributeName,
                nil]];
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
                
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:@"title" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        NSError *error;
        
        self.fetchedResultsController.delegate = self;

        if(self.fetchedResultsController.fetchedObjects.count == 0) {
        
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isLoaded"];
            [self.fetchedResultsController performFetch:&error];
        }

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
        recipeDetailViewController.glassware = selectedRecipe.glassware;
        recipeDetailViewController.ingredients = selectedRecipe.ingredients;
        recipeDetailViewController.recipetitle = selectedRecipe.title;
        recipeDetailViewController.thumbnail = [NSString stringWithFormat:@"%@%@", kBaseImageURL, selectedRecipe.thumbnail];
        recipeDetailViewController.thumbnailRetina = [NSString stringWithFormat:@"%@%@", kBaseImageURL, selectedRecipe.thumbnailretina];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @""
                                       style: UIBarButtonItemStylePlain
                                       target: nil action: nil];
        [self.navigationItem setBackBarButtonItem: backButton];
        
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
    textLabel.textColor = [UIColor darkGrayColor];
    textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0];
    textLabel.numberOfLines = 2;
    
    UILabel *glasswareLabel = (UILabel *)[cell viewWithTag:300];
    glasswareLabel.text = recipe.glassware;
    glasswareLabel.textColor = kUIColorMedGrey;
    glasswareLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0];
    glasswareLabel.numberOfLines = 1;

    cell.backgroundColor = kUIColorLtGrey;
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



@end
