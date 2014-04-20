//
//  BNRCoursesController.m
//  NerdFeed
//
//  Created by CSI Student on 19/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRCoursesController.h"

@interface BNRCoursesController() <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end

@implementation BNRCoursesController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:style];
    
    if(self){
        
        self.navigationItem.title = @"BNR Courses";
        
        NSURLSessionConfiguration *config =  [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //_session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        
        [self fetchFeed];
    }
    return self;
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
    
}

-(void)fetchFeed{
    
    //NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSString *requestString = @"http://bookapi.bignerdranch.com/private/courses.json";
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", json);
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //NSLog(@"%@", jsonObject);
        self.courses = jsonObject[@"courses"];
        
        NSLog(@"%@", self.courses);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
    [dataTask resume];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.courses count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSDictionary *course = self.courses[indexPath.row];
    
    cell.textLabel.text = course[@"title"];
    
    return cell;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}


@end
