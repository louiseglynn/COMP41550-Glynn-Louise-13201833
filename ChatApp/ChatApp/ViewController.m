//
//  ViewController.m
//  ChatApp
//
//  Created by CSI Student on 10/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

NSURLConnection *theConnection;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // create the request
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.louiseglynn.com/chatapp/chat_send_ajax.php?name=loulou&msg=testywesty"]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
    // create the connection with the request
    // and start loading the data
    theConnection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        
        NSLog(@"connection ok");
        // Create the NSMutableData that will hold
        // the received data
        // receivedData is declared as a method instance elsewhere
        //self.receivedData = [NSMutableData data];
        
        
    } else {
        
        NSLog(@"download can not be made");
        
        // inform the user that the download could not be made
    }
    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [self.receivedData setLength:0];
    NSLog(@"did receive response");
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Received %d bytes of data",[data length]);
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", myString);
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    self.receivedData = [NSMutableData new];
    [self.receivedData appendData:data];
    NSLog(@"Received %d bytes of data",[self.receivedData length]);
    //NSString *myString = [[NSString alloc] initWithData:self.receivedData  encoding:NSUTF8StringEncoding];
    //self.chatWindow.text = myString;
    NSLog(@"did receive data");
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    self.receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    self.receivedData = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
