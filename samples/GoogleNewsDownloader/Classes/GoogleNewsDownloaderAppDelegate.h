
@interface GoogleNewsDownloaderAppDelegate : NSObject <UIApplicationDelegate>
{    
    UIWindow *window_;
    UINavigationController *navigationController_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

