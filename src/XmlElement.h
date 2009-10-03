#import <Foundation/Foundation.h>


/**
 * A container class for passing XML information of an element, including the 
 * element name, value, and any attributes in the tag.
 */
@interface XmlElement : NSObject
{
    @private
        NSString *name_;
        NSString *value_;
        NSDictionary *attributes_;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSDictionary *attributes;

@end
