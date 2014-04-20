//
//  PhotoVC.m
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "PhotoVC.h"
#import "FlickrFetcher.h"
#import "LGAppDelegate.h"
#import "Photo+Flickr.h"


@interface PhotoVC ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation PhotoVC

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        _context = ((LGAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return _context;
}

- (IBAction)saveToFavs:(id)sender {

    
    [Photo photoWithDict:self.dict inManagedObjectContext:self.context];

}


- (void)setPhotoURL:(NSURL *)photoURL setDict:(NSDictionary *)dict
{
    if(dict){
        _dict = dict;
        _saveButton.enabled = true;
    }
    else{
        _saveButton.enabled = false;
    }
    
    _photoURL = photoURL;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    [FlickrFetcher startFlickrFetch:_photoURL completion:^(NSData *data) {
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
                [spinner stopAnimating];
                self.navigationItem.rightBarButtonItem = button;
            });
        }
    }];
    


    
}







@end
