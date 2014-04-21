//
//  LGLoginViewController.m
//  Chat
//
//  Created by CSI Student on 21/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "LGLoginViewController.h"
#import "LGChatClientViewController.h"

@interface LGLoginViewController ()


@end

@implementation LGLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _passwordField.delegate = self;
    _usernameField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)backgroundTapped:(id)sender{
    [self.view endEditing:YES];
}

- (IBAction)loginClicked:(id)sender {

    
    if([_passwordField.text length] >0 && [_usernameField.text length]){
        
   
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        NSURL *url = [[NSURL alloc]initWithString:@"http://louiseglynn.com/chat/login.php"];
        
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"user=%@&password=%@", _usernameField.text,
                           _passwordField.text] dataUsingEncoding:NSUTF8StringEncoding] ];
        
        [request setHTTPBody:body];
        
        NSHTTPURLResponse *response = nil;
        
        NSError *error = [[NSError alloc]init];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSURLConnection *theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (theConnection) {
            
            NSLog(@"connection ok");
            // Create the NSMutableData that will hold
            // the received data
            // receivedData is declared as a method instance elsewhere
            receivedData = [NSMutableData data];
            
            
        } else {
            
            NSLog(@"download can not be made");
            
            // inform the user that the download could not be made
        }

    }
    
}
    
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

        [receivedData setLength:0];
        
}
    
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    

        [receivedData appendData:data];
        
}
    
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *myString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
     NSLog(@"%@", myString);
    
    if([myString isEqualToString:@"YES"]){
        
        
        [self performSegueWithIdentifier:@"login" sender:self];
        
    }
    else{
        self.errorMessage.text = @"Username/Password Error!";
        [self.errorMessage sizeToFit];
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [segue.destinationViewController setUsername:self.usernameField.text];
    
}


@end
