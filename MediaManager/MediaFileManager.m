//
//  MediaFileManager.m
//  MediaManager
//
//  Created by Arthur on 5/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MediaFileManager.h"

NSString * const kMusicPathDataKey = @"MusicPathDataKey";
NSString * const kMusicTitleDataKey = @"MusicTitleDataKey";
NSString * const kMusicArtistDataKey = @"MusicArtistDataKey";
NSString * const kMusicAlbumDataKey = @"MusicAlbumDataKey";
NSString * const kMusicYearDataKey = @"MusicYearDataKey";
NSString * const kMusicCommentDataKey = @"MusicCommentDataKey";
NSString * const kMusicTrackDataKey = @"MusicTrackDataKey";
NSString * const kMusicGenreDataKey = @"MusicGenreDataKey";
NSString * const kMusicImageDataKey = @"MusicImageDataKey";
NSString * const kMusicDurationDataKey = @"MusicDurationDataKey";
NSString * const kMusicFileSizeDataKey = @"MusicFileSizeDataKey";

NSString * const kCategoryNameKey = @"CategoryNameKey";
NSString * const kCategoryArrayKey = @"CategoryArrayKey";

NSString * const kGalleryIndexDataKey = @"GalleryIndexDataKey";
NSString * const kGalleryTypeDataKey = @"GalleryTypeDataKey";
NSString * const kGalleryPathDataKey = @"GalleryPathDataKey";
NSString * const kGalleryTitleDataKey = @"GalleryTitleDataKey";
NSString * const kGalleryResolutionDataKey = @"GalleryResolutionDataKey";
NSString * const kGalleryDurationDataKey = @"GalleryDurationDataKey";
NSString * const kGalleryShootTimeDataKey = @"GalleryShootTimeDataKey";
NSString * const kGalleryImageDataKey = @"GalleryImageDataKey";





static MediaFileManager* _sharedInstance = nil;

@implementation MediaFileManager
@synthesize delegate,pictureType,movieType,songArray,albumArray,genersArray,artistArray,galleryArray;
@synthesize songArrayController;
+ (MediaFileManager*)shareMediaFileManager
{	
	@synchronized([MediaFileManager class])
	{
		if (!_sharedInstance)
			_sharedInstance = [[[self class ]alloc] init];
	}
	return _sharedInstance;
}

+ (id)alloc
{
	@synchronized([MediaFileManager class])
	{
		_sharedInstance = [super alloc];
	}
	return _sharedInstance;
}

+ (BOOL)sharedInstanceExists
{
	return (nil != _sharedInstance);
}

-(id)init {

	if(self = [super init])
	{
		_sharedInstance.songArray = [[NSMutableArray alloc] init];
		_sharedInstance.albumArray = [[NSMutableArray alloc] init];
		_sharedInstance.artistArray = [[NSMutableArray alloc]init];
		_sharedInstance.genersArray = [[NSMutableArray alloc]init];
		
		_sharedInstance.galleryArray = [[NSMutableArray alloc]init];
		_sharedInstance.pictureType = [NSArray arrayWithObjects:@"jpg",@"jpeg", @"bmp", @"png",@"tif",@"tiff",@"gif", nil];
		_sharedInstance.movieType = [NSArray arrayWithObjects:@"mp4", @"3gp", @"avi",@"mov",@"mkv",@"rmvb",@"mpg", nil];
		
		
		songArrayController = [[NSArrayController alloc]init];
		
		
		
		
		return _sharedInstance;
	}
	return self;
}

- (void)clearAll
{
	[songArray removeAllObjects];
	[albumArray removeAllObjects];
	[genersArray removeAllObjects];
	[artistArray removeAllObjects];
}

- (void)dealloc
{
	[self clearAll];
	[super dealloc];
}

#pragma mark - music file

- (NSInteger)serachSongForPath:(NSString *)path contextInfo:(id)context
{
	NSEntityDescription *entity = [[[self managedObjectModel] entitiesByName] objectForKey:@"SongItem"];
	NSError *error;
	NSFileManager *localFileManager=[[NSFileManager alloc] init];
	NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:path];
	NSString *file;
	NSInteger index = 0;
	while (file = [dirEnum nextObject]) 
	{
		if ([[file pathExtension] isEqualToString: @"mp3"]) 
		{
			AlbumWrapper *album = [[AlbumWrapper alloc] initWithMPEGFile:[path stringByAppendingPathComponent:file]];
			if(album)
			{
				
				NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithObjectsAndKeys:
											album.path,kMusicPathDataKey,
											album.title,kMusicTitleDataKey,
											album.artist,kMusicArtistDataKey,
											album.album,kMusicAlbumDataKey,
											album.year,kMusicYearDataKey,
											album.comment,kMusicCommentDataKey,
											album.track,kMusicTrackDataKey,
											album.genre,kMusicGenreDataKey,
											album.image,kMusicImageDataKey,
											[[localFileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil] valueForKey:NSFileSize],kMusicFileSizeDataKey,
											[NSNumber numberWithInt:album.duration],kMusicDurationDataKey,
											nil];
				
				[songArray addObject:obj];
				NSManagedObject *newObject = [[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:[self managedObjectContext]];
				if([album.title length]>0)
					[newObject setValue:album.title forKey:@"MusicTitle"];
				if([album.artist length]>0)
				[newObject setValue:album.artist forKey:@"MusicArtist"];
				if([album.album length]>0)
				[newObject setValue:album.album forKey:@"MusicAlbum"];
				if([album.path length]>0)
				[newObject setValue:album.path forKey:@"MusicPath"];
				if([album.year length]>0)
				[newObject setValue:album.year forKey:@"MusicYear"];
				if([album.comment length]>0)
				[newObject setValue:album.comment forKey:@"MusicComment"];
				if([album.track length]>0)
				[newObject setValue:album.track forKey:@"MusicTrack"];
				if([album.genre length]>0)
				[newObject setValue:album.genre forKey:@"MusicGenre"];
				[newObject setValue:[NSNumber numberWithInt:album.duration] forKey:@"MusicDuration"];
				NSString *filesize = [[localFileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil] valueForKey:NSFileSize];
				NSNumber *size = [NSNumber numberWithLongLong:[filesize longLongValue]];
				[newObject setValue:size forKey:@"MusicSize"];
				if(album.image)
				{
					[newObject setValue:album.image forKey:@"MusicImage"];
				}
				else
				{
					NSLog(@"%@ image is null",album.title);
				}

				if (![managedObjectContext save: &error]) 
				{
					NSLog(@"import songitem field!");
				}

				[album release];
			}
		}
		if(self.delegate && [self.delegate respondsToSelector:@selector(sreachProgress:filename:contextInfo:)])
		{
			[delegate sreachProgress:++index filename:file contextInfo:context];
		}
	}
	[localFileManager release];
	return [songArray count];
}

- (NSInteger)startSerachMusic:(NSString*)path contextInfo:(id)context
{
	NSInteger fileCount = 0;
	NSFileManager *localFileManager=[[NSFileManager alloc] init];
	
	BOOL isDir, valid = [localFileManager fileExistsAtPath:path isDirectory:&isDir];
	if (valid && isDir) 
	{
        NSArray *array = [localFileManager subpathsOfDirectoryAtPath:path error:NULL];
		fileCount = [array count];
	}
	dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(q, ^{ 
		[self serachSongForPath:path contextInfo:context];
	}); 
	return fileCount;
}

- (NSUInteger)musicCount
{
	NSFetchRequest *chefFetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[chefFetchRequest setEntity:[NSEntityDescription entityForName:@"SongItem" inManagedObjectContext:[self managedObjectContext]]];
	NSError *err;
    NSUInteger count = [managedObjectContext countForFetchRequest: chefFetchRequest error: &err];
	return count;
}

- (NSArray*)musicArrayInLibrary
{
	NSFetchRequest *chefFetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[chefFetchRequest setEntity:[NSEntityDescription entityForName:@"SongItem" inManagedObjectContext:[self managedObjectContext]]];
	NSError *err;
    NSArray *chefs = [[managedObjectContext executeFetchRequest: chefFetchRequest error: &err]retain];
	return chefs;
}

- (SongCategory*)createCategoryByName:(NSString *)name category:(NSMutableArray *)array
{	
	SongCategory *sc = [[SongCategory alloc]initWithName:name];
	[array addObject:sc];
	[sc release];
	return sc;
}

- (SongCategory*)isExistCategory:(NSMutableArray*)category song:(NSString *)song
{	
	for (SongCategory * obj in category)
	{
		if([obj.name isEqualToString:song])
		{
			return obj;
		}
	}
	return nil;
}

- (void)insertCategory:(SongCategory*)category song:(NSMutableDictionary*)song
{	
	[category.array addObject:song];
}

- (void)serachMusic:(NSArray *)paths
{
	//清除所有
	[self clearAll];
	
	//扫出所有指定目录下的文件
	for(id path in paths)
	{
		NSInteger count = [self serachSongForPath:path contextInfo:nil];
		NSLog(@"path[%@] music count = %ld",path,count);
	}
	
	SongCategory *unknownAlbum = [[SongCategory alloc]initWithName:@"Unknown Album"];
	[albumArray addObject:unknownAlbum];
	
	SongCategory *unknownGeners = [[SongCategory alloc]initWithName:@"Unknown Geners"];
	[genersArray addObject:unknownGeners];
	
	SongCategory *unknownArtist = [[SongCategory alloc]initWithName:@"Unknown Artist"];
	[artistArray addObject:unknownArtist];
	
	//分类
	for(id song in songArray)
	{
		NSString *album = [song valueForKey:kMusicAlbumDataKey];
		if([album length]>0)
		{
			SongCategory *dict = [self isExistCategory:albumArray song:album];
			if(nil != dict)
			{
				[self insertCategory:dict song:song];
			}
			else 
			{
				SongCategory *categoryDict = [self createCategoryByName:album category:albumArray];
				[self insertCategory:categoryDict song:song];
			}
		}
		else 
		{
			[self insertCategory:unknownAlbum song:song];
		}
		
		NSString *geners = [song valueForKey:kMusicGenreDataKey];
		if([geners length]>0)
		{
			SongCategory *dict = [self isExistCategory:genersArray song:geners];
			if(nil != dict)
			{
				[self insertCategory:dict song:song];
			}
			else 
			{
				SongCategory *categoryDict = [self createCategoryByName:geners category:genersArray];
				[self insertCategory:categoryDict song:song];
			}
		}
		else 
		{
			[self insertCategory:unknownGeners song:song];
		}
		
		NSString *artist = [song valueForKey:kMusicArtistDataKey];
		if([artist length]>0)
		{
			SongCategory *dict = [self isExistCategory:artistArray song:artist];
			if(nil != dict)
			{
				[self insertCategory:dict song:song];
			}
			else 
			{
				SongCategory *categoryDict = [self createCategoryByName:artist category:artistArray];
				[self insertCategory:categoryDict song:song];
			}
		}
		else 
		{
			[self insertCategory:unknownArtist song:song];
		}
	}
	
	/*排序方法
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name"
												  ascending:YES] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	NSArray *sortedArray;
	sortedArray = [artistArray sortedArrayUsingDescriptors:sortDescriptors];
	
	
	for(id artistcategory in sortedArray)
	{
		SongCategory *dict = artistcategory;
		NSLog(@"artist category = [%@]==============================================",dict.name);
		for(id obj in dict.array)
		{
			//NSLog(@"song %@",[obj valueForKey:kMusicTitleDataKey]);
		}
		NSLog(@"\r\n");
	}*/
}

#pragma mark -- Gallery File

- (BOOL)isAvailableForPicture:(NSString*)path
{
	NSEnumerator *enumerator = [pictureType objectEnumerator];
	id object;
	while ((object = [enumerator nextObject])) 
	{
		if([[path pathExtension] caseInsensitiveCompare:object] == NSOrderedSame)
		{
			return YES;
		}
	}
	return NO;
}

- (BOOL)isAvailableForMoive:(NSString*)path
{
	NSEnumerator *enumerator = [movieType objectEnumerator];
	id object;
	while ((object = [enumerator nextObject])) 
	{
		if([[path pathExtension] caseInsensitiveCompare:object] == NSOrderedSame)
		{
			return YES;
		}
	}
	return NO;
}

- (NSInteger)serachGalleryForPath:(NSString *)path
{
	NSFileManager *localFileManager=[NSFileManager defaultManager];
	NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:path];
	unsigned int count = 0;
	NSString *file;
	while (file = [dirEnum nextObject]) 
	{
		if([self isAvailableForPicture:[path stringByAppendingPathComponent:file]])
		{
			NSImage * img = [[NSImage alloc ]initWithContentsOfFile:[path stringByAppendingPathComponent:file]];
			if(img)
			{
				NSDate *createTime = [[localFileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil] valueForKey:NSFileCreationDate];
				NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithObjectsAndKeys:
											[NSNumber numberWithUnsignedInt:count],kGalleryIndexDataKey,
											[NSString stringWithFormat:@"picture"],kGalleryTypeDataKey,
											[path stringByAppendingPathComponent:file],kGalleryPathDataKey,
											[file lastPathComponent],kGalleryTitleDataKey,
											[NSString stringWithString:NSStringFromSize(img.size)],kGalleryResolutionDataKey,
											[NSNumber numberWithInt:0],kGalleryDurationDataKey,
											createTime,kGalleryShootTimeDataKey,
											img,kGalleryImageDataKey,
											nil];
				[galleryArray addObject:obj];
				count++;
			}
		}
		if([self isAvailableForMoive:[path stringByAppendingPathComponent:file]])
		{
			NSImage *img = [NSImage imageNamed:@"defaultvedio"];
			if(img)
			{
				NSDate *createTime = [[localFileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil] valueForKey:NSFileCreationDate];
				NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithObjectsAndKeys:
											[NSNumber numberWithUnsignedInt:count],kGalleryIndexDataKey,
											[NSString stringWithFormat:@"video"],kGalleryTypeDataKey,
											[path stringByAppendingPathComponent:file],kGalleryPathDataKey,
											[file lastPathComponent],kGalleryTitleDataKey,
											[NSString stringWithString:NSStringFromSize(img.size)],kGalleryResolutionDataKey,
											[NSNumber numberWithInt:0],kGalleryDurationDataKey,
											createTime,kGalleryShootTimeDataKey,
											img,kGalleryImageDataKey,
											nil];
				[galleryArray addObject:obj];
				count++;
			}
		}
	}
	return [galleryArray count];
}

- (void)serachGallery:(NSArray *)paths
{
	[galleryArray removeAllObjects];
	for(id path in paths)
	{
		NSInteger count = [self serachGalleryForPath:path];
		NSLog(@"path[%@] gallery count = %ld",path,count);
	}
}

#pragma mark -
#pragma mark Core Data

- (NSString *)applicationSupportFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"MediaManager"];
}


- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    if (persistentStoreCoordinator) {
        return persistentStoreCoordinator;
    }
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *applicationSupportFolder = [self applicationSupportFolder];
    if (![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL]) 
	{
		[fileManager createDirectoryAtPath:applicationSupportFolder withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSURL *url = [NSURL fileURLWithPath:[applicationSupportFolder 
										 stringByAppendingPathComponent:@"Music.db"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] 
								  initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil 
															URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
    return persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext) {
        return managedObjectContext;
    }
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator)
	{
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

@end
