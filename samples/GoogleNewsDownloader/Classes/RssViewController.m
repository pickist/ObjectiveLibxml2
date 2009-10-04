#import "RssViewController.h"

#import "Constants.h"


@interface RssViewController ()
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) NSOperationQueue *operationQueue;
@property (nonatomic, assign) BOOL isParsing;
- (NSURL *)urlForCategory:(NSString *)category;
@end


@implementation RssViewController

@synthesize results = results_;
@synthesize item = item_;
@synthesize operationQueue = operationQueue_;
@synthesize isParsing = isParsing_;
@synthesize category = category_;


#pragma mark -
#pragma mark RssResults

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
    if ((self = [super initWithNibName:nibName bundle:nibBundle]))
    {
        NSMutableArray *results = [[NSMutableArray alloc] init];
        [self setResults:results];
        [results release];
        
        [self setIsParsing:NO];
        [self setCategory:@""];
    }
    
    return self;
}

- (void)dealloc
{
    [results_ release];
    [item_ release];
    [operationQueue_ release];
    [category_ release];
    
    [super dealloc];
}

- (void)downloadAndParseCategory:(NSString *)category
{
    [self setCategory:category];
    
    [self setIsParsing:YES];
    // TODO: Activate network indicator
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [self setOperationQueue:operationQueue];
    [operationQueue release];
    
    NSURL *url = [self urlForCategory:category];
    
    // Create the parser, set its delegate, and start it.
    XmlParser *parser = [[XmlParser alloc] init];
    [parser setDelegate:self];
    [parser setUrl:url];
    [parser setItemDelimiter:kItemDelimiter];
    
    // Add the Parser to an operation queue for background processing (works on
    // a separate thread)
    [[self operationQueue] addOperation:parser];
    [parser release];
}

- (NSURL *)urlForCategory:(NSString *)category
{
    // Maps the category to the URL parameter
    NSString *categoryParam;
    if ([kCategoryWorld isEqual:category])
    {
        categoryParam = kCategoryWorldParam;
    }
    else if ([kCategoryNational isEqual:category])
    {
        categoryParam = kCategoryNationalParam;
    }
    else if ([kCategoryBusiness isEqual:category])
    {
        categoryParam = kCategoryBusinessParam;
    }
    else if ([kCategoryTech isEqual:category])
    {
        categoryParam = kCategoryTechParam;
    }
    else if ([kCategoryEntertainment isEqual:category])
    {
        categoryParam = kCategoryEntertainmentParam;
    }
    else if ([kCategorySports isEqual:category])
    {
        categoryParam = kCategorySportsParam;
    }
    else if ([kCategoryHealth isEqual:category])
    {
        categoryParam = kCategoryHealthParam;
    }
    
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:kGoogleNewsBaseUrl];
    [mutableUrl appendFormat:@"&topic=%@", categoryParam];

    NSURL *url = [[[NSURL alloc] initWithString:mutableUrl] autorelease];
    [mutableUrl release];
    
    return url;
}

#pragma mark -
#pragma mark ParserDelegate

- (void)parserDidEndParsingData:(XmlParser *)parser
{
    [self setIsParsing:NO];
    
    [[self tableView] reloadData];    
}

- (void)parser:(XmlParser *)parser addXmlElement:(XmlElement *)xmlElement
{
    NSString *elementName = [xmlElement name];
    NSString *elementValue = [xmlElement value];
    
    if (elementValue == nil || [elementValue length] == 0)
    {
        return;
    }
    
    // Only concerned with certain elements
    if ([elementName isEqual:@"title"])
    {
        [[self item] setTitle:elementValue];
    }
    else if ([elementName isEqual:@"link"])
    {
        [[self item] setUrl:elementValue];
    }
}

- (void)parserDidBeginItem:(XmlParser *)parser
{
    Item *item = [[Item alloc] init];
    [self setItem:item];
    [item release];
}

- (void)parserDidEndItem:(XmlParser *)parser
{
    [[self results] addObject:[self item]];
    
    // Normally, you would not want to reload after each new item as the
    // operation can be expensive. This was added to show how the parser is
    // returning results as it downloads.
    [[self tableView] reloadData];
}

- (void)parser:(XmlParser *)parser didFailWithError:(NSError *)error
{
    [self setIsParsing:NO];
    
    // TODO: Display alert
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:[self category]];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self results] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RESULT_CELL_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier]
                autorelease];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    Item *item = [[self results] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[item title]];
	
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Loads the item's link in the browser
    Item *item = [[self results] objectAtIndex:[indexPath row]];
    NSURL *url = [[NSURL alloc] initWithString:[item url]];
    [[UIApplication sharedApplication] openURL:url];
    [url release];
}

@end
