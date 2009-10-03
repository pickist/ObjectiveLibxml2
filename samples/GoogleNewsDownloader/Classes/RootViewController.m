#import "RootViewController.h"

#import "Constants.h"

@implementation RootViewController

@synthesize categories = categories_;


#pragma mark -
#pragma mark RootViewController

- (void)dealloc
{
    [categories_ release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sets Google News categories for the table data source
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    [categories addObject:kCategoryWorld];
    [categories addObject:kCategoryNational];
    [categories addObject:kCategoryBusiness];
    [categories addObject:kCategoryTech];
    [categories addObject:kCategorySports];
    [categories addObject:kCategoryEntertainment];
    [categories addObject:kCategoryHealth];
    
    [self setCategories:categories];
    
    [categories release];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self categories] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CategoryCellIdentifier = @"CATEGORY_CELL_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier] autorelease];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    NSString *category = [[self categories] objectAtIndex:[indexPath row]];
    NSString *displayName;
    
    // Maps the category abbreviation to the display name
    // For example b -> Business
    if ([kCategoryWorld isEqual:category])
    {
        displayName = kCategoryWorldName;
    }
    else if ([kCategoryNational isEqual:category])
    {
        displayName = kCategoryNationalName;
    }
    else if ([kCategoryBusiness isEqual:category])
    {
        displayName = kCategoryBusinessName;
    }
    else if ([kCategoryTech isEqual:category])
    {
        displayName = kCategoryTechName;
    }
    else if ([kCategoryEntertainment isEqual:category])
    {
        displayName = kCategoryEntertainmentName;
    }
    else if ([kCategorySports isEqual:category])
    {
        displayName = kCategorySportsName;
    }
    else if ([kCategoryHealth isEqual:category])
    {
        displayName = kCategoryHealthName;
    }
    
    [[cell textLabel] setText:displayName];

    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end

