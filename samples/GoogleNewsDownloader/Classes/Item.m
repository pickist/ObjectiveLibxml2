#import "Item.h"


@implementation Item

@synthesize title = title_;
@synthesize url = url_;

- (void)dealloc
{
    [title_ release];
    [url_ release];
    
    [super dealloc];
}

@end
