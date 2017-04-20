#import <Foundation/Foundation.h>

@interface AlbumWrapper : NSObject {

}
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy)NSString *year;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy)NSString *track;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, retain) NSData *image;
@property (nonatomic, assign)int duration;

- (id)initWithMPEGFile:(NSString *)filePath;
@end
