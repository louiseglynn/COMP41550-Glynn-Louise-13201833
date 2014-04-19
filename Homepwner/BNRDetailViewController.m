//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by CSI Student on 17/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"


@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@end

@implementation BNRDetailViewController

-(void)save:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancel:(id)sender{
    
    [[BNRItemStore sharedStore]removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


-(instancetype)initForNewItem:(BOOL)isNew{
    
    self = [super initWithNibName:nil bundle:nil];
    
    if(self){
        if(isNew){
            
            UIBarButtonItem *doneItem =  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem" userInfo:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    
    [self.view endEditing:YES];
}

-(void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation{
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        return;
    }
    
    if(UIInterfaceOrientationIsLandscape(orientation)){
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }
    else{
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    [self prepareViewsForOrientation:toInterfaceOrientation];
}

- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.imageKey];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)setItem:(BNRItem *)item{
    
    _item = item;
    self.navigationItem.title = _item.name;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIInterfaceOrientation io = [[UIApplication sharedApplication]statusBarOrientation];
    
    [self prepareViewsForOrientation:io];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.name;
    self.numberField.text = item.number;
    
    NSString  *key = self.item.imageKey;
    
    UIImage *imageToDisplay = [[BNRImageStore sharedStore]imageForKey:key];
    
    self.imageView.image = imageToDisplay;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    
    item.name = self.nameField.text;
    item.number = self.numberField.text;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"function called");
    [textField resignFirstResponder];
    return YES;
}


@end
