//
//  PhotosTVC.m
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "PhotosTVC.h"
#import "PhotoVC.h"
#import "FlickrFetcher.h"

@interface PhotosTVC ()
@property (nonatomic, strong) NSArray *photos;
@end

@implementation PhotosTVC

- (void)setDataModel:(NSDictionary *)dataModel
{
    _dataModel = dataModel;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    NSURL *url = [FlickrFetcher urlForPhotosInPlace:self.dataModel[FLICKR_PLACE_ID] andTag:self.dataModel[FLICKR_PLACE_NAME]];
    self.navigationItem.title = self.dataModel[FLICKR_PLACE_NAME];
    [FlickrFetcher startFlickrFetch:url completion:^(NSData *jsonData) {
        if (jsonData)
        {
            NSDictionary *plistDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
            self.photos = [plistDict valueForKeyPath:FLICKR_PHOTOS];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [spinner stopAnimating];
                self.navigationItem.rightBarButtonItem = button;
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.photos[indexPath.row][FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = self.photos[indexPath.row][FLICKR_PHOTO_OWNER];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.contentView.frame.size.height, cell.contentView.frame.size.height), NO, 0.0);
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIGraphicsEndImageContext();
    
    NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatSquare];
    [FlickrFetcher startFlickrFetch:url completion:^(NSData *jsonData) {
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show PhotoVC"])
    {
        UITableViewCell *cell =  (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
 
        [segue.destinationViewController setPhotoURL:[FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatMedium640] setDict:self.photos[indexPath.row]];
  
        [segue.destinationViewController navigationItem].title = cell.textLabel.text;
    }
    

}

@end
