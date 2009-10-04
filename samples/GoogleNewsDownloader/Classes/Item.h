
@interface Item : NSObject
{
    @private
        NSString *title_;
        NSString *url_;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

@end
