

//#include <tbytevector.h>
//
//#include <mpegfile.h>
//
//#include <id3v2tag.h>
//#include <id3v2frame.h>
//#include <id3v2header.h>
//#include <AttachedPictureFrame.h>
//#include <id3v1tag.h>
//
//#include <apetag.h>

#include "tag_c.h"
#import "AlbumWrapper.h"
#import "FFMpegWrapper.h"

//using namespace TagLib;

#import <AVFoundation/AVFoundation.h>


@implementation AlbumWrapper

@synthesize path,title, artist, album,year,comment,track,genre,image,duration;

- (id)initWithFileAtPath:(NSString *)filePath {
	if (self = [super init])
    {
/*
		// Initialisation as per the TagLib example C code
		TagLib_File *file;
		TagLib_Tag *tag;

		// We want UTF8 strings out of TagLib
		taglib_set_strings_unicode(TRUE);
		
		// Convert the NSString filePath into a native c string
		file = taglib_file_new([filePath cStringUsingEncoding:NSUTF8StringEncoding]);

		if (file != NULL) {
			tag = taglib_file_tag(file);
			
			if (tag != NULL) {
				// If we have a valid 'title' tag, assign it to our 'title' ivar
				if (taglib_tag_title(tag) != NULL &&
					strlen(taglib_tag_title(tag)) > 0) {
					self.title = [NSString stringWithCString:taglib_tag_title(tag)
                                                               encoding:NSUTF8StringEncoding];
				}

				if (taglib_tag_artist(tag) != NULL &&
					strlen(taglib_tag_artist(tag)) > 0) {
					self.artist = [NSString stringWithCString:taglib_tag_artist(tag)
                                                                encoding:NSUTF8StringEncoding];
				}

				if (taglib_tag_album(tag) != NULL &&
					strlen(taglib_tag_album(tag)) > 0) {
					self.album = [NSString stringWithCString:taglib_tag_album(tag)
                                                               encoding:NSUTF8StringEncoding];
				}
			}

			// Free up the allocated memory from TagLib
			taglib_tag_free_strings();
			taglib_file_free(file);
	
		}*/
	}

	return self;
}

- (id)initWithMPEGFile:(NSString *)filePath
{
    if(self = [super init])
    {
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        AVURLAsset *avURLAsset = [AVURLAsset URLAssetWithURL:fileUrl options:nil];
        NSString *mp3FilePath = [[[avURLAsset URL]absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.title = [mp3FilePath lastPathComponent];
        self.duration = (NSUInteger)CMTimeGetSeconds(avURLAsset.duration);
        self.path = filePath;
        for (NSString *format in [avURLAsset availableMetadataFormats])
        {
            NSLog(@"-------format:%@",format);
            for (AVMetadataItem *metadataItem in [avURLAsset metadataForFormat:format])
            {
                //NSLog(@"commonKey:%@ value:%@",metadataItem.commonKey,metadataItem.value);
                if ([metadataItem.commonKey isEqualToString:@"artwork"])
                {
                    //取出封面artwork，从data转成image显示
                    NSData *data = (NSData *)[(NSDictionary*)metadataItem.value objectForKey:@"data"];
                    //NSImage *img = [[NSImage alloc ]initWithData:data];
                    self.image = data;
                    //[img release];
                    [data release];
                }
                if([metadataItem.commonKey isEqualToString:@"title"])
                {
                    //[textFieldTitle setStringValue:(NSString*)metadataItem.value];
                    self.title = (NSString*)metadataItem.value;
                }
                if([metadataItem.commonKey isEqualToString:@"albumName"])
                {
                    //[textFieldAlbum setStringValue:(NSString*)metadataItem.value];
                    self.album = (NSString*)metadataItem.value;
                }
                if([metadataItem.commonKey isEqualToString:@"artist"])
                {
                    //[textFieldArtist setStringValue:(NSString*)metadataItem.value];
                    self.artist = (NSString*)metadataItem.value;
                }
            }
            
        }

        
    }
    /*
    
	if (self = [super init]) 
	{
		MPEG::File f([filePath cStringUsingEncoding:NSUTF8StringEncoding]);
		ID3v2::Tag *id3v2tag = f.ID3v2Tag();
		BOOL bFind = FALSE;
		if(id3v2tag) 
		{
			ID3v2::FrameList::ConstIterator it = id3v2tag->frameList().begin();
			for(; it != id3v2tag->frameList().end(); it++)
			{
				//cout << (*it)->frameID() << " - \"" << (*it)->toString() << "\"" << endl;
				if((*it)->frameID() == "APIC")
				{
					ID3v2::AttachedPictureFrame *pic = (ID3v2::AttachedPictureFrame *)(*it);
					ByteVector v = pic->picture();
					image = [[NSData alloc] initWithBytes:v.data() length:v.size()];
					//image = [[NSImage alloc]initWithData:data];
					//[data release];
					bFind = YES;
				}
			}
		}
		
		if(!bFind)
		{
			//image = [NSImage imageNamed:@"icon_music_thumbnail"];
			
		}
		
		ID3v1::Tag *id3v1tag = f.ID3v1Tag();
		if(id3v1tag) 
		{
			const char *strtitle = id3v1tag->title().toCString();
			if(!strtitle || strlen(strtitle)==0)
			{
				self.title = [[filePath lastPathComponent] stringByDeletingPathExtension];
			}
			else 
			{
				self.title = [NSString stringWithCString:id3v1tag->title().toCString() encoding:NSUTF8StringEncoding];
				if(!self.title)
					self.title = [[filePath lastPathComponent] stringByDeletingPathExtension];
			}

			self.artist = [NSString stringWithCString:id3v1tag->artist().toCString() encoding:NSUTF8StringEncoding];
			if([self.artist length] == 0)
				self.artist = @"";

			self.album = [NSString stringWithCString:id3v1tag->album().toCString() encoding:NSUTF8StringEncoding];
			if([self.album length] == 0)
				self.album = @"";
			
			self.year = [NSString stringWithFormat:@"%d",id3v1tag->year()];
			if([self.year length] == 0)
				self.year = @"";
			
			self.comment = [NSString stringWithCString:id3v1tag->comment().toCString() encoding:NSUTF8StringEncoding];
			if([self.comment length] == 0)
				self.comment = @"";
			
			self.track = [NSString stringWithFormat:@"%d",id3v1tag->track()];
			if([self.track length] == 0)
				self.track = @"";
			
			self.genre = [NSString stringWithCString:id3v1tag->genre().toCString() encoding:NSUTF8StringEncoding];
			if([self.genre length] == 0)
				self.genre = @"";
		}
		
		self.path = filePath;

		FFMpegWrapper *ff = [[FFMpegWrapper alloc] initWithPath:filePath];
		self.duration = ff.duration;
		[ff release];
	}*/
	return self;
}

@end
