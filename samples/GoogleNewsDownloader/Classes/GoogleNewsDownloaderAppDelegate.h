
@interface GoogleNewsDownloaderAppDelegate : NSObject <UIApplicationDelegate>
{
    @private
        UIWindow *window_;
        UINavigationController *navigationController_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

