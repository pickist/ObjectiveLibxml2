#import <UIKit/UIKit.h>
#import <ObjectiveLibxml2/ObjectiveLibxml2.h>
#import "Item.h"

@interface RssViewController : UITableViewController <XmlParserDelegate>
{
    @private
        // Queues parsing thread
        NSOperationQueue *operationQueue_;
        // Determines if view controller is in the middle of a parsing operation
        BOOL isParsing_;
        // Category being parsed
        NSString *category_;
        // Parsed results, used for table data source
        NSMutableArray *results_;
        // The item being parsed
        Item *item_;
}

@property (nonatomic, copy) NSString *category;

- (void)downloadAndParseCategory:(NSString *)category;

@end
