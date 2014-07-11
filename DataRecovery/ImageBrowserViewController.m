//
//  ImageBrowserViewController.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-3.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "MyImageObject.h"
#import "iTunesDataRecoveryViewController.h"
#import "AppDelegate.h"

//@interface M

//@end

@interface ImageBrowserViewController ()

@end

@implementation ImageBrowserViewController

@synthesize data;
@synthesize app;
@synthesize itunesDataRecoveryViewControllerApp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        images=[[NSMutableArray alloc]init];
        importedImages=[[NSMutableArray alloc]init];
        
            }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

-(void)awakeFromNib
{

    
    [_imageBrowser setAllowsReordering:YES];
    [_imageBrowser setAnimates:YES];
    [_imageBrowser setDraggingDestinationDelegate:self];
    [_imageBrowser setCellsStyleMask:IKCellsStyleTitled| IKCellsStyleOutlined];
    
    
//    MyImageObject *p=[[MyImageObject alloc]init];
//    NSString *tempPath=@"/Users/mac1/Desktop/屏幕快照 2014-06-25 下午3.13.17.png";
//    
//    [p setPath:tempPath];
//    [importedImages addObject:p];
//    [images addObject:p];
//    [p release];
//    
//    
//   //images=[self addImages];
//    
//    [_imageBrowser reloadData];
    
    
//   if(!self.data.photosData){
//    self.data=[[Data alloc]init];
//    }
    
    
    self.data=[[Data alloc]init];

    
    for (int i=0; i<[self.data.photosData count]-1; i++) {
        MyImageObject *p=[[MyImageObject alloc]init];
        [p setPath:[self.data.photosData objectAtIndex:i]];
    
        [importedImages addObject:p];
        [images addObject:p];
        [p release];
         NSLog(@"图片数量 %lus",[images count]);
    }
    
   
      [_imageBrowser reloadData];

 
}

-(NSMutableArray*)addImages
{
    NSMutableArray *tempArray=[[NSMutableArray alloc]init];

    MyImageObject *p=[[MyImageObject alloc]init];
    NSString *tempPath=[[NSString alloc]init];
    
    for (int i=0; i<[self.itunesDataRecoveryViewControllerApp.photoData count]; i++) {
       tempPath=[self.itunesDataRecoveryViewControllerApp.photoData  objectAtIndex:i];
        [p setPath:tempPath];
        [tempArray addObject:p];
    }
    [p release];
    [tempPath release];
    return images;
}
//-(IBAction)addFiles:(id)sender
//{
//    MyImageObject *p=[[MyImageObject alloc]init];
//    NSString *tempPath=@"/Users/mac1/Desktop/屏幕快照 2014-06-25 下午3.13.17.png";
//    
//    [p setPath:tempPath];
//    [importedImages addObject:p];
//    [images addObject:p];
//    
//    [_imageBrowser reloadData];
//    
//    [p release];
//
//}

- (void)updateDatasource
{
    //-- update our datasource, add recently imported items
    [images addObjectsFromArray:importedImages];
	
	//-- empty our temporary array
    [importedImages removeAllObjects];
    
    //-- reload the image browser and set needs display
    [_imageBrowser reloadData];
}


#pragma mark -
#pragma mark IKImageBrowserDataSource

/* implement image-browser's datasource protocol
 Our datasource representation is a simple mutable array
 */

- (NSUInteger)numberOfItemsInImageBrowser:(IKImageBrowserView *)view
{
	/* item count to display is our datasource item count */
    return [images count];
}

- (id)imageBrowser:(IKImageBrowserView *)view itemAtIndex:(NSUInteger)index
{
    
    for (int i = 0 ; i<[images count]; i++) {
        NSLog(@"%@",[[images objectAtIndex:i] path]);
    }
    
    return [images objectAtIndex:index];
}


/* implement some optional methods of the image-browser's datasource protocol to be able to remove and reoder items */

/*	remove
 The user wants to delete images, so remove these entries from our datasource.
 */
//- (void)imageBrowser:(IKImageBrowserView *)view removeItemsAtIndexes:(NSIndexSet *)indexes
//{
//	[images removeObjectsAtIndexes:indexes];
//}

// reordering:
// The user wants to reorder images, update our datasource and the browser will reflect our changes
//- (BOOL)imageBrowser:(IKImageBrowserView *)view moveItemsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)destinationIndex
//{
//    NSUInteger index;
//    NSMutableArray *temporaryArray;
//    
//    temporaryArray = [[[NSMutableArray alloc] init] autorelease];
//    
//    /* first remove items from the datasource and keep them in a temporary array */
//    for (index = [indexes lastIndex]; index != NSNotFound; index = [indexes indexLessThanIndex:index])
//    {
//        if (index < destinationIndex)
//            destinationIndex --;
//        
//        id obj = [images objectAtIndex:index];
//        [temporaryArray addObject:obj];
//        [images removeObjectAtIndex:index];
//    }
//    
//    /* then insert removed items at the good location */
//    NSInteger n = [temporaryArray count];
//    for (index=0; index < n; index++)
//    {
//        [images insertObject:[temporaryArray objectAtIndex:index] atIndex:destinationIndex];
//    }
//	
//    return YES;
//}


#pragma mark -
#pragma mark drag n drop

/* Drag'n drop support, accept any kind of drop */
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSData *data = nil;
    NSString *errorDescription;
	
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    
	/* look for paths in pasteboard */
    if ([[pasteboard types] containsObject:NSFilenamesPboardType])
        data = [pasteboard dataForType:NSFilenamesPboardType];
    
    if (data)
    {
		/* retrieves paths */
        NSArray *filenames = [NSPropertyListSerialization propertyListFromData:data
                                                              mutabilityOption:kCFPropertyListImmutable
                                                                        format:nil
                                                              errorDescription:&errorDescription];
        
        
		/* add paths to our datasource */
        NSInteger i;
        NSInteger n = [filenames count];
        for (i=0; i<n; i++){
            [self addAnImageWithPath:[filenames objectAtIndex:i]];
        }
		
		/* make the image browser reload our datasource */
        [self updateDatasource];
    }
    
	/* we accepted the drag operation */
	return YES;
}


@end
