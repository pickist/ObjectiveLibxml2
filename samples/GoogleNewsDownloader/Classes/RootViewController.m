#import "RootViewController.h"

#import "RssViewController.h"
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
    [[cell textLabel] setText:category];

    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *category = [[self categories] objectAtIndex:[indexPath row]];
    
    RssViewController *viewController = [[RssViewController alloc] initWithNibName:@"RssView" bundle:nil];
    [viewController downloadAndParseCategory:category];
    [[self navigationController] pushViewController:viewController animated:YES];
    [viewController release];
}

@end
