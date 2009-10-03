#import "GoogleNewsDownloaderAppDelegate.h"

#import "RootViewController.h"


@implementation GoogleNewsDownloaderAppDelegate

@synthesize window = window_;
@synthesize navigationController = navigationController_;


#pragma mark -
#pragma mark GoogleNewsDownloaderAppDelegate

- (void)dealloc
{
	[navigationController_ release];
	[window_ release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIApplicationDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{	
	[[self window] addSubview:[[self navigationController] view]];
    [[self window] makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end

