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

@property (nonatomic, strong) NSMutableArray *recipeArray;
@property (nonatomic, strong) NSMutableArray *ingredientsArray;
@property (nonatomic, strong) NSMutableArray *descriptionArray;
@property (nonatomic, strong) NSMutableArray *thumbnailArray;
@property (nonatomic, strong) NSMutableArray *thumbnailRetinaArray;
@property (nonatomic, strong) NSString *imageBaseURL;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation RecipeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.recipeArray = [NSMutableArray new];
    self.descriptionArray = [NSMutableArray new];
    self.ingredientsArray = [NSMutableArray new];
    self.thumbnailArray = [NSMutableArray new];
    self.thumbnailRetinaArray = [NSMutableArray new];

    // [self loadJson];
    
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
        
        
        // NSLog(@" managed object context : %@ ", [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext );
        
        fetchRequest.sortDescriptors = @[];
        
        // NSLog(@" fetchRequest : %@ " , fetchRequest );

        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        
        NSError *error;
        
        self.fetchedResultsController.delegate = self;
        
        [self.fetchedResultsController performFetch:&error];
        
        NSLog(@"fetched objects : %@", [self.fetchedResultsController fetchedObjects]);
        
        NSAssert(!error, @"Error performing fetch request: ", error);
        
    }
    
    return _fetchedResultsController;
}
    
- (void)loadJson
{
    NSString *baseURLString = kBaseURL;

    NSString *recipeUrl = [NSString stringWithFormat:@"%@recipes.json", baseURLString];
    NSURL *url = [NSURL URLWithString:recipeUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *dictionary = (NSDictionary *) JSON;
        
        self.imageBaseURL = [dictionary objectForKey:@"imageBaseURL"];
        
        NSArray *recipes = [dictionary objectForKey:@"recipes"];
        [recipes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            
            NSString *title = [obj objectForKey:@"title"];
            [self.recipeArray addObject:title];
            
            NSString *ingredients = [obj objectForKey:@"ingredients"];
            [self.ingredientsArray addObject:ingredients];
            
            NSString *description = [obj objectForKey:@"description"];
            [self.descriptionArray addObject:description];
            
            NSString *thumbnail = [NSString stringWithFormat:@"%@%@", self.imageBaseURL, [obj objectForKey:@"thumbnail"]];
            [self.thumbnailArray addObject:thumbnail];
            
            NSString *thumbnailRetina = [NSString stringWithFormat:@"%@%@", self.imageBaseURL, [obj objectForKey:@"thumbnail-retina"]];
            [self.thumbnailRetinaArray addObject:thumbnailRetina];
            
        }];
        
        NSLog(@"recipeArray : %@" , self.recipeArray );
        NSLog(@"ingredientsArray : %@" , self.ingredientsArray );
        NSLog(@"thumbnailArray: %@" , self.thumbnailArray  );


        [self.tableView reloadData];
    
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error : %@", [error localizedDescription]);
    }];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [operation start];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"recipeDetailSegue"])
    {
        RecipeDetailViewController *recipeDetailViewController = [segue destinationViewController];
        NSInteger currentRow = [self.tableView indexPathForSelectedRow].row;
        
        recipeDetailViewController.ingredients = [self.ingredientsArray objectAtIndex:currentRow];
        recipeDetailViewController.description = [self.descriptionArray objectAtIndex:currentRow];
        recipeDetailViewController.thumbnail = [self.thumbnailArray objectAtIndex:currentRow];
        recipeDetailViewController.thumbnailRetina = [self.thumbnailRetinaArray objectAtIndex:currentRow];
    
    }
}


# pragma mark - UITableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"recipeDetailSegue" sender:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSLog(@" [sectionInfo numberOfObjects] : %i ", [sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
    
    // return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    Recipe *recipe = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // cell.textLabel.text = [self.recipeArray objectAtIndex:indexPath.row];
    
    NSLog(@"recipe.title : %@ " , recipe.title );
  
     
    
    cell.textLabel.text = recipe.title;
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
