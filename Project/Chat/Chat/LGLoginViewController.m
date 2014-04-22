//
//  LGLoginViewController.m
//  Chat
//
//  Created by CSI Student on 21/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "LGLoginViewController.h"
#import "LGChatClientViewControllerNew.h"

@interface LGLoginViewController ()


@end

@implementation LGLoginViewController


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

    
    NSLog(@"login clicked");
    
    
    if([_passwordField.text length] >0 && [_usernameField.text length]){
        
        NSLog(@"ok");
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        NSURL *url = [[NSURL alloc]initWithString:@"http://louiseglynn.com/chat/login.php"];
        
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"user=%@&password=%@", _usernameField.text,
                           _passwordField.text] dataUsingEncoding:NSUTF8StringEncoding] ];
        
        [request setHTTPBody:body];
        
        [NSURLConnection connectionWithRequest:request delegate:self];
        
    }
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"did fail with error");
    
    [self performSegueWithIdentifier:@"loginConError" sender:self];
    
}
    
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSLog(@"did receive response");

    receivedData = [NSMutableData data];
    
}
    
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    NSLog(@"did receive data");
    [receivedData appendData:data];
        
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    
    return nil;
    
}
    
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"connection finished loading");
    
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
    
    NSLog(@"prepare for segue");
    
    if([segue.identifier isEqualToString:@"login"]){
        [segue.destinationViewController setUsername:self.usernameField.text];
    }
    
}




@end
