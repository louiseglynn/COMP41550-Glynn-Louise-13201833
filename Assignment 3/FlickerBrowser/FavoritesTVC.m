//
//  FavoritesTVC.m
//  FlickerBrowser
//
//  Created by CSI Student on 20/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "FavoritesTVC.h"
#import "LGAppDelegate.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"
#import "PhotoVC.h"


@interface FavoritesTVC ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation FavoritesTVC

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        _context = ((LGAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return _context;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    

    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;

    cell.detailTextLabel.text = photo.owner;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.contentView.frame.size.height, cell.contentView.frame.size.height), NO, 0.0);
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIGraphicsEndImageContext();
    
    
    [FlickrFetcher startFlickrFetch:[NSURL URLWithString:photo.imageURL] completion:^(NSData *jsonData) {
        if (jsonData)
        {
            UIImage *thumbnailImage = [UIImage imageWithData:jsonData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = thumbnailImage;
            });
        }
    }];
    return cell;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[PhotoVC class]])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
  
        
        [segue.destinationViewController setPhotoURL:[NSURL URLWithString:photo.imageURL] setDict:NULL];
        
        [segue.destinationViewController navigationItem].title = photo.title;

    }
    
    
    
}

@end
