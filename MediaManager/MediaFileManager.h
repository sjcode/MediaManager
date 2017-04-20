//
//  MediaFileManager.h
//  MediaManager
//
//  Created by Arthur on 5/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AlbumView.h"
#import "AlbumListView.h"
#import "AlbumItem.h"
#import "AlbumWrapper.h"
#import "SongCategory.h"

extern NSString * const kMusicPathDataKey;
extern NSString * const kMusicTitleDataKey;
extern NSString * const kMusicArtistDataKey;
extern NSString * const kMusicAlbumDataKey;
extern NSString * const kMusicYearDataKey;
extern NSString * const kMusicCommentDataKey;
extern NSString * const kMusicTrackDataKey;
extern NSString * const kMusicGenreDataKey;
extern NSString * const kMusicImageDataKey;
extern NSString * const kMusicDurationDataKey;
extern NSString * const kMusicFileSizeDataKey;

extern NSString * const kCategoryNameKey;
extern NSString * const kCategoryArrayKey;

extern NSString * const kGalleryIndexDataKey;
extern NSString * const kGalleryTypeDataKey;
extern NSString * const kGalleryPathDataKey;
extern NSString * const kGalleryTitleDataKey;
extern NSString * const kGalleryResolutionDataKey;
extern NSString * const kGalleryDurationDataKey;
extern NSString * const kGalleryShootTimeDataKey;
extern NSString * const kGalleryImageDataKey;

@protocol ImportProgressDelegate;

@interface MediaFileManager : NSObject 
{
	NSMutableArray *songArray;
	NSMutableArray *albumArray;
	NSMutableArray *genersArray;
	NSMutableArray *artistArray;
	
	NSMutableArray *galleryArray;
	
	NSArray *pictureType;
	NSArray *movieType;
	
	id<ImportProgressDelegate> delegate;
	
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

+ (MediaFileManager*)shareMediaFileManager;

- (void)serachMusic:(NSArray *)paths;
- (void)serachGallery:(NSArray *)paths;

- (NSInteger)startSerachMusic:(NSString*)path contextInfo:(id)context;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (NSUInteger)musicCount;
- (NSArray*)musicArrayInLibrary;

@property (nonatomic,retain) NSArray *pictureType;
@property (nonatomic,retain) NSArray *movieType;

@property (nonatomic,retain) NSMutableArray *songArray;
@property (nonatomic,retain) NSMutableArray *albumArray;
@property (nonatomic,retain) NSMutableArray *genersArray;
@property (nonatomic,retain) NSMutableArray *artistArray;
@property (nonatomic,retain) NSMutableArray *galleryArray;

@property (nonatomic,retain) id delegate;

@property (nonatomic,retain)NSArrayController *songArrayController;
@end

@protocol ImportProgressDelegate
- (void)sreachProgress:(NSInteger)step filename:(NSString*)name contextInfo:(id)context;
@end