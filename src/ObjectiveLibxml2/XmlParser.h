#import <Foundation/Foundation.h>
// Must include libxml2.2.dylib for <libxml/tree.h> to work.
// Steps:
//   1) Add libxml2.dylib to your Frameworks
//   2) Add /usr/include/libxml2/** to your Header Search Paths
#import <libxml/tree.h>

#import "XmlElement.h"


@class XmlParser;

// Protocol for the parser to communicate with its delegate.
@protocol ParserDelegate <NSObject>
// Called by the parser when parsing is finished.
- (void)parserDidEndParsingData:(XmlParser *)parser;
// Called by the parser in the case of an error.
- (void)parser:(XmlParser *)parser didFailWithError:(NSError *)error;
// Called by the parser when a new element is to be added to the item
- (void)parser:(XmlParser *)parser addXmlElement:(XmlElement *)xmlElement;
// Called by the parser when a new item has began being parsed
- (void)parserDidBeginItem:(XmlParser *)parser;
// Called by the parser when the current item has finished being parsed
- (void)parserDidEndItem:(XmlParser *)parser;
@end


/**
 * The class acts as an event based streaming parser, asychronously downloading 
 * an XML file and passing the XML information for each element to the delegate 
 * AS IT DOWNLOADS. A streaming parser is great when memory is paramount as only
 * one downloaded chunk is stored in memory at a time. It extends NSOperation so
 * the class can be managed in an NSOperationQueue. The libxml2 C library is 
 * used for parsing.
 *
 * XmlParser is based off Apple's iPhone sample code project TopSongs.
 */
@interface XmlParser : NSOperation
{
    @private
        // Delegate to call back parsed information
        id <ParserDelegate> delegate_;
        // Reference to the libxml parser context
        xmlParserCtxtPtr context_;
        // Handles asynchronous retrieval of the XML
        NSURLConnection *connection_;
        // Overall state of the parser, used to exit the run loop.
        BOOL done_;
        // Determines if can ignore a given XML element
        BOOL parsingAnItem_;
        //URL to download and parse
        NSURL *url_;
        BOOL storingCharacters_;
        NSMutableData *characterBuffer_;
        // Element name and length to signify new item to parse
        const char *itemDelimiter_;
        NSUInteger itemDelimiterLength_;
        // Holds XML results for each element
        XmlElement *xmlElement_;
}

/**
 * Receives callbacks while parsing the document
 */
@property (nonatomic, assign) id <ParserDelegate> delegate;

/**
 * Item name determines when an item began and when an item ended.
 */
@property (nonatomic, assign) const char* itemDelimiter;

/**
 * URL of the XML file
 */
@property (nonatomic, retain) NSURL *url;

@end
